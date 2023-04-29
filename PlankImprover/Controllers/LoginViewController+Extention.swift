//
//  LoginViewController+Extention.swift
//  PlankImprover
//
//  Created by kangajan kuganathan on 2023-04-28.
//

import UIKit
import GoogleSignIn
import Firebase

//MARK: - LoginViewBackgroundSetup
extension LoginViewController {
    
    func setupBackground() {
        view.addSubview(loginTitle)
        view.addSubview(emailTextField)
        view.addSubview(passWordTextField)
        view.addSubview(loginButton)
        view.addSubview(devider)
        view.addSubview(googleSignInButton)
        
        loginTitle.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passWordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        devider.translatesAutoresizingMaskIntoConstraints = false
        googleSignInButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginTitle.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 20),
            loginTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            loginTitle.widthAnchor.constraint(equalToConstant: 300),
            loginTitle.heightAnchor.constraint(equalToConstant: 150),
            
            emailTextField.topAnchor.constraint(equalTo: loginTitle.bottomAnchor,constant: 0),
            emailTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 20),
            emailTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passWordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passWordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor,constant: 20),
            passWordTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 20),
            passWordTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -20),
            passWordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passWordTextField.bottomAnchor,constant: 50),
            loginButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 20),
            loginButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            devider.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 30),
            devider.topAnchor.constraint(equalTo: loginButton.bottomAnchor,constant: 20),
            devider.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -30),
            devider.heightAnchor.constraint(equalToConstant: 40),
            
            googleSignInButton.topAnchor.constraint(equalTo: devider.bottomAnchor,constant: 10),
            googleSignInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            googleSignInButton.widthAnchor.constraint(equalToConstant: 60),
            googleSignInButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

//MARK: - Google Sigin IN
extension LoginViewController {
    @objc func googleSignIn() {
        //firebase Authentication
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) {  result, error in
            guard error == nil else {
                print("Google Sigin In Error, \(String(describing: error))")
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                print("User not Found , \(String(describing: error))")
                return
            }
            
            if #available(iOS 13.0, *) {
                Task {
                    let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                                   accessToken: user.accessToken.tokenString)
                    let authResult = try await Auth.auth().signIn(with: credential)
                    guard authResult.user.email != nil else {
                        return ()
                    }
                    let viewController = UserInfoViewController()
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
