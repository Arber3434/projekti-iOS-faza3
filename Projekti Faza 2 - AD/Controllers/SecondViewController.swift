//
//  SecondViewController.swift
//  Projekti Faza 2 - Arber Asllani
//
//  Created by Cacttus Education 04 on 4/18/20.
//  Copyright © 2020 CacttusEducation. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet var secondView: UIView!
    
    let textField1: UITextField = UITextField(frame: CGRect(x: 10, y: 320, width: 300.00, height: 30.0))
    let textField2: UITextField = UITextField(frame: CGRect(x: 10, y: 360, width: 300.00, height: 30.00))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayFields()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(sender:)))
        tap.delegate = self as UIGestureRecognizerDelegate
        secondView.addGestureRecognizer(tap)
    }
    
    @objc func viewTapped(sender: UITapGestureRecognizer) {
        let text1: String = textField1.text!
        let text2: String = textField2.text!
        
        let alertController = UIAlertController(title: text1, message:
            text2, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Cancel", style:
                .default))
            self.present(alertController, animated: true, completion: nil)
        }

    
    func displayFields() {
        textField1.placeholder = "Enter text"
        textField1.borderStyle = UITextField.BorderStyle.line
        textField1.backgroundColor = UIColor.white
        textField1.textColor = UIColor.darkGray
        
        self.view.addSubview(textField1)
        
        textField2.placeholder = "Enter some text"
        textField2.borderStyle = UITextField.BorderStyle.line
        textField2.backgroundColor = UIColor.white
        textField2.textColor = UIColor.darkGray
        
        self.view.addSubview(textField2)
    }
    
    
}
