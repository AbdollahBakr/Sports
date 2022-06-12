//
//  LeaguesDetailsViewModel.swift
//  Sports
//
//  Created by Abdollah Bakr on 11/06/2022.
//

import Foundation

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
}
