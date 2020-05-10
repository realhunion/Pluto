//
//  DirectoryFetcher.swift
//  Pluto
//
//  Created by Hunain Ali on 4/19/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation
import Firebase


class UserDirectory {
    
    static let shared : UserDirectory = UserDirectory()
    
    var db = Firestore.firestore()
    
    var userArray : [User]?
    
    init() {}
    
    func shutDown() {
        self.userArray = nil
    }
    
    
    
    
    //MARK: - Full Directory
    
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
    
    
    //MARK: - One User
    
    func getUser(userID : String, completion: @escaping (_ user : User?) -> Void) {
        
        if let u = self.userArray?.first(where: {$0.userID == userID}) {
            completion(u)
            return
        }
        
        self.fetchUser(userID: userID) { (u) in
            completion(u)
            return
        }
    }
    
    
    func getUsers(userIDArray : [String], completion: @escaping (_ userArray : [User]) -> Void) {
        
        var uArray : [User] = []
        
        let dispatchGroup = DispatchGroup()
        for uID in userIDArray {
            dispatchGroup.enter()
            self.getUser(userID: uID) { (user) in
                if let u = user {
                    uArray.append(u)
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(uArray)
            return
        }
    }
    
    
    
    func fetchUser(userID : String, completion: @escaping (_ user : User?) -> Void) {
        
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
                
                
                self.userArray?.removeAll(where: {$0.userID == user.userID})
                self.userArray?.append(user)
                completion(user)
                return
                
            } else {
                completion(nil)
                return
            }
        }
        
        
    }
    
    
}
