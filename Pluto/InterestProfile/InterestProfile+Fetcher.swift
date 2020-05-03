//
//  InterestProfile+Fetcher.swift
//  Pluto
//
//  Created by Hunain Ali on 4/23/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation
import Firebase

extension InterestProfileVC : UsersFetcherDelegate{
    
    func usersFetched(userArray: [User]) {
        self.userArray = userArray
        self.userArray.sort(by: {$1.dateJoined.compare($0.dateJoined) == .orderedAscending})
        
        self.tableView.reloadData()
    }
    
    
}
