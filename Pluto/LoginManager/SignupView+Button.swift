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
        
        SwiftEntryKit.dismiss {
            self.presentGrinnellianTest { (isGood) in
                if isGood {
                    let v = SigningUpView()
                    var atr = Constant.centerPopUpAttributes
                    atr.entryInteraction = .absorbTouches
                    atr.screenInteraction = .absorbTouches
                    atr.scroll = .disabled
                    DispatchQueue.main.async {
                        SwiftEntryKit.display(entry: v, using: atr)
                    }
                    self.createUser(email: email, pass: pass, name: name, classYear: classYear)
                } else {
                    self.presentAlertView(title: "Who are you?", subtitle: nil)
                }
            }
        }
        
    }
    
    func createUser(email : String, pass : String, name : String, classYear : Int) {
        
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
            
            var theImageURL = "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=100"
            dispatchGroup.enter()
            self.updateFirebaseUserImage(image: UIImage(named: "travisScott")!) { (url) in
                guard let theURL = url else { return }
                theImageURL = theURL.absoluteString
                dispatchGroup.leave()
            }
            
            dispatchGroup.enter()
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = name
            changeRequest.commitChanges { (error) in
                guard err == nil else { return }
                dispatchGroup.leave()
            }
            
            dispatchGroup.enter()
            self.db.collection("User-Profile").document(user.uid).setData(["classYear":classYear, "dateJoined":FieldValue.serverTimestamp(),"name":name, "description":"🚀", "email":email, "imageURL":theImageURL], completion: { (err) in
                guard err == nil else { return }
                dispatchGroup.leave()
            })
            
            
            dispatchGroup.notify(queue: DispatchQueue.main, execute: {
                
                (UIApplication.shared.delegate as! AppDelegate).pluto?.logIn()
                
            })
        
        }
    }

    
    
    func presentAlertView(title : String, subtitle : String?) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    
    func presentGrinnellianTest(completion:@escaping (Bool)->Void) {
        
        let alertController = UIAlertController(title: "Grinnellian Test", message: nil, preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Bob's ???????????"
        }
        let goAction = UIAlertAction(title: "Go", style: UIAlertAction.Style.default, handler: { alert -> Void in
            guard let entry = alertController.textFields?[0].text else { return }
            print("bono \(entry)")
            
            if entry == "underground" || entry == "Underground" {
                completion(true)
            } else {
                completion(false)
            }
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
        
        alertController.addAction(cancelAction)
        alertController.addAction(goAction)
        
        DispatchQueue.main.async {
            UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
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
//        else if isSchoolEmail(emailID: email) == false {
//            self.emailTextField.text = nil
//            self.animateTextFieldError(textField: self.emailTextField, errorText: "Please enter your .edu email")
//            allGood = false
//        }
        
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
    
    
    
    
    
    
    func updateFirebaseUserImage(image : UIImage, completion:@escaping (_ userImageURL : URL?)->Void){
        
        guard let myUID = Auth.auth().currentUser?.uid else { return }
        
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            
            let filePath = "User-Profile-Images/\(myUID).jpg"
            
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            let storageRef = Storage.storage()
            storageRef.reference(withPath: filePath).putData(imageData, metadata: metadata) { (stoMeta, err) in
                guard err == nil else { completion(nil); return }
                
                storageRef.reference(withPath: filePath).downloadURL { (imgUrl, err2) in
                    guard let url = imgUrl else { completion(nil); return }
                    
                    completion(url)
                    return
                }
            }
        }
    }
    
    
    
    
}
