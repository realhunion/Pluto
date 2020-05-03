//
//  SignupView+Button.swift
//  BUMP
//
//  Created by Hunain Ali on 11/10/19.
//  Copyright © 2019 BUMP. All rights reserved.
//

import Foundation
import Firebase
import SwiftEntryKit


extension SignupView {
    
    
    @objc func signupButtonPressed() {
        
        guard self.checkIfFieldsCorrect() else { return }
        guard let name = self.nameTextField.text else { return }
        guard let email = self.emailTextField.text else { return }
        guard let pass = self.passTextField.text else { return }
        let classYear = self.segmentClassYear.selectedSegmentIndex + 1
        
        self.signupButton.setTitle("Signing up...", for: .normal)
        self.signupButton.isEnabled = false
        
        Auth.auth().createUser(withEmail: email, password: pass) { (authResult, err) in
            
            guard let user = authResult?.user else {
                
                self.signupButton.setTitle("Sign up!", for: .normal)
                self.signupButton.isEnabled = true
                
                self.animateTextFieldError(textField: self.emailTextField, errorText: self.emailPlaceholder)
                self.animateTextFieldError(textField: self.nameTextField, errorText: self.namePlaceholder)
                self.animateTextFieldError(textField: self.passTextField, errorText: self.passwordPlaceholder)
                
                return
            }
            
            
            let dispatchGroup = DispatchGroup()
            
            dispatchGroup.enter()
            self.db.collection("User-Profile").document(user.uid).setData(["classYear":classYear, "dateJoined":FieldValue.serverTimestamp(),"name":name, "description":"🚀", "imageURL":"https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=100"], completion: { (err) in
                dispatchGroup.leave()
            })
            
            dispatchGroup.enter()
            user.sendEmailVerification(completion: { (err) in
                dispatchGroup.leave()
            })
            
            dispatchGroup.enter()
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = name
            changeRequest.commitChanges { (error) in
                dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: DispatchQueue.main, execute: {
                
                self.signupButton.setTitle("Sign up!", for: .normal)
                self.signupButton.isEnabled = false
                
                let alert = UIAlertController(title: "Email Sent!", message: "Check your inbox to verify you are a Grinnell Student.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (act) in
                    LoginManager.shared.presentLoginVC(email: email, pass: pass)
                }))
                UIApplication.topViewController()?.present(alert, animated: true)
                
            })
            
            
            
            
        }
        
    }
    
    
    func presentAlertView(title : String, subtitle : String) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    
    
    
    func checkIfFieldsCorrect() -> Bool {
        
        guard let name = self.nameTextField.text else { return false }
        guard let email = self.emailTextField.text else { return false }
        guard let pass = self.passTextField.text else { return false }
        
        var allGood = true
        
        if name == "" {
            self.animateTextFieldError(textField: self.nameTextField, errorText: self.namePlaceholder)
            allGood = false
        }
        else if isAlphaNumericOnly(text: name, includeSpace: true) {
            self.nameTextField.text = ""
            self.animateTextFieldError(textField: self.nameTextField, errorText: "Enter a valid name.")
            allGood = false
        }
        
        if email == "" {
            self.animateTextFieldError(textField: self.emailTextField, errorText: self.emailPlaceholder)
            allGood = false
        }
        else if isValidEmail(emailID: email) == false {
            self.emailTextField.text = nil
            self.animateTextFieldError(textField: self.emailTextField, errorText: "Please enter a valid email.")
            allGood = false
        }
        else if isSchoolEmail(emailID: email) == false {
            self.emailTextField.text = nil
            self.animateTextFieldError(textField: self.emailTextField, errorText: "Please enter your .edu email")
            allGood = false
        }
        
        if pass == "" {
            self.animateTextFieldError(textField: self.passTextField, errorText: self.passwordPlaceholder)
            allGood = false
        }
        else if pass.count < 6 {
            self.passTextField.text = nil
            self.animateTextFieldError(textField: self.passTextField, errorText: "Choose a stronger password.")
            allGood = false
        }
        
        return allGood
    }
    
    
    func animateTextFieldError(textField : UITextField, errorText : String) {
        
        let animation:CABasicAnimation = CABasicAnimation(keyPath: "borderColor")
        animation.fromValue = UIColor.red.cgColor
        animation.toValue = textField.layer.borderColor
        animation.duration = 0.4
        textField.layer.add(animation, forKey: "borderColor")
        textField.layer.borderColor = textField.layer.borderColor
        
        textField.placeholder = errorText
    }

    
    
    
    func isValidEmail(emailID:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    func isSchoolEmail(emailID:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@grinnell.edu"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    func isAlphaNumericOnly(text : String, includeSpace : Bool) -> Bool {
        var regEx = ".*[^A-Za-z0-9].*"
        if includeSpace {
            regEx = ".*[^A-Za-z0-9 ].*"
        }
        let textTest = NSPredicate(format:"SELF MATCHES %@", regEx)
        return textTest.evaluate(with: text)
    }
    
    
    
    
    
    
    
    
}
