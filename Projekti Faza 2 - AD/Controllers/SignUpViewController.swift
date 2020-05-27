//
//  SignUpViewController.swift
//  Projekti 1 - Arber Asllani
//
//  Created by Cacttus Education 01 on 22.3.20.
//  Copyright © 2020 Cacttus Education 01. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
@IBOutlet weak var passwordTextField: UITextField!
@IBOutlet weak var firstNameTextField: UITextField!
@IBOutlet weak var lastNameTextField: UITextField!
@IBOutlet weak var emailTextField: UITextField!
@IBOutlet weak var signUpButton: UIButton!
@IBOutlet weak var errorLabel: UILabel!
    
override func viewDidLoad() {
            super.viewDidLoad()
            setUpElements()
    }
    
func validateFields() -> String? {
         
if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""     ||
    lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
    emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
    passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
             
    return "Please fill in all fields."
}
    
func isPasswordValid(_ password : String) -> Bool {
               
let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
    return passwordTest.evaluate(with: password)
}

let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
         
if isPasswordValid(cleanedPassword) == false {
    return "Please make sure your password is at least 8 characters, contains a special character and a number."
    }
    return nil
}
    
func setUpElements() {
    errorLabel.alpha = 0
}
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         passwordTextField.resignFirstResponder()
         return true
     }
    
@IBAction func signUpClicked(_ sender: Any) {
let error = validateFields()
         
    if error != nil {
        self.showError(error!)
    } else {
             
let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                 
    if err != nil {
    self.showError("Error creating user")
    } else {
    
        let db = Firestore.firestore()
        db.collection("users").addDocument(data: ["first_name":firstName, "last_name":lastName, "uid": result!.user.uid ]) { (error) in
            if error != nil {
                self.showError("Error saving user data")
            }
        }
    let mainViewController = self.storyboard?.instantiateViewController(identifier: "MainView") as? MainViewController
    
    self.view.window?.rootViewController = mainViewController
            }
        }
    }
}
func showError(_ message:String) {
    errorLabel.text = message
    errorLabel.alpha = 1
    }
}
