//
//  HomeViewController.swift
//  PlankImprover
//
//  Created by kangajan kuganathan on 2023-04-23.
//

import UIKit

class TimerViewController: UIViewController {
    
    //define UIElements
    lazy var timeLabel:UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.text = "Tap To Start"
        let tap = UITapGestureRecognizer(target: self, action: #selector(TimerViewController.tapFunction))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tap)
        return label
    }()
    
    lazy var restartButton:UIButton = {
        var button = UIButton()
        button.setImage(UIImage(imageLiteralResourceName: "restart"), for: .normal)
        button.addTarget(self, action: #selector(restartAction), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        return button
    }()
    //bottomButton.addTarget(.none, action: #selector(launchButtonPressed), for: .touchUpInside)
    //define Properties
    var circularProgressBarView: CircularProgressBarView!
    var circularViewDuration: TimeInterval = 15
    var plankTime:Int = 15
    var currentCount:Int = 1
    var isTimerStart = false
    var timer : Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        navigationController?.viewControllers = [HomeViewController()]
        //        navigationItem.hidesBackButton = true
        view.backgroundColor = .black
        setupBackground()
    }
    
    
    
    func setupBackground() {
        view.addSubview(timeLabel)
        view.addSubview(restartButton)
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        timeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        
        restartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -100),
        restartButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 20),
        restartButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -20),
        restartButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
    }
    
    @objc func restartAction() {
        currentCount = 1
        isTimerStart = false
        timer?.invalidate()
        startTimer()
    }
    
    //in feature is say start counter going to start.
    @objc
    func tapFunction(sender:UITapGestureRecognizer) {
        if isTimerStart == false {
            timeLabel.text = ""
            startTimer()
            isTimerStart = true
        } else {
            timer?.invalidate()
            //study that circularProgress bar
        }
    }
    
    @objc func updateCounter() {
        //example functionality
        if currentCount <= plankTime{
            timeLabel.text = String(currentCount)
            UIView.transition(with: timeLabel,
                              duration: 0.25,
                              options: .transitionFlipFromBottom,
                        animations: { [weak self] in
                self?.timeLabel.text = String(self!.currentCount)
                     }, completion: nil)
            currentCount += 1
        }else{
            UIView.transition(with: timeLabel,
                              duration: 0.25,
                              options: .transitionFlipFromLeft,
                        animations: { [weak self] in
                self?.timeLabel.text = "Done"
                     }, completion: nil)
            timer?.invalidate()
        }
    }
    
    
    func startTimer() {
        
        UIView.transition(with: timeLabel,
                      duration: 0.25,
                          options: .transitionFlipFromRight,
                    animations: { [weak self] in
            self?.timeLabel.text = "Ready"
                 }, completion: nil)
        
        //call timer
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
        
        
        // set view
        circularProgressBarView = CircularProgressBarView(frame: .zero)
        // align to the center of the screen
        circularProgressBarView.center = view.center
        // call the animation with circularViewDuration
        circularProgressBarView.progressAnimation(duration: circularViewDuration)
        // add this view to the view controller
        view.addSubview(circularProgressBarView)
    }
}

