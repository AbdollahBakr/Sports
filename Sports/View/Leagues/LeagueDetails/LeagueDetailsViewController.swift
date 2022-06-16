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
    
    // Properties
    let indicator = UIActivityIndicatorView(style: .large)
    var viewModel: LeagueDetailsViewModel!
    var events = [Event]()
    var teams = [Team]()
    var selectedLeague: League?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        viewModel = LeagueDetailsViewModel()
        viewModel.bindEventstoLeagueDetailsViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.events = self?.viewModel.events ?? [Event]()
                self?.upcomingEventsCollectionView.reloadData()
                self?.latestResultsCollectionView.reloadData()
                self?.indicator.stopAnimating()
            }
        }
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func addLeagueToFavorites(_ sender: Any) {
        viewModel.saveLeagueToFavorites(league: selectedLeague ?? League())
        let senderButton = sender as! UIButton
        senderButton.isHidden = true
    }
    
}

extension LeagueDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.upcomingEventsCollectionView:
            return events.count
        case self.latestResultsCollectionView:
            return events.count
        case self.teamsCollectionView:
            return teams.count
        default:
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.upcomingEventsCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingEventsCollectionViewCell.identifier, for: indexPath) as? UpcomingEventsCollectionViewCell else { return UpcomingEventsCollectionViewCell()}
            
    //        cell.upcomingEventsCellImageView.image = UIImage(systemName: "folder.fill")
            cell.eventNameLabel.text = events[indexPath.row].strEvent
            cell.eventDateLabel.text = events[indexPath.row].dateEventLocal
            cell.eventTimeLabel.text = events[indexPath.row].strTimeLocal
            
            return cell
            
        } else if collectionView == self.latestResultsCollectionView {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  LatestResultsCollectionViewCell.identifier, for: indexPath) as? LatestResultsCollectionViewCell else { return LatestResultsCollectionViewCell()}
            
            cell.homeTeamLabel.text = events[indexPath.row].strHomeTeam
            cell.awayTeamLabel.text = events[indexPath.row].strAwayTeam
            cell.homeScoreLabel.text = events[indexPath.row].intHomeScore
            cell.awayScoreLabel.text = events[indexPath.row].intAwayScore
            cell.dateLabel.text = events[indexPath.row].dateEventLocal
            cell.timeLabel.text = events[indexPath.row].strTimeLocal
            
            let imageUrl = URL(string: events[indexPath.row].strThumb ?? "")
            cell.latestResultsImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "sportsPlaceholder"))
            
            return cell
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  TeamsCollectionViewCell.identifier, for: indexPath) as? TeamsCollectionViewCell else { return TeamsCollectionViewCell()}
            
            
            let imageUrl = URL(string: teams[indexPath.row].strTeamBadge ?? "")
            cell.teamImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "sportsPlaceholder"))
            
            // // Configure cell image view for circular image
            cell.teamImageView.contentMode = .scaleAspectFit
            cell.teamImageView.layer.cornerRadius = cell.teamImageView.frame.size.width / 2.3
            cell.teamImageView.layer.masksToBounds = true
            
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width: CGFloat
        var height: CGFloat
        
        if collectionView == self.upcomingEventsCollectionView
         {
            width = collectionView.frame.size.width / 2
            height = width
           
        } else if collectionView == self.latestResultsCollectionView {

            width = collectionView.frame.size.width//1.5
            height = collectionView.frame.size.height//1.5

        } else {
            height = collectionView.frame.size.height/1.5
            width = height
            
            
        }
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "TeamDetailsViewController") as! TeamDetailsViewController
        detailsVC.selectedTeam = teams[indexPath.row]

        present(detailsVC, animated: true)
    }
}
