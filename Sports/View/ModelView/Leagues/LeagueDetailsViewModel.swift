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
    
    var events : [Event]? {
        didSet {
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
//        let urlParameter = forLeague.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let urlParameter = forLeague.replacingOccurrences(of: " ", with: "%20")
        NetworkService.fetchDecodableFromAPI(genericType: TeamsResponse.self, urlStr: "https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php?l=\(urlParameter)", callBack: {[weak self] (response) in
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
}
