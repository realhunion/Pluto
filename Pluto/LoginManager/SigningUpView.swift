//
//  SigningUpView.swift
//  Pluto
//
//  Created by Hunain Ali on 5/11/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import UIKit
import QuickLayout

class SigningUpView : UIView {
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Signing up..."
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    
    public init() {
        super.init(frame: UIScreen.main.bounds)
        
        self.backgroundColor = .systemBackground
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        
        addSubview(label)
        label.layoutToSuperview(.right, offset: -20)
        label.layoutToSuperview(.left, offset: 20)
        label.layoutToSuperview(.top, offset: 20)
        label.layoutToSuperview(.bottom, offset: -20)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
