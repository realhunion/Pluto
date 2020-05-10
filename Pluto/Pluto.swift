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
        
        SwiftEntryKit.dismiss()
        UIApplication.topViewController()?.dismiss(animated: false, completion: nil)
        
        self.homeTabBarVC.swipeVC.shutDown()
        self.homeTabBarVC.swipeVC.fetchCards()
        
        self.homeTabBarVC.directoryVC.shutDown()
        self.homeTabBarVC.directoryVC.setupFetchers()
        
        self.homeTabBarVC.myProfileVC.shutDown()
        self.homeTabBarVC.myProfileVC.setupMyProfileFetcher()
        
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
        
        self.homeTabBarVC.currentIndex = 1
        self.homeTabBarVC.selectedIndex = 1
    }
    
    
    func appWillEnterForeground() {
        
        guard LoginManager.shared.isLoggedIn() else { return }
        
        self.homeTabBarVC.directoryVC.fetchDirectory()
        
//        self.homeTabBarVC.myProfileVC.refreshMyProfileFetcher()
    }
    
}
