//
//  InterestProfileVC+Fetcher.swift
//  Pluto
//
//  Created by Hunain Ali on 5/10/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation

extension InterestProfileVC {
    
    
    func setupFetcher() {
        
        InterestDirectory.shared.fetchInterest(interestID: self.interestID) { (i) in
            
            guard let intr = i else { return }
            
            self.setupHeaderProfile(interest: intr)
            
            let uIDArray = intr.likedBy.map({$0.userID})
            self.setupMembersFetcher(userIDArray: uIDArray)
            
        }
    }
    
    
    func setupMembersFetcher(userIDArray : [String]) {
        
        UserDirectory.shared.getUsers(userIDArray: userIDArray) { (userArray) in
            self.userArray = userArray
            self.tableView.reloadData()
        }
        
    }
    
    
    
    
    
    
}
