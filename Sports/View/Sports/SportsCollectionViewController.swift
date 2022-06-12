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
    
    // Properties
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return sports.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? SportsCollectionViewCell else { return SportsCollectionViewCell()}
    
        // Configure the cell
        let imageUrl = URL(string: sports[indexPath.row].strSportThumb!)
        cell.sportsCellImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "sportsPlaceholder"))
        cell.sportNameLabel.text = sports[indexPath.row].strSport
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width) / 2) 
            return CGSize(width: width, height: width)
    }
    
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedSport = sports[indexPath.item]
//        let leaguesVC = LeaguesTableViewController()
//        leaguesVC.sport = selectedSport
        
//        leaguesVC.performSegue(withIdentifier: "showLeaguesSegue", sender: self)

        performSegue(withIdentifier: "showLeaguesSegue", sender: self)

    }
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
   
}
