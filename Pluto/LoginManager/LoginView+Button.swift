//
//  LoginView+Button.swift
//  BUMP
//
//  Created by Hunain Ali on 11/9/19.
//  Copyright © 2019 BUMP. All rights reserved.
//

import Foundation
import Firebase
import SwiftEntryKit


extension LoginView {
    
    
    @objc func loginButtonPressed() {
        
        guard self.checkIfFieldsCorrect() else { return }
        guard let email = self.emailTextField.text else { return }
        guard let pass = self.passTextField.text else { return }
        
        self.loginButton.setTitle("Logging in...", for: .normal)
        self.loginButton.isEnabled = false
        
        
        
        Auth.auth().signIn(withEmail: email, password: pass) { (authResult, err) in
            
            guard let user = authResult?.user else {
                
                self.loginButton.setTitle("Log In", for: .normal)
                self.loginButton.isEnabled = true
                
                if let errCode = err?._code {
                    
                    if errCode == AuthErrorCode.userNotFound.rawValue {
                        self.passTextField.text = nil
                        self.emailTextField.text = nil
                        self.presentAlertView(title: "Account not found.", subtitle: "Try signing up.") { (act) in
                            LoginManager.shared.presentSignupVC()
                        }
                    }
                    else {
                        self.animateTextFieldError(textField: self.passTextField, errorText: self.passwordPlaceholder)
                        self.passTextField.text = nil
                        self.presentAlertView(title: "Login failed.", subtitle: "")
                    }
                    
                } else {
                    self.animateTextFieldError(textField: self.passTextField, errorText: self.passwordPlaceholder)
                    self.passTextField.text = nil
                    self.presentAlertView(title: "Login failed.", subtitle: "")
                }
                
                return
            }
            
            if !user.isEmailVerified {
                self.loginButton.setTitle("Log In", for: .normal)
                self.loginButton.isEnabled = true
                self.presentAlertView(title: "Account not verified.", subtitle: "Check your email to verify.")

                user.sendEmailVerification(completion: { (err) in })
            }
            else {
                
                let db = Firestore.firestore()
                db.collection("User-Profile").document(user.uid).setData(["email":email], merge: true) { (err) in
                    guard err == nil else { return }
                    
                    (UIApplication.shared.delegate as! AppDelegate).pluto?.logIn()
                }
                //FIX: better to only pick up DirectoryFetcher on success login.
                
                
            }
            
            
            
            
            
            
        }
    }
    
    
    
    func presentAlertView(title : String, subtitle : String, completionBlock: ((UIAlertAction) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: completionBlock))
        
        DispatchQueue.main.async {
            UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
        }
        
    }
    
    

        
}





extension LoginView {
    
    
    
    
    
    func checkIfFieldsCorrect() -> Bool {
        
        guard let email = self.emailTextField.text else { return false }
        guard let pass = self.passTextField.text else { return false }
        
        
        var allGood = true
        
        if email == "" {
            self.animateTextFieldError(textField: self.emailTextField, errorText: self.emailPlaceholder)
            allGood = false
        }
        else if isValidEmail(emailID: email) == false {
            self.emailTextField.text = nil
            self.animateTextFieldError(textField: self.emailTextField, errorText: "Please enter a valid email")
            allGood = false
        }
        
        if pass == "" {
            self.animateTextFieldError(textField: self.passTextField, errorText: self.passwordPlaceholder)
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

    
    
    
}
