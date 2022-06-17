//
//  PlayerViewController.swift
//  Sports
//
//  Created by Abdollah Bakr on 08/06/2022.
//

import UIKit
import youtube_ios_player_helper

class YoutubeViewController: UIViewController {
    
    @IBOutlet weak var youtubeWKWebView: WKWebView!
    
    var youtubePageLink: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize the youtube home page url
        guard let myURL = URL(string: "https://\(youtubePageLink ?? "")") else { return }
        
        // Request the initialized url
        let myRequest = URLRequest(url: myURL)
        
        // Load the web view
        youtubeWKWebView.load(myRequest)
    }

}
