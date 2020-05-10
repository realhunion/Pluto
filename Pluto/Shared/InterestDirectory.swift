//
//  InterestDirectory.swift
//  Pluto
//
//  Created by Hunain Ali on 5/10/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation
import FirebaseFirestore


class InterestDirectory {
    
    static let shared : InterestDirectory = InterestDirectory()
    
    var db = Firestore.firestore()
    
    var interestArray : [Interest] = []
    
    init() {}
    
    func shutDown() {
        self.interestArray = []
    }
    
    
    
    //MARK: - One Interest
    
    func getInterest(interestID : String, completion: @escaping (_ interest : Interest?) -> Void) {
        
        if let i = self.interestArray.first(where: {$0.interestID == interestID}) {
            completion(i)
            return
        }
        
        self.fetchInterest(interestID: interestID) { (i) in
            completion(i)
            return
        }
        
    }
    
    func getInterests(interestIDArray : [String], completion: @escaping (_ interestArray : [Interest]) -> Void) {
        
        var intrArray : [Interest] = []
        
        let dispatchGroup = DispatchGroup()
        for iID in interestIDArray {
            dispatchGroup.enter()
            self.getInterest(interestID: iID) { (interest) in
                if let i = interest {
                    intrArray.append(i)
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(intrArray)
            return
        }
        
    }
    
    
    
    func fetchInterest(interestID : String, completion: @escaping (_ interest : Interest?) -> Void) {
        
        db.collection("Interest-Profile").document(interestID).getDocument { (snap, err) in
            guard let doc = snap else { return }
            
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
                
                self.interestArray.removeAll(where: {$0.interestID == interestID})
                self.interestArray.append(interest)
                completion(interest)
                return
                
            }
            else {
                completion(nil)
                return
            }
            
        }
        
        
    }
    
    
}
