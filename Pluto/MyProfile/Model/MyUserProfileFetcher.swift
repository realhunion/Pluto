//
//  MyProfileFetcher.swift
//  Pluto
//
//  Created by Hunain Ali on 4/24/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation
import Firebase


protocol MyUserProfileFetcherDelegate : class {
    func myProfileUpdated(userProfile : UserProfile)
}


class MyUserProfileFetcher {
    
    var db = Firestore.firestore()
    
    weak var delegate : MyUserProfileFetcherDelegate?
    var listener : ListenerRegistration?
    
    init() {
    }
    
    func shutDown() {
        self.delegate = nil
        if let listenr = self.listener {
            listenr.remove()
        }
    }
    
    
    
    
    func monitorMyProfile() {
        
        guard let myUID = Auth.auth().currentUser?.uid else { return }
        
        self.listener = db.collection("User-Profile").document(myUID).addSnapshotListener { (snap, err) in
            guard let doc = snap else { return }
            
            if let email = doc.data()?["email"] as? String,
                let name = doc.data()?["name"] as? String,
                let description = doc.data()?["description"] as? String,
                let imageURL = doc.data()?["imageURL"] as? String,
                let dateJoined = doc.data()?["dateJoined"] as? Timestamp,
                let classYear = doc.data()?["classYear"] as? Int {
                
                let interests = doc.data()?["interests"] as? [String] ?? []
                
                
                //FIX: Future make safer
                var interestArray : [Interest] = []
                let dGroup = DispatchGroup()
                for interestID in interests {
                    dGroup.enter()
                    self.getInterest(interestID: interestID) { (interest) in
                        if let i = interest { interestArray.append(i) }
                        dGroup.leave()
                    }
                }
                
                dGroup.notify(queue: .main) {
                    let uProfile = UserProfile(userID: myUID, email: email, name: name, description: description, imageURL: imageURL, interests: interestArray, dateJoined: dateJoined, classYear: classYear)
                    self.delegate?.myProfileUpdated(userProfile: uProfile)
                }
                
            }
            
            
        }
        
    }
    
    
    var interestDict : [String:Interest] = [:]
    func getInterest(interestID : String, completion: @escaping (_ interest : Interest?) -> Void) {
        
        if let i = self.interestDict[interestID] {
            completion(i)
            return
        }
        
        db.collection("Interest-Profile").document(interestID).getDocument { (snap, err) in
            guard let doc = snap else { completion(nil); return }
            
            if let name = doc.data()?["name"] as? String,
                let description = doc.data()?["description"] as? String,
                let imageURL = doc.data()?["imageURL"] as? String {
                
                let likedBy = doc.data()?["likedBy"] as? [String] ?? []
                
                let i = Interest(interestID: interestID, name: name, description: description, imageURL: imageURL, likedBy: likedBy)
                completion(i)
                return
                
            } else {
                completion(nil)
                return
            }
            
        }
    
    }
}
