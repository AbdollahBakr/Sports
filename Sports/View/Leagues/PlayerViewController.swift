//
//  PlayerViewController.swift
//  Sports
//
//  Created by Abdollah Bakr on 08/06/2022.
//

import UIKit
import youtube_ios_player_helper

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var playerWKWebView: WKWebView!
    @IBOutlet var playerView: YTPlayerView!
    
    var videoID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        playerView.load(withVideoId: videoID)
        guard let myURL = URL(string: "https://\(videoID ?? "")") else { return }
        let myRequest = URLRequest(url: myURL)
        playerWKWebView.load(myRequest)
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
