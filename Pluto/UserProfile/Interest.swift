//
//  InterestProfile.swift
//  Pluto
//
//  Created by Hunain Ali on 4/19/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation

class Interest {
    
    var interestID : String
    var name : String
    var description : String
    var imageURL : String
    var likedBy : [String]
    init(interestID : String, name : String, description : String, imageURL : String, likedBy : [String]) {
        self.interestID = interestID
        self.name = name
        self.description = description
        self.imageURL = imageURL
        self.likedBy = likedBy
    }
    
}

