//
//  LoginViewController.swift
//  Projekti Faza 2 - AD
//
//  Created by Cacttus Education 04 on 4/18/20.
//  Copyright © 2020 CacttusEducation. All rights reserved.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController, UITextFieldDelegate {
    
@IBOutlet weak var emailTextField: UITextField!

@IBOutlet weak var passwordTextField: UITextField!

@IBOutlet weak var loginButton: UIButton!
        
@IBOutlet weak var signUpButton: UIButton!

@IBOutlet weak var errorLabel: UILabel!
    
@IBAction func signUpTapped(_ sender: Any) {
    
let signUpVC = self.storyboard?.instantiateViewController(identifier: "signUpView") as? SignUpViewController
                            
    self.view.window?.rootViewController = signUpVC
    self.view.window?.makeKeyAndVisible()
    }
    override func viewDidLoad() {
            super.viewDidLoad()
            setUpElements()
        }
        
        func setUpElements() {
            errorLabel.alpha = 0
        }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //      passwordTextField.resignFirstResponder()
      //  return true
   // }
    
@IBAction func loginTapped(_ sender: Any) {
            
let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
    Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                
if error != nil {
    self.errorLabel.text = error!.localizedDescription
    self.errorLabel.alpha = 1
} else {
                    
let mainViewController = self.storyboard?.instantiateViewController(identifier: "MainView") as? MainViewController
                    
self.view.window?.rootViewController = mainViewController
self.view.window?.makeKeyAndVisible()
                }
            }
        }
    }
