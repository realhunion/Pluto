//
//  HomeTabBarVC.swift
//  Pluto
//
//  Created by Hunain Ali on 4/18/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import UIKit

enum Tabs: Int {
    case swipe = 0
    case directory = 1
    case myProfile = 2
}


class HomeTabBarVC: UITabBarController, UITabBarControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        self.tabBar.isTranslucent = false
//        self.tabBar.tintColor = UIColor.systemPink
        
        self.setupTabBar()
    }
    
    
    var swipeVC = SwipeVC()
    var directoryVC = DirectoryVC()
    var myProfileVC = MyProfileVC(style: .insetGrouped)
    
    func setupTabBar() {
        
        let _ = swipeVC.view
        let _ = directoryVC.view
        let _ = myProfileVC.view
        
        swipeVC.title = "Swipe"
        directoryVC.title = "Directory"
//        myProfileVC.title = "My Profile"
        
        
        let myProfileNC = UINavigationController(rootViewController: myProfileVC)
        let swipeNC = UINavigationController(rootViewController: swipeVC)
        let directoryNC = UINavigationController(rootViewController: directoryVC)
        
        directoryNC.navigationBar.prefersLargeTitles = true
        myProfileNC.navigationBar.prefersLargeTitles = true
        
        let profileImage =  UIImage(named: "profileIcon")!.resizedImage(newSize: CGSize(width: 30, height: 30))
        let heartImage = UIImage(named: "fingerIcon")!.resizedImage(newSize: CGSize(width: 30, height: 30))
        let directoryImage = UIImage(named: "directoryIcon")!.resizedImage(newSize: CGSize(width: 30, height: 30))
        let myProfileItem = UITabBarItem(title: "My Profile", image: profileImage, selectedImage: nil)
        let swipeItem = UITabBarItem(title: "Swipe", image: heartImage, selectedImage: nil)
        let directoryItem = UITabBarItem(title: "Directory", image: directoryImage, selectedImage: nil)
        
        myProfileItem.tag = 2
        swipeItem.tag = 0
        directoryItem.tag = 1
        
        myProfileVC.tabBarItem = myProfileItem
        swipeVC.tabBarItem = swipeItem
        directoryVC.tabBarItem = directoryItem
        
        let tabBarControllers = [swipeNC, directoryNC, myProfileNC]
        self.viewControllers = tabBarControllers
        self.selectedIndex = currentIndex
        
        
    }
    
    
    
    
    var currentIndex : Int = 0//Tabs.directory.rawValue
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        currentIndex = selectedIndex
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if selectedIndex == Tabs.directory.rawValue {
            if !LoginManager.shared.isLoggedIn() {
                self.selectedIndex = currentIndex
            }
        }
        
        
        if selectedIndex == Tabs.myProfile.rawValue {
            if !LoginManager.shared.isLoggedIn() {
                self.selectedIndex = currentIndex
            }
        }
    }
    
    
    
    
}
