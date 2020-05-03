//
//  SwipeVC+Datasource.swift
//  Pluto
//
//  Created by Hunain Ali on 4/28/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import UIKit

extension SwipeVC: SwipeCardStackDataSource, SwipeCardStackDelegate {
    
    
    
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        let card = SampleCard()
        let id = self.interestIDArray[index]
        card.configure(withID: id)
        print("index_\(index)")
        
        return card
        
    }
    
    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        print("lol_\(interestIDArray.count)")
        return interestIDArray.count
    }
    
    func didSwipeAllCards(_ cardStack: SwipeCardStack) {
        print("Swiped all cards!")
    }
    
    
    func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection) {
        guard LoginManager.shared.isLoggedIn() else { return }
        if direction == .right {
            SwipeManager.shared.swipedRight(interestID: interestIDArray[index])
        }
        if direction == .left {
            SwipeManager.shared.swipedLeft(interestID: interestIDArray[index])
        }
        if direction == .up {
            SwipeManager.shared.swipedLeft(interestID: interestIDArray[index])
        }
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didSelectCardAt index: Int) {
        guard LoginManager.shared.isLoggedIn() else { return }
    }
}
