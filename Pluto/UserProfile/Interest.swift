//
//  InterestProfile.swift
//  Pluto
//
//  Created by Hunain Ali on 4/19/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation
import Firebase

struct MetaUser {
    var userID : String
    var name : String
    func getImageRef() -> StorageReference {
        let userImagePath = "User-Profile-Images/\(self.userID).jpg"
        let storageRef = Storage.storage()
        return storageRef.reference(withPath: userImagePath)
    }
}

class Interest {
    
    var interestID : String
    var name : String
    var description : String
    var imageURL : String
    var likedBy : [MetaUser]
    init(interestID : String, name : String, description : String, imageURL : String, likedBy : [MetaUser]) {
        self.interestID = interestID
        self.name = name
        self.description = description
        self.imageURL = imageURL
        self.likedBy = likedBy
    }
    
}

