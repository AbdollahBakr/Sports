//
//  FavoriteLeaguesTableViewController.swift
//  Sports
//
//  Created by Abdollah Bakr on 13/06/2022.
//

import UIKit

class FavoriteLeaguesTableViewController: UITableViewController {
    
    var leagues = [League]()
    var viewModel: FavoriteLeaguesViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
            }
        }
        // Fetch favorite leagues
        viewModel.getFavoriteLeagues()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getFavoriteLeagues()
        tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leagues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LeagueTableViewCell.identifier, for: indexPath) as? LeagueTableViewCell else { return LeagueTableViewCell()}

        // Configure the cell...
        // Set delegate for youtube button
        cell.delegate = self
        cell.leagueNameLabel.text = leagues[indexPath.row].strLeague
        cell.youtubeStr = leagues[indexPath.row].strYoutube
        let imageUrl = URL(string: leagues[indexPath.row].strBadge!)

        cell.leagueCellImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "sportsPlaceholder"))//), options: [.processor(processor)])
        
        // Configure cell image view
        cell.leagueCellImageView.layer.cornerRadius = 35
        cell.leagueCellImageView.layer.masksToBounds = true
        cell.leagueCellImageView.layer.borderWidth = 2;
        cell.leagueCellImageView.layer.borderColor = CGColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.6)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            viewModel.deleteLeagueFromFavorites(league: leagues[indexPath.row])
            leagues.remove(at: indexPath.row)
            
            // Refresh the tableView
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FavoriteLeaguesTableViewController: LeagueTableViewCellDelegate {
    func didTapYoutubeButton(with link: String) {
//        guard let url = URL(string: link) else { return }
//        UIApplication.shared.open(url)
        print("\(link)")
//        print("\(getYoutubeId(youtubeUrl: link))")
        let playerVC = storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
        playerVC.videoID = link
        present(playerVC, animated: true)
        
    }
    
    func getYoutubeId(youtubeUrl: String) -> String? {
        return URLComponents(string: youtubeUrl)?.queryItems?.first(where: { $0.name == "v" })?.value
    }
}
