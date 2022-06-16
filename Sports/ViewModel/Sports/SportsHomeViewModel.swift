//
//  SportsHomeViewModel.swift
//  Sports
//
//  Created by Abdollah Bakr on 06/06/2022.
//

import Foundation

class SportsHomeViewModel {
    
    var bindSportstoSportsViewController: (() -> ()) = {}
    
    var sports : [Sport]? {
        didSet {
            bindSportstoSportsViewController()
        }
    }
    
    func getAllSports() {
        NetworkService.fetchDecodableFromAPI(genericType: SportsResponse.self, urlStr: "https://www.thesportsdb.com/api/v1/json/2/all_sports.php", callBack: {[weak self] (response) in
            self?.sports = response?.sports
        })
    }
}


