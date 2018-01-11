//
//  User.swift
//  MyBooks
//
//  Created by Andrei Vataselu on 1/11/18.
//  Copyright © 2018 Andrei Vataselu. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase

class User {
    
    private init(){}
    
    static var isLoggedIn : Bool {
        if Auth.auth().currentUser != nil {
            return true
        } else {
            return false
        }
    }
    
   static func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            switch error {
                
            case .none:
                print("Registered account with email: \(email)")

            case .some(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func login(email: String, password: String, didLogin: @escaping (Bool) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            switch error {                
            case .none:
                print("Welcome, \(email)")
                didLogin(true)
            case .some(let error):
                print(error.localizedDescription)
                didLogin(false)
            }
        }
    }
    
    static func logout(didSignOut: @escaping (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            didSignOut(true)
            
        } catch {
            print("Couldn't Sign out! \(error)")
            didSignOut(false)
        }
    }
}
