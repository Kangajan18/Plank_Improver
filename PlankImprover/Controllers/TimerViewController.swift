//
//  HomeViewController.swift
//  PlankImprover
//
//  Created by kangajan kuganathan on 2023-04-23.
//

import UIKit

@available(iOS 13.0, *)
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
        button.addTarget(self, action: #selector(restartTimer), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    lazy var dayLabel:UILabel = {
        var dayLabel = UILabel()
        dayLabel.textColor = .white
        dayLabel.font = UIFont.boldSystemFont(ofSize: 20)
        dayLabel.text = "Day:"
        return dayLabel
    }()

    //define Properties
    var daysViewController = DaysViewController()
    var plankTime:Int?
    var circularProgressBarView: CircularProgressBarView!
    var circularViewDuration: TimeInterval?
    var currentCount:Int = 1
    var isTimerStart = false
    var timer : Timer?
    var day:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        view.backgroundColor = .black
        setupBackground()
        
    }
    
    //in feature is say start counter going to start.
    @objc
    func tapFunction(sender:UITapGestureRecognizer) {
        if isTimerStart == false {
            timeLabel.text = ""
            startTimer()
            isTimerStart = true
        }
    }
    
    func plankConformation() {
        let uiAlert = UIAlertController(title: "Are you Sure to Complete Your Plank Successfully.", message: "", preferredStyle: .alert)
        
        let uiAction1 = UIAlertAction(title: "Yes", style: .default) { [weak self] UIAlertAction in
            if let currentDay = self?.day, let currentPlankTime = self?.plankTime{
                self?.daysViewController.createNextDay(day: currentDay, second: currentPlankTime)
                let dayViewController = DaysViewController()
                self?.navigationController?.pushViewController(dayViewController, animated: false)
            }
        }
        
        let uiAction = UIAlertAction(title: "No", style: .default) { [weak self] UIAlertAction in
            self?.restartTimer()
        }
        
        uiAlert.addAction(uiAction)
        uiAlert.addAction(uiAction1)
        present(uiAlert, animated: true)
    }
}

//MARK: - Timer
@available(iOS 13.0, *)
extension TimerViewController {
    
    func startTimer() {
        
        UIView.transition(with: timeLabel,
                          duration: 0.25,
                          options: .transitionFlipFromRight,
                          animations: { [weak self] in
            self?.timeLabel.text = "Ready"
        }, completion: nil)
        
        //call timer
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        // set view
        circularProgressBarView = CircularProgressBarView(frame: .zero)
        // align to the center of the screen
        circularProgressBarView.center = view.center
        // call the animation with circularViewDuration
        circularProgressBarView.progressAnimation(duration: circularViewDuration!)
        // add this view to the view controller
        view.addSubview(circularProgressBarView)
    }
    
    @objc func updateTime() {
        if currentCount <= plankTime!{
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
            plankConformation()
        }
    }
    
    @objc func restartTimer() {
        currentCount = 1
        isTimerStart = false
        timer?.invalidate()
        startTimer()
    }
}

//MARK: - setupBacground
@available(iOS 13.0, *)
extension TimerViewController {
    
    func setupBackground() {
        view.addSubview(dayLabel)
        view.addSubview(timeLabel)
        view.addSubview(restartButton)
        
        //set current day
        dayLabel.text = "Day: \(String(describing: day!))"
        
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            dayLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 20),
            dayLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            dayLabel.heightAnchor.constraint(equalToConstant: 50),
            
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            restartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -100),
            restartButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 20),
            restartButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -20),
            restartButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
    }
}
