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

    // Declare the binding closure
    var bindLeaguestoFavoriteLeaguesViewController: (() -> ()) = {}
    
    var leagues : [League]? {
        didSet {
            // Bind data everytime leagues reloads/changes
            bindLeaguestoFavoriteLeaguesViewController()
        }
    }
    
    // Fetch favorite leagues from the database
    func getFavoriteLeagues() {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LeagueEntity")
        do
        {
            let fetchedLeagues = try managedContext.fetch(fetchRequest)
            leagues = [League]()
            
            // Fill the leagues array from the database NSManagedObjects
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
    
    // Delete a favorite league from the database
    func deleteLeagueFromFavorites(league: League) {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LeagueEntity")
        
        // Set the predicate with the selected league id
        let selectedLeagueId = NSPredicate(format: "idLeague == %@", league.idLeague ?? "")
        fetchRequest.predicate = selectedLeagueId
        
        do {
            let favoriteLeagues = try managedContext.fetch(fetchRequest)
            if favoriteLeagues.count > 0 {
                managedContext.delete(favoriteLeagues.first!)
                appDelegate.saveContext()
            }
            
        } catch let error as NSError
        {
            print(error)
        }
    }
}
