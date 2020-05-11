//
//  SwipeVC.swift
//  BUMP
//
//  Created by Hunain Ali on 4/11/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import UIKit


class SwipeVC: UIViewController {
    
    let cardStack = SwipeCardStack()
    
    var interestIDArray : [String] = []
    
    override func viewDidLoad() {
        
        self.setupBackgroundGradient()
        self.setupBackLabel()
        self.setupSpinner()
    
        self.setupCardStack()
        
        self.fetchCards()
    }
    
    func shutDown() {
        self.dismiss(animated: false, completion: nil)
        self.navigationController?.popToRootViewController(animated: false)
        
        self.stopSpinner()
        self.hideBackLabel()
        
        self.interestIDArray = []
        self.cardStack.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.cardStack.isUserInteractionEnabled = true
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.cardStack.isUserInteractionEnabled = true
        super.viewWillDisappear(animated)
    }

    
    
    
    //MARK: - Setup CardStack
    
    func setupCardStack() {
        
        self.view.addSubview(cardStack)
        cardStack.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor)
        cardStack.cardStackInsets = UIEdgeInsets(top: 12.0, left: 12.0, bottom: 18.0, right: 12.0)
        
        let ti = TimeInterval(exactly: 0.12)
        cardStack.animationOptions = CardStackAnimationOptions(shiftDuration: ti!, swipeDuration: ti, undoDuration: nil, resetDuration: nil)
        
        cardStack.numberOfVisibleCards = 4
        
        cardStack.delegate = self
        cardStack.dataSource = self
        
    }
    
    
    //MARK: - Setup Spinner
    
    lazy var spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.isHidden = true
        return spinner
    }()
    
    func setupSpinner() {
        self.view.addSubview(self.spinner)
        self.spinner.layoutToSuperview(.centerX)
        self.spinner.layoutToSuperview(.centerY)
    }
    
    func startSpinner() {
        self.spinner.isHidden = false
        self.spinner.startAnimating()
    }
    
    func stopSpinner() {
        self.spinner.stopAnimating()
    }
    
    
    //MARK: - Setup Spinner
    
    lazy var backLabel : UILabel = {
        let l = UILabel(frame: CGRect.zero)
        l.text = "That's all we've got.\nYou got em all."
        l.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .center
        l.numberOfLines = 2
        l.isHidden = true
        return l
    }()
    
    func setupBackLabel() {
        self.view.addSubview(self.backLabel)
        self.backLabel.layoutToSuperview(.centerX)
        self.backLabel.layoutToSuperview(.centerY)
    }
    
    func showBackLabel() {
        self.backLabel.isHidden = false
    }
    
    func hideBackLabel() {
        self.backLabel.isHidden = true
    }
    
    
    
    //MARK: - Setup Gradient
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            self.setupBackgroundGradient()
        }
    }
    
    var gradientLayer : CAGradientLayer?
    private func setupBackgroundGradient() {
        self.gradientLayer?.removeFromSuperlayer()
        self.gradientLayer = CAGradientLayer()
        gradientLayer?.colors = [UIColor.systemBackground.cgColor, UIColor.systemGray5.cgColor]
        gradientLayer?.frame = view.bounds
        if let gLayer = self.gradientLayer {
            view.layer.insertSublayer(gLayer, at: 0)
        }
        
    }
    
}

