//
//  TeamDetailsViewController.swift
//  Sports
//
//  Created by Abdollah Bakr on 12/06/2022.
//

import UIKit

class TeamDetailsViewController: UIViewController {
    
    @IBOutlet weak var teamBadgeImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamCountryLabel: UILabel!
    @IBOutlet weak var teamSinceLabel: UILabel!
    @IBOutlet weak var teamSportLabel: UILabel!
    @IBOutlet weak var teamLeagueLabel: UILabel!
    
    var selectedTeam: Team?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure the team details UI
        teamNameLabel.text = selectedTeam?.strTeam
        teamCountryLabel.text = selectedTeam?.strCountry
        teamSinceLabel.text = selectedTeam?.intFormedYear
        teamSportLabel.text = selectedTeam?.strSport
        teamLeagueLabel.text = selectedTeam?.strLeague
        
        // Team Badge
        let badgeUrl = URL(string: selectedTeam?.strTeamBadge ?? "")
        teamBadgeImageView.kf.setImage(with: badgeUrl, placeholder: UIImage(named: "sportsPlaceholder"))

    }

}
