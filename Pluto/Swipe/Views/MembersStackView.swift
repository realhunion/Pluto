//
//  MembersStackView.swift
//  BUMP
//
//  Created by Hunain Ali on 4/13/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation
import UIKit

class MembersStackView : UICollectionView, UICollectionViewDelegate {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let cLayout = UICollectionViewFlowLayout()
        print("coupe & \(frame.width)")
        cLayout.scrollDirection = .vertical
        cLayout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 20)
        cLayout.itemSize = CGSize(width: frame.width - 20, height: frame.width)
        cLayout.minimumInteritemSpacing = 0
        cLayout.minimumLineSpacing = 20
//        cLayout.
        
        
        super.init(frame: frame, collectionViewLayout: cLayout)
        
        self.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        self.dataSource = self
        self.delegate = self
        
        self.alwaysBounceVertical = true
        
        self.backgroundColor = UIColor.clear
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
//    @objc private func handleTap(_ button: TinderButton) {
    @objc private func handleTap() {
    print("handle userButton tap")
//        delegate?.didTapButton(button: button)
        
//        let vc = ProfileVC(style: .grouped)
//        (UIApplication.topView)
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            // topController should now be your topmost view controller
//            let vc = ProfileVC(style: .grouped)
//            vc.modalPresentationStyle = .pageSheet
//            topController.present(vc, animated: true, completion: nil)
        }
    }
}

extension MembersStackView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let random = Int.random(in: 0...40)
        return random
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.layer.cornerRadius = cell.frame.width/2
        cell.backgroundColor = .clear
        
//        let x = Constant.payload[indexPath.row]
//
//        for view in cell.subviews {
//            view.removeFromSuperview()
//        }
//
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.bounds.width, height: cell.bounds.width))
//        cell.addSubview(imageView)
//
//        let label = UILabel(frame: CGRect(x: 0, y: cell.bounds.width, width: cell.bounds.width, height: 20.0))
//        cell.addSubview(label)
//        label.adjustsFontSizeToFitWidth = true
//        let array = ["Harry","Ross",
//                     "Bruce","Cook",
//                     "Carolyn","Morgan",
//                     "Albert","Walker",
//                     "Randy","Reed",
//                     "Larry","Barnes",
//                     "Lois","Wilson",
//                     "Jesse","Campbell",
//                     "Ernest","Rogers",
//                     "Theresa","Patterson",
//                     "Henry","Simmons",
//                     "Michelle","Perry",
//                     "Frank","Butler",
//                     "Shirley"]
//        let random = Int.random(in: 0...array.count-1)
//        label.text = array[random]
//        label.font  = UIFont.systemFont(ofSize: 13.0, weight: .bold)
//        label.textAlignment = .center
//
//        imageView.contentMode = .scaleAspectFill
//        imageView.layer.cornerRadius = cell.bounds.width/2
//        imageView.layer.masksToBounds = true
//        imageView.sd_setImage(with: x.imageURL, completed: nil)
////        imageView.image = UIImage(named: "travisScott")!
//
////        (self, action: #selector(handleTap), for: .touchUpInside)
//        imageView.isUserInteractionEnabled = true
//        let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
//        singleTap.numberOfTapsRequired = 1
//        imageView.addGestureRecognizer(singleTap)
//        imageView.target(forAction: #selector(handleTap), withSender: self)
//
//        cell.applyShadow(radius: 0.06 * bounds.width, opacity: 0.4, offset: CGSize(width: 0, height: 0.10 * bounds.width), color: UIColor.black)
////        cell.clipsToBounds = false
        
        return cell
    }
    
    
    
    
    
    
}

extension TinderButton {
    
    override func draw(_ layer: CALayer, in ctx: CGContext) {
        super.draw(layer, in: ctx)
        applyShadow(radius: 0.2 * bounds.width, opacity: 0.20, offset: CGSize(width: 0, height: 0.15 * bounds.width))
    }
    
}
    
    
class UICollectionViewX: UICollectionView {
    
    let fadePercentage: Double = 0.20
    let gradientLayer = CAGradientLayer()
    let transparentColor = UIColor.clear.cgColor
    let opaqueColor = UIColor.black.cgColor
    
    var topOpacity: CGColor {
        let scrollViewHeight = frame.size.height
        let scrollContentSizeHeight = contentSize.height
        let scrollOffset = contentOffset.y
        
        let alpha:CGFloat = (scrollViewHeight >= scrollContentSizeHeight || scrollOffset <= 0) ? 1 : 0
        
        let color = UIColor(white: 0, alpha: alpha)
        return color.cgColor
    }
    
    var bottomOpacity: CGColor {
        let scrollViewHeight = frame.size.height
        let scrollContentSizeHeight = contentSize.height
        let scrollOffset = contentOffset.y
        
        let alpha:CGFloat = (scrollViewHeight >= scrollContentSizeHeight || scrollOffset + scrollViewHeight >= scrollContentSizeHeight) ? 1 : 0
        
        let color = UIColor(white: 0, alpha: alpha)
        return color.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        self.delegate = self
        let maskLayer = CALayer()
        maskLayer.frame = self.bounds
        
        gradientLayer.frame = CGRect(x: self.bounds.origin.x, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        gradientLayer.colors = [topOpacity, opaqueColor, opaqueColor, bottomOpacity]
        gradientLayer.locations = [0, NSNumber(floatLiteral: fadePercentage), NSNumber(floatLiteral: 1 - fadePercentage), 1]
        maskLayer.addSublayer(gradientLayer)
        
        self.layer.mask = maskLayer
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        gradientLayer.colors = [topOpacity, opaqueColor, opaqueColor, bottomOpacity]
    }
    
}


extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
        case .bottom:
            border.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height)
        case .right:
            border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        addSublayer(border)
    }
}
