//
//  FavoriteLeaguesTableViewController.swift
//  Sports
//
//  Created by Abdollah Bakr on 13/06/2022.
//

import UIKit
import Reachability

class FavoriteLeaguesTableViewController: UITableViewController {
    
    var leagues = [League]()
    var viewModel: FavoriteLeaguesViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set Title to "Leagues"
        title = "Favorite Leagues"
        
        // Register LeagueTableViewCell from XIB
        let leagueNipCell = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        tableView.register(leagueNipCell, forCellReuseIdentifier: LeagueTableViewCell.identifier)
        
        // Initialize the viewModel and set the binding
        viewModel = FavoriteLeaguesViewModel()
        viewModel.bindLeaguestoFavoriteLeaguesViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.leagues = (self?.viewModel.leagues)!
                self?.tableView.reloadData()
                
                // Notify user if the favorites leagues are empty
                if self?.leagues.count == 0 {
                    self?.notifyIfNoFavorites()
                } else {
                    self?.tableView.backgroundView = nil
                }
            }
        }
        // Fetch favorite leagues
        viewModel.getFavoriteLeagues()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Reload the favorite leagues
        viewModel.getFavoriteLeagues()
        tableView.reloadData()
        
        // Handle the friendly message 'no favorites' if there are no favorite leagues yet
        notifyIfNoFavorites()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return one section
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // return the count of favorite leagues
        return leagues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Initialize tableView cell as custom cell (LeagueTableViewCell)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LeagueTableViewCell.identifier, for: indexPath) as? LeagueTableViewCell else { return LeagueTableViewCell()}

        // Set delegate for youtube button
        cell.delegate = self
        
        // Configure the cell...
        cell.leagueNameLabel.text = leagues[indexPath.row].strLeague
        cell.youtubeStr = leagues[indexPath.row].strYoutube
        
        // Hide youtube button if there is no associated youtube link
        if (cell.youtubeStr ?? "").isEmpty {
            cell.youtubeButton.isHidden = true
        }
        
        // Set the cell imageView
        let imageUrl = URL(string: leagues[indexPath.row].strBadge!)
        cell.leagueCellImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "sportsPlaceholder"))
        
        // Configure cell image view to be circular with border
        cell.leagueCellImageView.layer.cornerRadius = 35
        cell.leagueCellImageView.layer.masksToBounds = true
        cell.leagueCellImageView.layer.borderWidth = 2;
        cell.leagueCellImageView.layer.borderColor = CGColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.6)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Set the height of the cell
        return 70
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            viewModel.deleteLeagueFromFavorites(league: leagues[indexPath.row])
            leagues.remove(at: indexPath.row)
            
            // Refresh the tableView
            tableView.reloadData()
            
            // Notify if there are no favorite leagues
            notifyIfNoFavorites()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Check for internet connection
        let reachability = try! Reachability()
        if reachability.connection != .unavailable {
            // Go to leagueDetailsVC
            let detailsVC = storyboard?.instantiateViewController(withIdentifier: "LeaguesDetailsViewController") as! LeagueDetailsViewController
            detailsVC.selectedLeague = leagues[indexPath.row]

            present(detailsVC, animated: true)
        } else {
            // Alert user in case there is no internet connection
            showAlertCellSelectedWithNoInternet()
        }
        
    }
    
    @IBAction func showAlertCellSelectedWithNoInternet() {

            // create alert
        let alert = UIAlertController(title: "No Internet", message: "Check your internet connection!", preferredStyle: .alert)

            // Add an action with OK button
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

            // Show alert
            self.present(alert, animated: true)
        }

    
    // This functions Handles the friendly message 'no favorites' if there are no favorite leagues yet
    func notifyIfNoFavorites(){
        // Notify user if the favorites leagues are empty
        if leagues.count == 0 {
            // Add message label if there are no favorite leagues
            let noFavoritesLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            
            // Configure the content and look of the message
            noFavoritesLabel.text          = "Favorite Leagues are empty. \nYou can add league to favorites in the details page"
            noFavoritesLabel.textColor     = UIColor.darkGray
            noFavoritesLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
            noFavoritesLabel.numberOfLines = 0
            noFavoritesLabel.textAlignment = .center
            tableView.backgroundView  = noFavoritesLabel
            
        } else {
            
            // Remove message label otherwise
            tableView.backgroundView = nil
        }
    }
    
}

extension FavoriteLeaguesTableViewController: LeagueTableViewCellDelegate {
    
    // Delegated youtube button action
    func didTapYoutubeButton(with link: String) {
        
        // Initialize the youtube web view controller
        let playerVC = storyboard?.instantiateViewController(withIdentifier: "YoutubeViewController") as! YoutubeViewController
        
        // Set the youtube page link
        playerVC.youtubePageLink = link
        
        // Present the youtube web view
        present(playerVC, animated: true)
    }
}
