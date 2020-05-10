//
//  DirectoryTVC+Fetcher.swift
//  Pluto
//
//  Created by Hunain Ali on 4/19/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation
import Firebase

extension DirectoryVC : MyUserFetcherDelegate {
    
    //MARK: - 2in1 Fetcher
    
    func setupFetchers() {
        self.setupDirectoryFetcher()
        self.setupMyUserFetcher()
    }
    
    
    
    //MARK: - My User Fetcher
    
    func setupMyUserFetcher() {
        
        self.myUserFetcher = MyUserFetcher()
        self.myUserFetcher?.delegate = self
        self.myUserFetcher?.monitorMyUser()
        
    }
    
    func myUserUpdated(user: User) {
        
        guard self.userArray.contains(where: {$0.userID == user.userID}) else { return }
        
        self.userArray.removeAll(where: {$0.userID == user.userID})
        self.userArray.append(user)
        self.userArray.sort(by: {$1.dateJoined.compare($0.dateJoined) == .orderedAscending})
        self.tableView.reloadData()
    }
    
    
    
    //MARK: - Directory Fetcher
    
    
    @objc func didRefreshControl() {
        self.fetchDirectory()
    }
    
    func setupDirectoryFetcher() {
        self.setupSpinner()
        self.fetchDirectory()
    }
    
    func fetchDirectory() {
        
        UserDirectory.shared.getDirectory { (userArray) in
            self.refreshControl?.endRefreshing()
            self.spinner.stopAnimating()
            
            self.userArray = userArray
            self.userArray.sort(by: {$1.dateJoined.compare($0.dateJoined) == .orderedAscending})
            
            self.tableView.reloadData()
        }
        
    }

    
    
    
    
    //MARK: - Tool
    
    func getMutualArtists(for user : User) -> Int {
        
        guard let myUID = Auth.auth().currentUser?.uid else { return 0 }
        
        guard let myU = self.userArray.first(where: {$0.userID == myUID}) else { return 0 }
        
        let sharedInterests = myU.interests.filter({user.interests.contains($0)})
        return sharedInterests.count
        
        
    }
    
}
