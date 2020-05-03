//
//  UserProfile+Connections.swift
//  Pluto
//
//  Created by Hunain Ali on 4/22/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation
import Firebase

extension UserProfileVC : InterestsFetcherDelegate {
    
    func setupUserInterestFetcher() {
        self.userInterestsFetcher = InterestsFetcher(interestIDArray: self.user.interests)
        self.userInterestsFetcher?.delegate = self
        self.userInterestsFetcher?.fetchInterests()
    }
    
    func interestArrayFetched(array: [Interest]) {
        self.interestArray = array
        self.interestArray.sort(by: {Int($0.interestID) ?? 0 < Int($1.interestID) ?? 1})
        
        self.tableView.reloadData()
    }
    
    
//    func setupConnectionFetcher() {
//        
//        DirectoryFetcher.shared.getDirectory(completion: { (uArray) in
//            
//            var connectionArray : [Connection] = []
//            for userB in uArray.filter({$0.userID != self.user.userID}) {
//                
//                let sharedArray = self.user.interests.filter({userB.interests.contains($0)})
//                let connection = Connection(userA: self.user, userB: userB, sharedInterests: sharedArray)
//                connectionArray.append(connection)
//                
//            }
//            
//            self.connectionArray = connectionArray
//            self.connectionArray.sort(by: {$0.sharedInterests.count > $1.sharedInterests.count})
//            
//            self.tableView.reloadData()
//            
//        })
//        
//    }
        
    
    
    
}
