//
//  AppDelegate.swift
//  Pluto
//
//  Created by Hunain Ali on 4/18/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var pluto : Pluto?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.configureMyFirebase()
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        self.pluto = Pluto()
        self.window?.rootViewController = self.pluto?.homeTabBarVC
//        self.window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        return true
    }
    
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        pluto?.appWillEnterForeground()
    }
    
    
    
    
    // MARK: - Configure Firebase
    
    func configureMyFirebase() {
        FirebaseApp.configure()
        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = false
        Firestore.firestore().settings = settings
    }
    
    
    
    
    
    
    

}
