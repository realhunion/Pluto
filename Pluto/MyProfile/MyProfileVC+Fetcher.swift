//
//  MyProfileVC+Fetcher.swift
//  Pluto
//
//  Created by Hunain Ali on 4/29/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation
import UIKit
import Firebase


extension MyProfileVC : MyUserProfileFetcherDelegate {
    
    
    //MARK: fetcher
    
    func setupFetcher() {
        self.setupMyProfileFetcher()
    }
    
    
    
    //MARK: myProf
    
    func myProfileUpdated(userProfile: UserProfile) {
        
        self.tableView.backgroundView = nil
        
        self.myUser = userProfile
        self.myUser?.interests.sort(by: {Int($0.interestID) ?? 0 < Int($1.interestID) ?? 1})
        
        self.tableView.reloadData()
        
        self.fetchConnections()
    }
    
    func setupMyProfileFetcher() {
        let spinner = UIActivityIndicatorView()
        spinner.startAnimating()
        self.tableView.backgroundView = spinner
        
        self.myProfileFetcher = MyUserProfileFetcher()
        self.myProfileFetcher?.delegate = self
        self.myProfileFetcher?.monitorMyProfile()
    }
    
    
    //MARK: - connection
    
    func fetchConnections() {
        
        guard let myU = self.myUser else { return }
        
        UserDirectory.shared.getDirectory(completion: { (uArray) in
            
            var connectionArray : [Connection] = []
            for userB in uArray.filter({$0.userID != myU.userID}) {
                
                
                let sharedArray = myU.interests.map({$0.interestID}).filter({userB.interests.contains($0)})
                let userA = User(userID: myU.userID, email: myU.email, name: myU.name, description: myU.description, imageURL: myU.imageURL, interests: myU.interests.map({$0.interestID}), dateJoined: myU.dateJoined, classYear: myU.classYear)
                let connection = Connection(userA: userA, userB: userB, sharedInterests: sharedArray)
                connectionArray.append(connection)
                
            }
            
            self.connectionArray = connectionArray
            self.connectionArray.sort(by: {$0.sharedInterests.count > $1.sharedInterests.count})
            
            self.tableView.reloadData()
            
        })
        
    }
    
}
