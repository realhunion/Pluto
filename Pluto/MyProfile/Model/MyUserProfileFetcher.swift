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
                
                var interestArray : [Interest] = []
                let dGroup = DispatchGroup()
                dGroup.enter()
                InterestDirectory.shared.getInterests(interestIDArray: interests) { (iArray) in
                    interestArray = iArray
                    dGroup.leave()
                }
                
                dGroup.notify(queue: .main) {
                    let uProfile = UserProfile(userID: myUID, email: email, name: name, description: description, imageURL: imageURL, interests: interestArray, dateJoined: dateJoined, classYear: classYear)
                    self.delegate?.myProfileUpdated(userProfile: uProfile)
                }
                
            }
            
            
        }
        
    }
}
