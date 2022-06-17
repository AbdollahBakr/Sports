//
//  LeaguesTableViewController.swift
//  Sports
//
//  Created by Abdollah Bakr on 05/06/2022.
//

import UIKit
import Kingfisher
import youtube_ios_player_helper

class LeaguesTableViewController: UITableViewController {

    // View Properties
    let indicator = UIActivityIndicatorView(style: .large)
    var viewModel: LeaguesInSportViewModel!
    var sport: Sport?
    var leagues = [League]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Title to "Leagues"
        title = "Leagues"
        
        // Register LeagueTableViewCell from XIB
        let leagueNipCell = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        tableView.register(leagueNipCell, forCellReuseIdentifier: LeagueTableViewCell.identifier)
        
        // Start Indicator animated
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
        
        // Initialize the viewModel and set the binding
        viewModel = LeaguesInSportViewModel()
        viewModel.bindLeaguestoLeaguesViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.leagues = (self?.viewModel.leagues)!
                self?.tableView.reloadData()
                self?.indicator.stopAnimating()
            }
        }
        // Fetch all leagues
        viewModel.getAllLeagues(forSport: sport?.strSport ?? "")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return one section
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the count of league cells
        return leagues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Initialize the tableView cell as custom cell (LeagueTableViewCell)
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

        // Set cell imageView with league badge
        let imageUrl = URL(string: leagues[indexPath.row].strBadge!)
        cell.leagueCellImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "sportsPlaceholder"))
        
        // Configure cell image view for circular image with border
        cell.leagueCellImageView.layer.cornerRadius = 35
        cell.leagueCellImageView.layer.masksToBounds = true
        cell.leagueCellImageView.layer.borderWidth = 2;
        cell.leagueCellImageView.layer.borderColor = CGColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.6)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Set the cell height
        return 70
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Initialize LeagueDetailsViewController with the selected league
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "LeaguesDetailsViewController") as! LeagueDetailsViewController
        detailsVC.selectedLeague = leagues[indexPath.row]

        // Present the initialized view controller
        present(detailsVC, animated: true)
    }

}


extension LeaguesTableViewController: LeagueTableViewCellDelegate {
    
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
