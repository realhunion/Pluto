//
//  User.swift
//  Pluto
//
//  Created by Hunain Ali on 4/19/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Firebase

class User {
    
    var userID : String
    var email : String
    var name : String
    var description : String
    var imageURL : String
    var interests : [String]
    var dateJoined : Timestamp
    var classYear : Int
    init(userID : String, email : String, name : String, description : String, imageURL : String, interests : [String], dateJoined : Timestamp, classYear : Int) {
        self.userID = userID
        self.email = email
        self.name = name
        self.description = description
        self.imageURL = imageURL
        self.interests = interests
        self.dateJoined = dateJoined
        self.classYear = classYear
    }
    
}

class MyUser : User {
    
    var interestsSeen : [String] = []
    init(userID: String, email: String, name: String, description: String, imageURL: String, interests: [String], interestsSeen : [String], dateJoined: Timestamp, classYear : Int) {
        super.init(userID: userID, email: email, name: name, description: description, imageURL: imageURL, interests: interests, dateJoined: dateJoined, classYear: classYear)
        self.interestsSeen = interestsSeen
    }
    
}


class UserProfile {
    
    var userID : String
    var email : String
    var name : String
    var description : String
    var imageURL : String
    var interests : [Interest]
    var dateJoined : Timestamp
    var classYear : Int
    init(userID : String, email : String, name : String, description : String, imageURL : String, interests : [Interest], dateJoined : Timestamp, classYear : Int) {
        self.userID = userID
        self.email = email
        self.name = name
        self.description = description
        self.imageURL = imageURL
        self.interests = interests
        self.dateJoined = dateJoined
        self.classYear = classYear
    }
    
}
