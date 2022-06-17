//
//  LeaguesDetailsViewController.swift
//  Sports
//
//  Created by Abdollah Bakr on 09/06/2022.
//

import UIKit

class LeagueDetailsViewController: UIViewController {

    @IBOutlet weak var upcomingEventsCollectionView: UICollectionView!
    @IBOutlet weak var latestResultsCollectionView: UICollectionView!
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    @IBOutlet weak var addToFavoritesButton: UIButton!
    
    // View Properties
    let indicator = UIActivityIndicatorView(style: .large)
    var viewModel: LeagueDetailsViewModel!
    
    // Event Properties
    var events = [Event]()
    var upcomingEvents = [Event]()
    var latestResults = [Event]()
    
    // Teams
    var teams = [Team]()
    
    // Selected League
    var selectedLeague: League?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting the delegate and data source of the collection views
        upcomingEventsCollectionView.delegate = self
        upcomingEventsCollectionView.dataSource = self
        latestResultsCollectionView.delegate = self
        latestResultsCollectionView.dataSource = self
        teamsCollectionView.delegate = self
        teamsCollectionView.dataSource = self
        
        // Register LatestResultsCollectionViewCell from XIB
        let latestResultsNipCell = UINib(nibName: "LatestResultsCollectionViewCell", bundle: nil)
        latestResultsCollectionView.register(latestResultsNipCell, forCellWithReuseIdentifier: LatestResultsCollectionViewCell.identifier)
        
        // Start Indicator animated
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
        
        // Initialize the viewModel and set the binding
        // Bind Events
        viewModel = LeagueDetailsViewModel()
        viewModel.bindEventstoLeagueDetailsViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.events = self?.viewModel.events ?? [Event]()
                self?.upcomingEvents = self?.viewModel.upcomingEvents ?? [Event]()
                self?.latestResults = self?.viewModel.latestResults ?? [Event]()
                self?.upcomingEventsCollectionView.reloadData()
                self?.latestResultsCollectionView.reloadData()
                self?.indicator.stopAnimating()
            }
        }
        // Bind Teams
        viewModel.bindTeamstoLeagueDetailsViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.teams = self?.viewModel.teams ?? [Team]()
                self?.teamsCollectionView.reloadData()
                self?.indicator.stopAnimating()
            }
        }
        
        // Fetch all events
        viewModel.getAllEvents(forLeagueId: selectedLeague?.idLeague ?? "")
        // Fetch all teams
        viewModel.getAllTeams(forLeague: selectedLeague?.strLeague ?? "")
        
        // Hide addToFavorites button if selectedLeague is a favorite league
        addToFavoritesButton.isHidden = viewModel.isFavoriteLeague(league: selectedLeague ?? League())
    }
    
    @IBAction func addLeagueToFavorites(_ sender: Any) {
        viewModel.saveLeagueToFavorites(league: selectedLeague ?? League())
        let senderButton = sender as! UIButton
        senderButton.isHidden = true
    }
    
}



extension LeagueDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Return the number of items for each collection view based on their bound data
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
            // Upcoming Events
        case self.upcomingEventsCollectionView:
            return upcomingEvents.count
            
            // Latest Results
        case self.latestResultsCollectionView:
            return latestResults.count
            
            // Teams
        case self.teamsCollectionView:
            return teams.count
            
        default:
            return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Upcoming Events Cell initialization and configuration
        if collectionView == self.upcomingEventsCollectionView {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingEventsCollectionViewCell.identifier, for: indexPath) as? UpcomingEventsCollectionViewCell else { return UpcomingEventsCollectionViewCell()}
            
            cell.eventNameLabel.text = upcomingEvents[indexPath.row].strEvent
            cell.eventDateLabel.text = upcomingEvents[indexPath.row].dateEventLocal
            cell.eventTimeLabel.text = upcomingEvents[indexPath.row].strTimeLocal
            
            cell.layer.cornerRadius = 24
            
            return cell
            
        }
        
        // Latest Results Cell initialization and configuration
        else if collectionView == self.latestResultsCollectionView {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  LatestResultsCollectionViewCell.identifier, for: indexPath) as? LatestResultsCollectionViewCell else { return LatestResultsCollectionViewCell()}
            
            cell.homeTeamLabel.text = latestResults[indexPath.row].strHomeTeam
            cell.awayTeamLabel.text = latestResults[indexPath.row].strAwayTeam
            cell.homeScoreLabel.text = latestResults[indexPath.row].intHomeScore
            cell.awayScoreLabel.text = latestResults[indexPath.row].intAwayScore
            cell.dateLabel.text = latestResults[indexPath.row].dateEventLocal
            cell.timeLabel.text = latestResults[indexPath.row].strTimeLocal
            
            
            cell.latestResultsImageView.image = UIImage(named: "versusIcon")
            
            return cell
            
        }
        
        // Teams Cell initialization and configuration
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  TeamsCollectionViewCell.identifier, for: indexPath) as? TeamsCollectionViewCell else { return TeamsCollectionViewCell()}
            
            
            let imageUrl = URL(string: teams[indexPath.row].strTeamBadge ?? "")
            cell.teamImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "sportsPlaceholder"))
            
            // // Configure cell image view for circular image
            cell.teamImageView.contentMode = .scaleAspectFit
            cell.teamImageView.layer.cornerRadius = cell.teamImageView.frame.size.height / 3
            cell.teamImageView.layer.masksToBounds = true
            
            return cell
        }
        
        
    }
    
    
    // Setting the width and height of the collection view cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width: CGFloat
        var height: CGFloat
        
        // Upcoming events cell size
        if collectionView == self.upcomingEventsCollectionView
         {
            width = (collectionView.frame.size.width / 2) - 15
            height = collectionView.frame.size.height
           
        }
        
        // Latest results cell size
        else if collectionView == self.latestResultsCollectionView {

            width = collectionView.frame.size.width//1.5
            height = collectionView.frame.size.height//1.5

        }
        
        // Teams cell size
        else {
            height = collectionView.frame.size.height/1.5
            width = height
            
            
        }
        
        return CGSize(width: width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Only if team cell is selected
        if collectionView == self.teamsCollectionView {
            
            // Initialize the team details view controller
            let detailsVC = storyboard?.instantiateViewController(withIdentifier: "TeamDetailsViewController") as! TeamDetailsViewController
            detailsVC.selectedTeam = teams[indexPath.row]

            // Present the initialized view controller
            present(detailsVC, animated: true)
        }
        
    }
}
