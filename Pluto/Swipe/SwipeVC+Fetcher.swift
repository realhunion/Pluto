//
//  SwipeVC+Fetcher.swift
//  Pluto
//
//  Created by Hunain Ali on 4/28/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation
import UIKit
import QuickLayout
import Firebase

extension SwipeVC {
    
    
    func fetchCards() {
            
        self.hideBackLabel()
        self.startSpinner()
        SwipeManager.shared.getCards { (array) in
            
            self.stopSpinner()
            
            guard let ar = array else { self.showFetchError(); return }
            
            self.showBackLabel()
            
            self.interestIDArray = ar
            
            self.cardStack.reloadData()
        }
    }
    
    func showFetchError() {
        let alert = UIAlertController(title: "Something went wrong :/", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { (action) in
            self.fetchCards()
        }))
        self.present(alert, animated: true)
    }
    
    
    
    
    
    
}
