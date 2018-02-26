//
//  LoginVC.swift
//  MyBooks
//
//  Created by Andrei Vataselu on 1/18/18.
//  Copyright © 2018 Andrei Vataselu. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if User.isLoggedIn {
            if let libraryVC = storyboard?.instantiateViewController(withIdentifier: "UserLibraryVC") {
                self.navigationController?.pushViewController(libraryVC, animated: false)
            }
        }
        
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email Address",
                                                                  attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                  attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
    }
    
    @IBAction func pressLoginButton(sender: UIButton){
        
        let credentialsError = UIAlertController(title: "", message: "Invalid credentials", preferredStyle: .alert)
        credentialsError.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        if emailTextField.text == "" || passwordTextField.text == "" {
            self.present(credentialsError, animated: true)
        } else {
            User.login(email: emailTextField.text!, password: passwordTextField.text!, didLogin: { (loginSuccesful) in
                if loginSuccesful {
                    let mainController = self.storyboard?.instantiateViewController(withIdentifier: "UserLibraryVC")
                    
                    self.navigationController?.pushViewController(mainController!, animated: true)
                }
                else {
                    print(loginSuccesful.description)
                    self.present(credentialsError, animated:true)
                }
            })
            
            }
        }
    }
