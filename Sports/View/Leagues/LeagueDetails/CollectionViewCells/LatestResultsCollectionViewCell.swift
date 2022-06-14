//
//  LatestResultsCollectionViewCell.swift
//  Sports
//
//  Created by Abdollah Bakr on 11/06/2022.
//

import UIKit

class LatestResultsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var latestResultsImageView: UIImageView!
    @IBOutlet weak var homeTeamLabel: UILabel!
    @IBOutlet weak var awayTeamLabel: UILabel!
    @IBOutlet weak var homeScoreLabel: UILabel!
    @IBOutlet weak var awayScoreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    static let identifier = "LatestResultsCollectionViewCell"
}
