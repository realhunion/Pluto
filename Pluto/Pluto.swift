//
//  Pluto.swift
//  Pluto
//
//  Created by Hunain Ali on 4/26/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation
import Firebase
import SwiftEntryKit

class Pluto {
    
    
    let db = Firestore.firestore()
    
    var homeTabBarVC : HomeTabBarVC
    init() {
        self.homeTabBarVC = HomeTabBarVC()
    }
    
    
    func refreshControllers() {
        
        UserDirectory.shared.shutDown()
        InterestDirectory.shared.shutDown()
        
        SwiftEntryKit.dismiss()
        
        self.homeTabBarVC.swipeVC.shutDown()
        self.homeTabBarVC.swipeVC.fetchCards()
        
        self.homeTabBarVC.directoryVC.shutDown()
        self.homeTabBarVC.directoryVC.setupFetcher()
        
        self.homeTabBarVC.myProfileVC.shutDown()
        self.homeTabBarVC.myProfileVC.setupFetcher()
        
    }
    
    
    func logOut() {
        
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        self.refreshControllers()
        
        self.homeTabBarVC.currentIndex = 0
        self.homeTabBarVC.selectedIndex = 0
    }
    
    func logIn() {
        
        self.refreshControllers()
        
        self.homeTabBarVC.currentIndex = 0
        self.homeTabBarVC.selectedIndex = 0
    }
    
    
    func appWillEnterForeground() {
        
        guard LoginManager.shared.isLoggedIn() else { return }
        
        UserDirectory.shared.fetchDirectory { (uArray) in
            self.homeTabBarVC.directoryVC.fetchDirectory()
            self.homeTabBarVC.myProfileVC.fetchConnections()
        }
    }
    
}
