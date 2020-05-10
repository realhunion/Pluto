//
//  ConnectionVC+Fetcher.swift
//  Pluto
//
//  Created by Hunain Ali on 4/25/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation

extension ConnectionVC {
    
    
    func setupFetcher() {
        InterestDirectory.shared.getInterests(interestIDArray: self.connection.sharedInterests) { (interestArray) in
            self.interestArrayFetched(array: interestArray)
        }
    }
    
    func interestArrayFetched(array: [Interest]) {
        
        self.sharedInterestArray = array
        self.sharedInterestArray.sort(by: {Int($0.interestID) ?? 0 < Int($1.interestID) ?? 1})
        
        self.tableView.reloadData()
    }
    
}
