//
//  TeamDetailsViewController.swift
//  Sports
//
//  Created by Abdollah Bakr on 12/06/2022.
//

import UIKit

class TeamDetailsViewController: UIViewController {
    
//    @IBOutlet weak var teamBannerImageView: UIImageView!
    @IBOutlet weak var teamBadgeImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamCountryLabel: UILabel!
    @IBOutlet weak var teamSinceLabel: UILabel!
    @IBOutlet weak var teamSportLabel: UILabel!
    @IBOutlet weak var teamLeagueLabel: UILabel!
    
    var selectedTeam: Team?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        teamNameLabel.text = selectedTeam?.strTeam
        teamCountryLabel.text = selectedTeam?.strCountry
        teamSinceLabel.text = selectedTeam?.intFormedYear
        teamSportLabel.text = selectedTeam?.strSport
        teamLeagueLabel.text = selectedTeam?.strLeague
        
        // Banner
//        let bannerUrl = URL(string: selectedTeam?.strTeamBanner ?? "")
//        teamBannerImageView.kf.setImage(with: bannerUrl, placeholder: UIImage(named: "sportsPlaceholder"))
        
        // Badge
        let badgeUrl = URL(string: selectedTeam?.strTeamBadge ?? "")
        teamBadgeImageView.kf.setImage(with: badgeUrl, placeholder: UIImage(named: "sportsPlaceholder"))

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
