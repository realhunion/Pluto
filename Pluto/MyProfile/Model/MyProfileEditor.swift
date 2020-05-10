//
//  MyProfileEditor.swift
//  Pluto
//
//  Created by Hunain Ali on 4/25/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import SDWebImage

class MyProfileEditor {
    
    static let shared : MyProfileEditor = MyProfileEditor()
    
    var db = Firestore.firestore()
    var storageRef = Storage.storage()
    
    func saveUserName(name : String) {
        
        guard let myUser = Auth.auth().currentUser else { return }
        let myUID = myUser.uid
        
        let payload = ["name" : name] as [String:Any]
        db.collection("User-Profile").document(myUID).setData(payload, merge: true) { (err) in
            guard err == nil else { return }
            
            let changeRequest = myUser.createProfileChangeRequest()
            changeRequest.displayName = name
            changeRequest.commitChanges { (error) in
            }
        }
    }
    
    
    
    func saveUserDescription(description : String) {
        
        guard let myUID = Auth.auth().currentUser?.uid else { return }
        
        let payload = ["description" : description] as [String:Any]
        db.collection("User-Profile").document(myUID).setData(payload, merge: true)
        
    }
    
    
    
    
    func saveUserImage(image : UIImage) {
        
        guard let myUID = Auth.auth().currentUser?.uid else { return }
        
        self.updateFirebaseUserImage(image: image) { (imageURL) in
            guard let imgURL = imageURL else { return }
            let payload = ["imageURL" : imgURL.absoluteString] as [String:Any]
            self.db.collection("User-Profile").document(myUID).setData(payload, merge: true)
        }
    }
    
    func updateFirebaseUserImage(image : UIImage, completion:@escaping (_ userImageURL : URL?)->Void){
        
        guard let myUID = Auth.auth().currentUser?.uid else { return }
        
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            
            let filePath = "User-Profile-Images/\(myUID).jpg"
            
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            self.storageRef.reference(withPath: filePath).putData(imageData, metadata: metadata) { (stoMeta, err) in
                guard err == nil else { completion(nil); return }
                
                self.storageRef.reference(withPath: filePath).downloadURL { (imgUrl, err2) in
                    guard let url = imgUrl else { completion(nil); return }
                    
                    completion(url)
                    return
                }
            }
        }
    }
    
    
}



