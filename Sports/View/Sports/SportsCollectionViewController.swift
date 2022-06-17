//
//  SportsCollectionViewController.swift
//  Sports
//
//  Created by Abdollah Bakr on 05/06/2022.
//

import UIKit
import Kingfisher

private let reuseIdentifier = SportsCollectionViewCell.identifier

class SportsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // View Properties
    let indicator = UIActivityIndicatorView(style: .large)
    var viewModel: SportsHomeViewModel!
    var sports = [Sport]()
    var selectedSport: Sport?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set Title to "Sports"
        title = "Sports"
        
        // Start Indicator animated
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
        
        // Initialize the viewModel and set the binding
        viewModel = SportsHomeViewModel()
        viewModel.bindSportstoSportsViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.sports = (self?.viewModel.sports)!
                self?.collectionView.reloadData()
                self?.indicator.stopAnimating()
            }
        }
        // Fetch all sports
        viewModel.getAllSports()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.

        let leaguesVC = segue.destination as! LeaguesTableViewController
        leaguesVC.sport = selectedSport
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // Return one section
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return the count of the collection view items
        return sports.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Initialize the cell as SportsCollectionViewCell (custom collectionView cell)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? SportsCollectionViewCell else { return SportsCollectionViewCell()}
    
        // Configure the cell imageView (sportThumb) and label (sport name)
        let imageUrl = URL(string: sports[indexPath.row].strSportThumb!)
        cell.sportsCellImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "sportsPlaceholder"))
        cell.sportNameLabel.text = sports[indexPath.row].strSport
        
        // Return the configured cell
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // Set the width of the collection view cell to half of the screen width (two cells per row)
        let width = ((collectionView.frame.width) / 2) 
            return CGSize(width: width, height: width)
    }
    
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Set selected sport to perform the cell tapping action
        selectedSport = sports[indexPath.item]
        
        // Perform the segue with leaguesTableViewController
        performSegue(withIdentifier: "showLeaguesSegue", sender: self)

    }
}
