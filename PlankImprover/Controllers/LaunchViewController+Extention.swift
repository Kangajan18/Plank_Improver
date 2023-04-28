//
//  LaunchViewController+Extention.swift
//  PlankImprover
//
//  Created by kangajan kuganathan on 2023-04-28.
//

import UIKit

@available(iOS 13.0, *)
//MARK: - LauncherView Background Setup
extension LaunchViewController {
    
    func setupBackground() {
        view.addSubview(backgroundImage)
        view.addSubview(titleLabel)
        view.addSubview(bottomButton)
        
                        
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
}
