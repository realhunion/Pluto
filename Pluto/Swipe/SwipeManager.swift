//
//  SwipeManager.swift
//  Pluto
//
//  Created by Hunain Ali on 4/24/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation
import Firebase

class SwipeManager {
    
    static let shared : SwipeManager = SwipeManager()
    
    var db = Firestore.firestore()
    
    
    //MARK: - Get Cards
    
    func getCards(completion: @escaping (_ interestIDArray : [String]?) -> Void){
        
        self.maxInterestID { (maximumID) in
            print("xcx \(maximumID)")
            guard let maxID = maximumID else { completion(nil); return }
            
            let iArrayNumber = Array(1...maxID)
            var iArray = iArrayNumber.map { String($0) }
            
            guard LoginManager.shared.isLoggedIn() else { completion(iArray); return }
            
            self.getMyUser { (myUser) in
                
                guard let myU = myUser else { completion(iArray); return}
                
//                iArray = iArray.filter({!myU.interests.contains($0)})
//                iArray = iArray.filter({!myU.interestsSeen.contains($0)})
                completion(iArray)
                return
                
            }
            
        }

    }
    
    
    func getMyUser(completion: @escaping (_ myUser : MyUser?) -> Void) {
        
        guard let myUID = Auth.auth().currentUser?.uid else { completion(nil); return }
        
        db.collection("User-Profile").document(myUID).getDocument { (snap, err) in
            guard let doc = snap else { completion(nil); return }
            
            if let email = doc.data()?["email"] as? String,
                let name = doc.data()?["name"] as? String,
                let description = doc.data()?["description"] as? String,
                let imageURL = doc.data()?["imageURL"] as? String,
                let dateJoined = doc.data()?["dateJoined"] as? Timestamp,
                let classYear = doc.data()?["classYear"] as? Int {
                
                let interests = doc.data()?["interests"] as? [String] ?? []
                let interestsSeen = doc.data()?["interestsSeen"] as? [String] ?? []
                
                let myUser = MyUser(userID: myUID, email: email, name: name, description: description, imageURL: imageURL, interests: interests, interestsSeen: interestsSeen, dateJoined: dateJoined, classYear: classYear)
                completion(myUser)
                return
            }
        }
        
    }
    
    func maxInterestID(completion: @escaping (_ maxInterestID : Int?) -> Void) {
        
        db.collection("Interest-Profile").limit(to: 1).order(by: "id", descending: true).getDocuments { (snap, err) in
            guard let doc = snap?.documents.first else { completion(nil); return }
            if let theID = doc.data()["id"] as? Int {
                completion(theID)
                return
            } else {
                completion(nil)
                return
            }
        }
        
    }
    
    
    
    
    
    // MARK :- Sending Swipes
    
    func swipedLeft(interestID : String) {
        
        return
        
        guard let myUID = Auth.auth().currentUser?.uid else { return }
        
        let batch = db.batch()
        
        let ref1 = db.collection("User-Profile").document(myUID)
//        let payload1 = ["interestsSeen":FieldValue.delete(),
//            "interestsSeen":FieldValue.arrayUnion([interestID]),
//                        "interests":FieldValue.arrayRemove([interestID]),
//            ] as [String:Any]
//        batch.updateData(payload1, forDocument: ref1)
        
        let ref2 = db.collection("Interest-Profile").document(interestID)
        let payload2 = ["likedBy":FieldValue.delete()] as [String:Any]
        batch.updateData(payload2, forDocument: ref2)
        
        batch.commit()
        
        
    }
    
    func swipedRight(interestID : String) {
        
        guard let myUser = Auth.auth().currentUser else { return }
        let myUID = myUser.uid
        
        let batch = db.batch()
        
        let ref1 = db.collection("User-Profile").document(myUID)
        
        let payload1 = ["interests":FieldValue.arrayUnion([interestID])] as [String:Any]
        batch.updateData(payload1, forDocument: ref1)
        
        
        let ref2 = db.collection("Interest-Profile").document(interestID)
        
        var myName = myUser.displayName ?? ""
        if let myFirstName = myName.components(separatedBy: " ").first {
            myName = myFirstName
        }
        let item = ["userID":myUID, "name":myName]
        let payload2 = ["likedBy":FieldValue.arrayUnion([item])] as [String:Any]
        
        
        
        batch.updateData(payload2, forDocument: ref2)
        
        batch.commit()
        
    }
    
    
    
    
    
    //MARK: - GET INTEREST
    
    func getInterest(interestID : String, completion: @escaping (_ interest : Interest?) -> Void) {
        
        db.collection("Interest-Profile").document(interestID).getDocument { (snap, err) in
            guard let doc = snap else { completion(nil); return }
            
            if let name = doc.data()?["name"] as? String, let description = doc.data()?["description"] as? String, let imageURL = doc.data()?["imageURL"] as? String {
                
                var metaUserArray : [MetaUser] = []
                let likedBy = doc.data()?["likedBy"] as? [Any] ?? []
                for object in likedBy {
                    if let o = object as? [String:Any] {
                        if let uid = o["userID"] as? String, let name = o["name"] as? String {
                            let mUser = MetaUser(userID: uid, name: name)
                            metaUserArray.append(mUser)
                        }
                    }
                }
                
                let interest = Interest(interestID: interestID, name: name, description: description, imageURL: imageURL, likedBy: metaUserArray)
                completion(interest)
                return
                
            }
        }
        
    }
    
    
}
