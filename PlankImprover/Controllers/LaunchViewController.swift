//
//  LaunchViewController.swift
//  PlankImprover
//
//  Created by kangajan kuganathan on 2023-04-22.
//

import UIKit

class LaunchViewController: UIViewController {
    
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
    }
    
    private func setupBackground() {
        view.addSubview(backgroundImage)
        view.addSubview(titleLabel)
        view.addSubview(bottomButton)
        
        bottomButton.addTarget(.none, action: #selector(launchButtonPressed), for: .touchUpInside)
                        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 20),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 25),
            titleLabel.widthAnchor.constraint(equalToConstant: 300),
            titleLabel.heightAnchor.constraint(equalToConstant: 150),
            
            bottomButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 70),
            bottomButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -70),
            bottomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -40),
            bottomButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func launchButtonPressed() {
        let nextSecreenVc = LoginViewController()
        navigationController?.pushViewController(nextSecreenVc, animated: true)
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
