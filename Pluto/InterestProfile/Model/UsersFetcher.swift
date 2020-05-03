//
//  UsersFetcher.swift
//  Pluto
//
//  Created by Hunain Ali on 4/19/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation
import Firebase

protocol UsersFetcherDelegate : class {
    func usersFetched(userArray : [User])
}

class UsersFetcher {
    
    var db = Firestore.firestore()
    
    weak var delegate : UsersFetcherDelegate?
    
    var userIDArray : [String]
    init(userIDArray : [String]) {
        self.userIDArray = userIDArray
    }
    
    
    
    
    //MARK: - Fetch
    
    func fetchInterestProfile() {
        
        let fetchDispatchGroup = DispatchGroup()
        
        var userArray : [User] = []
        
        for userID in self.userIDArray {
            
            fetchDispatchGroup.enter()
            
            db.collection("User-Profile").document(userID).getDocument { (snap, err) in
                guard let doc = snap else { return }
                
                if let email = doc.data()?["email"] as? String,
                    let name = doc.data()?["name"] as? String,
                    let description = doc.data()?["description"] as? String,
                    let imageURL = doc.data()?["imageURL"] as? String,
                    let dateJoined = doc.data()?["dateJoined"] as? Timestamp,
                    let classYear = doc.data()?["classYear"] as? Int {
                    
                    let interests = doc.data()?["interests"] as? [String] ?? []
                    
                    let user = User(userID: userID, email: email, name: name, description: description, imageURL: imageURL, interests: interests, dateJoined: dateJoined, classYear: classYear)
                    userArray.append(user)
                    
                }
                fetchDispatchGroup.leave()
            }
        }
        
        fetchDispatchGroup.notify(queue: .main) {
            self.delegate?.usersFetched(userArray: userArray)
        }
        
        
    }
    
    
}
