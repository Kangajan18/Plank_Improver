//
//  TimerViewController+Extention.swift
//  PlankImprover
//
//  Created by kangajan kuganathan on 2023-04-28.
//

import UIKit

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
