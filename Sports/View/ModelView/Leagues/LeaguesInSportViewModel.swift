//
//  LeaguesInSportViewModel.swift
//  Sports
//
//  Created by Abdollah Bakr on 06/06/2022.
//

import Foundation

class LeaguesInSportViewModel {
    
    var bindLeaguestoLeaguesViewController: (() -> ()) = {}
    
    var sport: Sport?
    
    var leagues : [League]? {
        didSet {
            bindLeaguestoLeaguesViewController()
        }
    }
    
    func getAllLeagues(forSport: String) {
        let urlParameter = forSport.replacingOccurrences(of: " ", with: "%20")
        NetworkService.fetchDecodableFromAPI(genericType: LeaguesResponse.self, urlStr: "https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?s=\(urlParameter)", callBack: {[weak self] (response) in
            self?.leagues = response?.countries
        })
    }
}
