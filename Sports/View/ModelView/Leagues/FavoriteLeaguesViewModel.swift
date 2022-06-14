//
//  FavoriteLeaguesViewModel.swift
//  Sports
//
//  Created by Abdollah Bakr on 13/06/2022.
//

import Foundation
import CoreData
import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let managedContext = appDelegate.persistentContainer.viewContext

class FavoriteLeaguesViewModel {

    var bindLeaguestoFavoriteLeaguesViewController: (() -> ()) = {}
    
    var leagues : [League]? {
        didSet {
            bindLeaguestoFavoriteLeaguesViewController()
        }
    }
    
    func getFavoriteLeagues() {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LeagueEntity")
        do
        {
            let fetchedLeagues = try managedContext.fetch(fetchRequest)
            leagues = [League]()
            for fetchedLeague in fetchedLeagues {
                var league = League()
                league.idLeague = fetchedLeague.value(forKey: "idLeague") as? String
                league.strLeague = fetchedLeague.value(forKey: "strLeague") as? String
                league.strBadge = fetchedLeague.value(forKey: "strBadge") as? String
                league.strYoutube = fetchedLeague.value(forKey: "strYoutube") as? String
                
                leagues?.append(league)
            }

        } catch let error as NSError
        {
            print(error)
        }
    }
}
