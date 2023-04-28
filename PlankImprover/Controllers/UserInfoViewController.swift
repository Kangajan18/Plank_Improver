//
//  UserInfoViewController.swift
//  PlankImprover
//
//  Created by kangajan kuganathan on 2023-04-27.
//

import UIKit
import CoreData

@available(iOS 13.0, *)
class UserInfoViewController: UIViewController {
    
    //create context for CoreData
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //define properties
    var plankTime:Int?
    var nextPlankIncrement:Int?
    var keepDay:Int?
    
    //define Values for viewPickers
    let questionOneAnswers = [Int](1...2000)
    let questionTwoAnswers = [Int](1...10)
    let questionThreeAnswers = [Int](1...10)
    
    //define uiElements
    var questionOnePickerView = UIPickerView()
    var questionTwoPickerView = UIPickerView()
    var questionThreePickerView = UIPickerView()

    lazy var screenTitle:UILabel = {
        var label = UILabel()
        label.text = "New to this app?"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "LexendTera-ExtraBold", size: 20)
        return label
    }()
    
    lazy var screenSubTitle:UILabel = {
        var label = UILabel()
        label.text = "welcome to Plank Improver, this app going make a huge difference into your life."
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "LexendTera-ExtraLight", size: 14)
        return label
    }()
    
    lazy var questionOneTextField:UITextField = {
        var textField = UITextField()
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 12)
        textField.text = "How much seconds your can be in Plank now?"
        textField.backgroundColor = .white
        textField.textAlignment = .center
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    lazy var questionTwoTextField:UITextField = {
        var textField = UITextField()
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 12)
        textField.text = "How many seconds would you like to increase for next Plank?"
        textField.backgroundColor = .white
        textField.textAlignment = .center
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    lazy var questionThreeTextField:UITextField = {
        var textField = UITextField()
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 12)
        textField.text = "How many days you want to keep same time limit?"
        textField.backgroundColor = .white
        textField.textAlignment = .center
        textField.layer.cornerRadius = 5
        return textField
    }()
    

    
    lazy var submitButton:customBigButton = {
        var button = customBigButton()
        button.setTitle("Let's Start", for: .normal)
        button.setImage(UIImage(imageLiteralResourceName: "arrow"), for: .normal)
        button.addTarget(self, action: #selector(submit), for: .touchUpInside)
        return button
    }()
    
    @objc func submit() {
        //create first day
        let plank = Plank(context: context)
        plank.day = 1
        plank.incrementSecond = Int16(nextPlankIncrement!)
        plank.initSecond = Int64(plankTime!)
        plank.keepDay = Int16(keepDay!)
        plank.keepDayCount = Int16(keepDay!)
        plank.isDone = false
        saveCoreData()
        
        let nextScreen = DaysViewController()
        navigationController?.pushViewController(nextScreen, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUPBackground()
    }
}
