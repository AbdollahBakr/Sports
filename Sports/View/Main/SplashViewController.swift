//
//  SplashViewController.swift
//  Sports
//
//  Created by Abdollah Bakr on 05/06/2022.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet var backgroundGradientView: UIView!
    
    // Create an image view
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        imageView.image = UIImage(named: "sportsLogoTransparent")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set a gradient background
        setGradientBackground()
        
        // Add the image view as a subview
        view.addSubview(imageView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // Center imageView just before the view will layout its subviews
        imageView.center = view.center
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Start animation
            self.animate()
        }
    }
    
    private func animate() {
        
        // Zoom animation
        UIView.animate(withDuration: 3) {
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
        UIView.animate(withDuration: 1.5, animations: {
            self.imageView.alpha = 0
        }, completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")
                    homeViewController?.modalTransitionStyle = .crossDissolve
                    homeViewController?.modalPresentationStyle = .fullScreen
                    self.present(homeViewController!, animated: true)
                }
            }
        })
    }
    
    func setGradientBackground() {
        
        // Create a gradient layer
        let gradientLayer = CAGradientLayer()
        
        // Set the size of the layer to be equal to size of the display
        gradientLayer.frame = view.bounds
        
        // Set an array of Core Graphics colors (.cgColor) to create the gradient
        gradientLayer.colors = [#colorLiteral(red: 0.1725490196, green: 0.3254901961, blue: 0.3921568627, alpha: 1).cgColor, #colorLiteral(red: 0.1254901961, green: 0.2274509804, blue: 0.262745098, alpha: 1).cgColor, #colorLiteral(red: 0.05882352941, green: 0.1254901961, blue: 0.1529411765, alpha: 1).cgColor]
        
        // Rasterize this static layer to improve app performance
        gradientLayer.shouldRasterize = true
        
        // Vertical gradient: top to buttom
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        // Apply the gradient to the backgroundGradientView.
        backgroundGradientView.layer.addSublayer(gradientLayer)
    }

}
