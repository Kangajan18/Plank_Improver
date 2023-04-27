//
//  FirebaseAuth.swift
//  PlankImprover
//
//  Created by kangajan kuganathan on 2023-04-23.
//

import Foundation
import GoogleSignIn
import Firebase
import GoogleSignInSwift

struct FirebaseAuth {
    
    func isUserLogin() -> (Bool) {
        do {
            guard Auth.auth().currentUser != nil else {
                throw Errors.runtimeError("user Not SignOut, Error")
            }
            print("Email = \(Auth.auth().currentUser?.email)")
            return (true)
        } catch {
            return (false)
        }
    }
}
