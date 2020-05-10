//
//  UserProfile+Connections.swift
//  Pluto
//
//  Created by Hunain Ali on 4/22/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation
import Firebase

extension UserProfileVC  {
    
    
    func setupFetcher() {
        
        UserDirectory.shared.fetchUser(userID: self.userID) { (user) in
            guard let u = user else { return }
            
            self.setupSegmentControl()
            self.setupHeaderProfile(user: u)
            
            
            self.setupInterestsFetcher(user: u)
            self.setupConnectionFetcher(user: u)
            
        }
    }
    
    
    
    func setupInterestsFetcher(user : User) {
        
        InterestDirectory.shared.getInterests(interestIDArray: user.interests) { (interestArray) in
            self.interestArray = interestArray
            self.tableView.reloadData()
        }
        
    }
    
    
    
    func setupConnectionFetcher(user : User) {
        
        UserDirectory.shared.getDirectory(completion: { (uArray) in
            
            var connectionArray : [Connection] = []
            for userB in uArray.filter({$0.userID != user.userID}) {
                
                let sharedArray = user.interests.filter({userB.interests.contains($0)})
                let connection = Connection(userA: user, userB: userB, sharedInterests: sharedArray)
                connectionArray.append(connection)
                
            }
            
            self.connectionArray = connectionArray
            self.connectionArray.sort(by: {$0.sharedInterests.count > $1.sharedInterests.count})
            
            self.tableView.reloadData()
            
        })
        
    }
        
    
    
    
}
