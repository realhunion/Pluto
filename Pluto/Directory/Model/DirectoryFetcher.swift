//
//  DirectoryFetcher.swift
//  Pluto
//
//  Created by Hunain Ali on 4/19/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation
import Firebase


class DirectoryFetcher {
    
    static let shared : DirectoryFetcher = DirectoryFetcher()
    
    var db = Firestore.firestore()
    
    var userArray : [User]?
    
    init() {}
    
    func shutDown() {
        self.userArray = nil
    }
    
    
    
    func getDirectory(completion: @escaping (_ userArray : [User]) -> Void) {
        
        if let uArray = self.userArray {
            completion(uArray)
            return
        }
        
        self.fetchDirectory { (userArray) in
            completion(userArray)
            return
        }
        
        
    }
    
    func fetchDirectory(completion: @escaping (_ userArray : [User]) -> Void) {
        db.collection("User-Profile").getDocuments { (snap, err) in
            guard let docs = snap?.documents else { completion([]); return }
            
            var uArray : [User] = []
            docs.forEach { (doc) in
                if let email = doc.data()["email"] as? String,
                    let name = doc.data()["name"] as? String,
                    let description = doc.data()["description"] as? String,
                    let imageURL = doc.data()["imageURL"] as? String,
                    let dateJoined = doc.data()["dateJoined"] as? Timestamp,
                    let classYear = doc.data()["classYear"] as? Int {
                    
                    let interests = doc.data()["interests"] as? [String] ?? []
                    
                    let user = User(userID: doc.documentID, email: email, name: name, description: description, imageURL: imageURL, interests: interests, dateJoined: dateJoined, classYear: classYear)
                    
                    uArray.removeAll(where: {$0.userID == user.userID})
                    uArray.append(user)
                    
                }
            }
            
            self.userArray = uArray
            completion(uArray)
            return
        }
    }
    
    
}
