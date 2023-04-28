//
//  ViewController.swift
//  PlankImprover
//
//  Created by kangajan kuganathan on 2023-04-22.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {
    
    //create firebaseAuth Object
    var firebaseAuth = FirebaseAuth()
    
    //define UIElements
    lazy var loginTitle:UILabel = {
        var label = UILabel()
        label.text = "Log In"
        label.textColor = .black
        label.font = UIFont(name: "LexendTera-ExtraBold", size: 35)
        return label
    }()
    
    lazy var emailTextField:LoginTextField = {
        var textField = LoginTextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Enter Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        return textField
    }()
    
    lazy var passWordTextField:LoginTextField = {
        var textField = LoginTextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Enter Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        return textField
    }()
    
    lazy var loginButton:customBigButton = {
        var button = customBigButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    lazy var devider:UILabel = {
        var label = UILabel()
        label.text = "OR"
        label.textAlignment = .center
        label.font = UIFont(name: "LexendTera-ExtraBold", size: 15)
        return label
    }()
    
    lazy var googleSignInButton:GIDSignInButton = {
        var button = GIDSignInButton()
        button.layer.cornerRadius = 15
        button.addTarget(.none, action: #selector(googleSignIn), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "loginBackgroundImage")!)
        setupBackground()
    }
}

