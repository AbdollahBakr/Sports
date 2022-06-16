//
//  LeagueTableViewCell.swift
//  Sports
//
//  Created by Abdollah Bakr on 05/06/2022.
//

import UIKit
import youtube_ios_player_helper //move to the view controller

class LeagueTableViewCell: UITableViewCell {

    @IBOutlet weak var leagueCellImageView: UIImageView!
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var youtubeButton: UIButton!
        
    static let identifier = "LeagueTableViewCell"
    var delegate: LeagueTableViewCellDelegate? // Make it weak var
    var youtubeStr: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        youtubeButton.imageView?.contentMode = .scaleAspectFit
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func youtubeLinkButton(_ sender: UIButton) {
        delegate?.didTapYoutubeButton(with: youtubeStr ?? "")
    }
}
