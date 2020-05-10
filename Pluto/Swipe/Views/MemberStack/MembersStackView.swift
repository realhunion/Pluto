//
//  MembersStackView.swift
//  BUMP
//
//  Created by Hunain Ali on 4/13/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class MembersStackView : UICollectionView, UICollectionViewDelegate {
    
    var userArray : [MetaUser] = []
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let cLayout = UICollectionViewFlowLayout()
        
        cLayout.scrollDirection = .horizontal
        cLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 0)
        cLayout.itemSize = CGSize(width: frame.height-40, height: frame.height-40)
        cLayout.minimumLineSpacing = 4
        cLayout.minimumInteritemSpacing = 0
        
        
        
        super.init(frame: frame, collectionViewLayout: cLayout)
        
        self.register(MemberCell.self, forCellWithReuseIdentifier: "memberCell")
        self.dataSource = self
        self.delegate = self
        
        self.alwaysBounceHorizontal = true
        self.alwaysBounceVertical = false
        
        self.backgroundColor = UIColor.clear
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //    @objc private func handleTap(_ button: TinderButton) {
    @objc private func handleTap() {
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
        }
    }
}

extension MembersStackView: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard !self.userArray.isEmpty else { return 0 }
        return self.userArray.count + 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: "memberCell", for: indexPath) as! MemberCell

        if indexPath.row == 0 {
            cell.imageView.image = Constant.imageWith(name: "\(userArray.count)")
            cell.nameLabel.text = "Members"
        } else {
            
            let metaUser = self.userArray[indexPath.row-1]
            
            metaUser.getImageRef().downloadURL { (url, err) in
                guard let theURL = url else { return }
                let transformer = SDImageResizingTransformer(size: CGSize(width: 200, height: 200), scaleMode: .aspectFill)
                cell.imageView.sd_setImage(with: theURL, placeholderImage: UIImage(named: "travisScott"), options: [.scaleDownLargeImages], context: [.imageTransformer: transformer], progress: nil)
            }
            
            cell.nameLabel.text = metaUser.name
        }
        
        return cell
    }
    
    
    
    
    
}

extension TinderButton {
    
    override func draw(_ layer: CALayer, in ctx: CGContext) {
        super.draw(layer, in: ctx)
        applyShadow(radius: 0.2 * bounds.width, opacity: 0.20, offset: CGSize(width: 0, height: 0.15 * bounds.width))
    }
    
}
