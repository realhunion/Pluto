//
//  UsersFetcher.swift
//  Pluto
//
//  Created by Hunain Ali on 4/19/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation
import Firebase

protocol InterestProfileFetcherDelegate : class {
    func userProfilesFetched(array : [User])
}

class UsersFetcher {
    
    var db = Firestore.firestore()
    
    weak var delegate : InterestProfileFetcherDelegate?
    
    var interest : [String]
    init(userIDArray : [String]) {
        self.userIDArray = userIDArray
    }
    
    
    
    
    
    //MARK: - Fetch
    
    func fetchInterestProfile() {
        
        let fetchDispatchGroup = DispatchGroup()
        
        var uProfileArray : [User] = []
        
        for userID in self.interest.likedBy {
            
            fetchDispatchGroup.enter()
            
            db.collection("User-Profile").document(userID).getDocument { (snap, err) in
                guard let doc = snap else { return }
                
                if let name = doc.data()?["name"] as? String, let description = doc.data()?["description"] as? String, let imageURL = doc.data()?["imageURL"] as? String, let likes = doc.data()?["interests"] as? [String] {
                    
                    let uProfile = User(userID: userID, name: name, description: description, imageURL: imageURL, interests: likes)
                    uProfileArray.append(uProfile)
                    
                }
                fetchDispatchGroup.leave()
            }
        }
        
        fetchDispatchGroup.notify(queue: .main) {
            self.delegate?.userProfilesFetched(array: uProfileArray)
        }
        
        
    }
    
    
}
