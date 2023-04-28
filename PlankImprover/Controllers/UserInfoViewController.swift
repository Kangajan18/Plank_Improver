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
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //define properties
    var plankTime:Int?
    var nextPlankIncrement:Int?
    var keepDay:Int?
    
    //define uiElements
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
    
    let questionOneAnswers = [Int](1...2000)
    
    var questionOnePickerView = UIPickerView()
    
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
    
    let questionTwoAnswers = [Int](1...10)
    
    var questionTwoPickerView = UIPickerView()
    
    
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
    
    let questionThreeAnswers = [Int](1...10)
    
    var questionThreePickerView = UIPickerView()
    
    
    
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
    
    //save
    func saveCoreData() {
        do{
            try context.save()
        }catch {
            print("Error Occur while Save data , \(error)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUPBackground()
    }
    
    
    private func setUPBackground() {
        view.addSubview(screenTitle)
        view.addSubview(screenSubTitle)
        view.addSubview(questionOneTextField)
        view.addSubview(questionTwoTextField)
        view.addSubview(questionThreeTextField)
        view.addSubview(submitButton)
        
        screenTitle.translatesAutoresizingMaskIntoConstraints = false
        screenSubTitle.translatesAutoresizingMaskIntoConstraints = false
        questionOneTextField.translatesAutoresizingMaskIntoConstraints = false
        questionTwoTextField.translatesAutoresizingMaskIntoConstraints = false
        questionThreeTextField.translatesAutoresizingMaskIntoConstraints = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        questionOneTextField.inputView = questionOnePickerView
        questionOnePickerView.delegate = self
        questionOnePickerView.dataSource = self
        questionOnePickerView.tag = 1
        
        questionTwoTextField.inputView = questionTwoPickerView
        questionTwoPickerView.delegate = self
        questionTwoPickerView.dataSource = self
        questionTwoPickerView.tag = 2
        
        questionThreeTextField.inputView = questionThreePickerView
        questionThreePickerView.delegate = self
        questionThreePickerView.dataSource = self
        questionThreePickerView.tag = 3
        
        NSLayoutConstraint.activate([
            screenTitle.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 30),
            screenTitle.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -30),
            screenTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            screenTitle.heightAnchor.constraint(equalToConstant: 40),
            
            screenSubTitle.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 20),
            screenSubTitle.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -20),
            screenSubTitle.topAnchor.constraint(equalTo: screenTitle.bottomAnchor,constant: 10),
            screenSubTitle.heightAnchor.constraint(equalToConstant: 60),
            
            questionOneTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 10),
            questionOneTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -10),
            questionOneTextField.topAnchor.constraint(equalTo: screenSubTitle.bottomAnchor,constant: 160),
            questionOneTextField.heightAnchor.constraint(equalToConstant: 40),
            
            questionTwoTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 10),
            questionTwoTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -10),
            questionTwoTextField.topAnchor.constraint(equalTo: questionOneTextField.bottomAnchor,constant: 20),
            questionTwoTextField.heightAnchor.constraint(equalToConstant: 40),
            
            questionThreeTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 10),
            questionThreeTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -10),
            questionThreeTextField.topAnchor.constraint(equalTo: questionTwoTextField.bottomAnchor,constant: 20),
            questionThreeTextField.heightAnchor.constraint(equalToConstant: 40),
            
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.topAnchor.constraint(equalTo: questionThreeTextField.bottomAnchor,constant: 80),
            submitButton.heightAnchor.constraint(equalToConstant: 50),
            submitButton.widthAnchor.constraint(equalToConstant: 250),
        ])
        
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

@available(iOS 13.0, *)
extension UserInfoViewController:UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag{
        case 1:
            return questionOneAnswers.count
        case 2:
            return questionTwoAnswers.count
        case 3:
            return questionThreeAnswers.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag{
        case 1:
            return String(questionOneAnswers[row])
        case 2:
            return String(questionTwoAnswers[row])
        case 3:
            return String(questionThreeAnswers[row])
        default:
            return "Data not found"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.view.endEditing(true)
        switch pickerView.tag{
        case 1:
            questionOneTextField.text = String("Current Plank Timing \(questionOneAnswers[row]) seconds")
            plankTime = questionThreeAnswers[row]
            questionOneTextField.resignFirstResponder()
        case 2:
            questionTwoTextField.text = String("Increace by \(questionTwoAnswers[row]) seconds")
            nextPlankIncrement = questionThreeAnswers[row]
            questionTwoTextField.resignFirstResponder()
        case 3:
            questionThreeTextField.text = String("Keep \(questionThreeAnswers[row]) days")
            keepDay = questionThreeAnswers[row]
            questionThreeTextField.resignFirstResponder()
        default:
            print("Not selected")
        }
    }
}
