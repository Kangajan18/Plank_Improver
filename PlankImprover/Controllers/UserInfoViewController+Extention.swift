//
//  UserInfoViewController+Extention.swift
//  PlankImprover
//
//  Created by kangajan kuganathan on 2023-04-28.
//

import UIKit


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

//MARK: - UserInfoView Setup Background
@available(iOS 13.0, *)
extension UserInfoViewController {
    func setUPBackground() {
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
}

//MARK: - CoreData
@available(iOS 13.0, *)
extension UserInfoViewController {
    //save
    func saveCoreData() {
        do{
            try context.save()
        }catch {
            print("Error Occur while Save data , \(error)")
        }
    }
}
