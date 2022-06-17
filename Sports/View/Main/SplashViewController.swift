//
//  SplashViewController.swift
//  Sports
//
//  Created by Abdollah Bakr on 05/06/2022.
//

import UIKit

class SplashViewController: UIViewController {

    // Create an image view
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        imageView.image = UIImage(named: "sportsLogo")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add the image view as a subview
        view.addSubview(imageView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // Center imageView just before the view will layout its subviews
        imageView.center = view.center
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            // Start animation
            self.animate()
        }
    }
    
    private func animate() {
        
        // Zoom animation
        UIView.animate(withDuration: 2) {
            let size = self.view.frame.size.width * 3
            let deltaX = size - self.view.frame.size.width
            let deltaY = self.view.frame.size.height - size
            
            self.imageView.frame = CGRect(
            x: -(deltaX/2),
            y: deltaY/2,
            width: size,
            height: size
            )

        }
        
        // Fade-out animation
        UIView.animate(withDuration: 1, animations: {
            self.imageView.alpha = 0
        }, completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                    let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")
                    homeViewController?.modalTransitionStyle = .crossDissolve
                    homeViewController?.modalPresentationStyle = .fullScreen
                    self.present(homeViewController!, animated: true)
                }
            }
        })
    }

}
