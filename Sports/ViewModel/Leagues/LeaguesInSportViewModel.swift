//
//  LeaguesInSportViewModel.swift
//  Sports
//
//  Created by Abdollah Bakr on 06/06/2022.
//

import Foundation

class LeaguesInSportViewModel {
    
    // Declare the binding closure
    var bindLeaguestoLeaguesViewController: (() -> ()) = {}
    
    var sport: Sport?
    
    var leagues : [League]? {
        didSet {
            // Bind data everytime leagues reloads/changes
            bindLeaguestoLeaguesViewController()
        }
    }
    
    // Fetch all leagues from the API
    func getAllLeagues(forSport: String) {
        let rawUrlStr = "https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?s=\(forSport)"
        
        // Decode the raw string url to a valid url (e.g. replace spaces with %20)
        let encodedUrlStr: String = rawUrlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        NetworkService.fetchDecodableFromAPI(genericType: LeaguesResponse.self, urlStr: encodedUrlStr, callBack: {[weak self] (response) in
            self?.leagues = response?.countries
        })
    }
}
