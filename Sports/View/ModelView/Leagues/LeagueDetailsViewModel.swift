//
//  LeaguesDetailsViewModel.swift
//  Sports
//
//  Created by Abdollah Bakr on 11/06/2022.
//

import Foundation
import CoreData

class LeagueDetailsViewModel {
    
    var bindEventstoLeagueDetailsViewController: (() -> ()) = {}
    var bindTeamstoLeagueDetailsViewController: (() -> ()) = {}
    
    var league: League?
    var upcomingEvents: [Event]?
    var latestResults: [Event]?
    
    var events : [Event]? {
        didSet {
            
            // Filter for upcoming events
            upcomingEvents = events?.filter {
                isFutureDate(dateEvent: $0.dateEvent ?? "", strTime: $0.strTime ?? "")
            }
            // Filter for latest results
            latestResults = events?.filter {
                !isFutureDate(dateEvent: $0.dateEvent ?? "", strTime: $0.strTime ?? "")
            }.reversed()
            
            // Bind data to view controller
            bindEventstoLeagueDetailsViewController()
        }
    }
    
    var teams : [Team]? {
        didSet {
            bindTeamstoLeagueDetailsViewController()
        }
    }
    
    func getAllEvents(forLeagueId: String) {
        NetworkService.fetchDecodableFromAPI(genericType: EventsResponse.self, urlStr: "https://www.thesportsdb.com/api/v1/json/2/eventsseason.php?id=\(forLeagueId)", callBack: {[weak self] (response) in
            self?.events = response?.events
        })
    }
    
    func getAllTeams(forLeague: String) {
        let rawUrlStr = "https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php?l=\(forLeague)"
        let encodedUrlStr: String = rawUrlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        NetworkService.fetchDecodableFromAPI(genericType: TeamsResponse.self, urlStr: encodedUrlStr, callBack: {[weak self] (response) in
            self?.teams = response?.teams
        })
    }
    
    func saveLeagueToFavorites(league: League) {
        // handle if league already exists in favorites
    
        let entity = NSEntityDescription.entity(forEntityName: "LeagueEntity", in: managedContext)!
        let leagueEntityObj = NSManagedObject(entity: entity, insertInto: managedContext)
        
        leagueEntityObj.setValue(league.idLeague, forKey: "idLeague")
        leagueEntityObj.setValue(league.strLeague, forKey: "strLeague")
        leagueEntityObj.setValue(league.strBadge, forKey: "strBadge")
        leagueEntityObj.setValue(league.strYoutube, forKey: "strYoutube")
        
        appDelegate.saveContext()
        print("League saved to the database")
    }
    
    func isFavoriteLeague(league: League) -> Bool {
        var foundAsFavoriteLeague = false
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LeagueEntity")
        let selectedLeagueId = NSPredicate(format: "idLeague == %@", league.idLeague ?? "")
        fetchRequest.predicate = selectedLeagueId
        
        do {
            let favoriteLeagues = try managedContext.fetch(fetchRequest)
            if favoriteLeagues.count > 0 {
                foundAsFavoriteLeague = true
            }

        } catch let error as NSError
        {
            print(error)
        }
        return foundAsFavoriteLeague
    }
    
    // Filter upcoming events
    func isFutureDate(dateEvent: String, strTime: String) -> Bool {
        let dateStr = dateEvent + " " + strTime
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let eventDateTime = formatter.date(from: dateStr)
        
        // In case of invalid format from API, return false
        return eventDateTime ?? Date.now > Date.now
    }
    
    // Sort upcoming events (no need to sort, they are already sorted)

}
