<img src="https://github.com/AbdollahBakr/Sports/blob/main/Sports/Assets.xcassets/sportsLogo.imageset/sportsLogo.jpg" width="100">


# Sports App
![alt text](https://github.com/AbdollahBakr/Sports/blob/main/Sports/screenshot.png?raw=true)
Sports final swift project, as part of the ITI-IOS intensive program

## Description

This app consists of multiple screens as follows:
### Sports View
This is the home view presenting all sports that exist in the [Sports API](https://www.thesportsdb.com) in a collection view with the image and name of the sport.

### Leagus View
If any sport is tapped, the app navigates to this view listing all leagues associated with the tapped sports. The leagues are presented in a table view, with each cell consisting of the league badge, name, and a button linked to the home youtube page of that league if exists in the API.

### League Details View
If any cell from the leagues view is tapped, the app navigates to the detail screen of that league. This screen consists of three parts:
1. Horizontal collection view of the upcoming events/matches in that league, filtering -of course- for the future events only (if any). The data contains of the name, date and time of the event.
2. Vertical collection view of the latest results of events/matches with the score, name, of the home and away teams, along with the date and time of the event.
3. Horizontal collection view of the teams participating in that league with the team badge/logo. The team logo is clickable, and when tapped it navigates to the team details screen, with some basic info and image of that team.

The screen also has a favorite button in the top right corner. This button, it tapped, adds the current league to favorites locally on the device.

### Team Details View
This view displays some basic information about the team along with an image representing the team.

### Favorite Leagues View
This view lists all added favorites (from the league details view). These favorite leagues are stored locally using CoreData. When a favorite league is tapped it will navigate to the league details view if there is an internet connection, otherwise it shows an alert indicating that there is no internet connection.


## Getting Started

### Dependencies

* Swift
* CoreData
* Storyboards
* Pods ( Reachability, Kingfisher)

### Installing

* You can clone this repo or download as .zip

### Executing program


* Open the .xcworkspace file
* Make sure that pods are installed and updated
* If not exist, add these pods to the podfile:
```
pod 'Kingfisher', '~> 7.0'
pod 'ReachabilitySwift'
pod 'Alamofire'
```
* Choose your simulator/Device and run

Note: You can omit 'Alamofire' from the podfile if you're not going to use it. I've added it as I'm planning to use it instead of the current implementation



## Authors
[Abdollah Bakr](https://github.com/AbdollahBakr)

## Version History

* 0.2
    * Various bug fixes and optimizations
    * See [commit change]() or See [release history]()
* 0.1
    * Initial Release

## License

This project is not yet licensed.

## Acknowledgments

Inspiration, code snippets, etc.
* [awesome-readme](https://github.com/matiassingers/awesome-readme)
* [Launch Screen Animation](https://github.com/YamamotoDesu/LaunchScreenAnimation)
