//
//  LaunchViewController.swift
//  PlankImprover
//
//  Created by kangajan kuganathan on 2023-04-22.
//

import UIKit

@available(iOS 13.0, *)
class LaunchViewController: UIViewController {
    
    //create firebaseAuth object
    let firebaseAuth = FirebaseAuth()
    
    //define UIElements
    lazy var backgroundImage:UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(imageLiteralResourceName: "launcherBackgroundImage")
        return imageView
    }()
    
    lazy var titleLabel:UILabel = {
        var titleLabel = UILabel()
        titleLabel.font = UIFont(name: "LexendTera-Light", size: 45)
        titleLabel.numberOfLines = 2
        titleLabel.text = "Plank Planner"
        return titleLabel
    }()
    
    lazy var bottomButton:customBigButton = {
       var button = customBigButton()
        button.setTitle("Let's Start", for: .normal)
        button.setImage(UIImage(imageLiteralResourceName: "arrow"), for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGreen
        setupBackground()
        
        //set button target
        bottomButton.addTarget(.none, action: #selector(launchButtonPressed), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let isSiginIn = firebaseAuth.isUserLogin()
        
        if isSiginIn {
            let viewController = DaysViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }

    @objc private func launchButtonPressed() {
        let nextSecreenVc = LoginViewController()
        navigationController?.pushViewController(nextSecreenVc, animated: true)
    }
}
