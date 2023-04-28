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

