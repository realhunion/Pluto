//
//  MemberCellCollectionViewCell.swift
//  Pluto
//
//  Created by Hunain Ali on 5/10/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import UIKit

class MemberCell: UICollectionViewCell {
    
    let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.font  = UIFont.systemFont(ofSize: 13.0, weight: .bold)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame.integral)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(imageView)
        imageView.frame = CGRect(x: 10, y: 0, width: self.bounds.width-20, height: self.bounds.height-20)
        imageView.layer.cornerRadius = (self.bounds.width-20)/2
        
        self.addSubview(nameLabel)
        nameLabel.frame = CGRect(x: 10, y: self.bounds.height-20, width: self.bounds.width-20, height: 20.0)
    }
    
}
