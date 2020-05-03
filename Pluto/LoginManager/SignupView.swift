//
//  SignupView.swift
//  OASIS2
//
//  Created by Hunain Ali on 8/14/19.
//  Copyright © 2019 theDevHoney. All rights reserved.
//

import UIKit
import QuickLayout
import SwiftEntryKit
import Firebase


class SignupView: UIView {
    
    let db = Firestore.firestore()
    
    let namePlaceholder = "Your Name"
    let emailPlaceholder = "Your .edu Email"
    let passwordPlaceholder = "Choose a Password"
    
    deinit {
        print("boop deinit signupview")
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Pluto Grinnell"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    lazy var nameTextField: BaseTextField = {
        let textField = BaseTextField()
        
        textField.placeholder = self.namePlaceholder

        textField.keyboardType = UIKeyboardType.alphabet
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.autocapitalizationType = UITextAutocapitalizationType.words
        
        textField.delegate = self
        
        return textField
    }()
    
    lazy var emailTextField: BaseTextField = {
        let textField = BaseTextField()
        
        textField.placeholder = self.emailPlaceholder

        textField.keyboardType = UIKeyboardType.alphabet
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        
        textField.delegate = self
        
        return textField
    }()
    
    lazy var passTextField: BaseTextField = {
        let textField = BaseTextField()
        
        textField.placeholder = self.passwordPlaceholder
        
        textField.keyboardType = UIKeyboardType.alphabet
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        
        textField.isSecureTextEntry = true
        
        textField.delegate = self
        
        
        return textField
    }()
    
    lazy var segmentClassYear : UISegmentedControl = {
        let segment : UISegmentedControl = UISegmentedControl(frame: CGRect.zero)
        segment.insertSegment(withTitle: "Fresh", at: 1, animated: false)
        segment.insertSegment(withTitle: "Soph", at: 2, animated: false)
        segment.insertSegment(withTitle: "Junior", at: 3, animated: false)
        segment.insertSegment(withTitle: "Senior", at: 4, animated: false)
        
        segment.selectedSegmentIndex = 0
        
        return segment
    }()
    
    lazy var signupButton : UIButton = {
        let button = UIButton()
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(signupButtonPressed), for: .touchUpInside)
        button.setTitleColor(UIColor.white.withAlphaComponent(1.0), for: .normal)
        button.setTitleColor(UIColor.white.withAlphaComponent(0.8), for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        button.setTitle("Sign Up!", for: .normal)
        button.backgroundColor = Constant.oPrimary
        
        return button
    }()
    
    lazy var loginCornerButton : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(switchToLoginView), for: .touchUpInside)
        button.setTitleColor(Constant.oPrimary.withAlphaComponent(1.0), for: .normal)
        button.setTitleColor(Constant.oPrimary.withAlphaComponent(0.8), for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()
    
    lazy var detailLabel : UILabel = {
        let label = UILabel()
        label.text = "Hunain Ali x James Lim"
        label.font = UIFont.systemFont(ofSize: 11.0, weight: .bold)
        label.textColor = UIColor.systemGray
        label.textAlignment = .center
        
        return label
    }()
    
    
    public init() {
        super.init(frame: UIScreen.main.bounds)
        
        self.backgroundColor = .systemBackground
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        
        let i = UIImageView()
        i.clipsToBounds = true
        self.insertSubview(i, at: 0)
        i.contentMode = .scaleAspectFill
        i.frame = self.frame
        i.image = UIImage(named: "travisScott")
        
        setupPaddingView()
        setupTitleLabel()
        setupLoginCornerButton()
        setupNameTextField()
        setupEmailTextField()
        setupPassTextField()
        setupSignupButton()
        setupDetailLabel()
//        setupPrivacyButton()
        setupSegment()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var paddingView : UIView = UIView()
    func setupPaddingView() {
        
        addSubview(paddingView)
        paddingView.layoutToSuperview(.top, offset: 40)
        paddingView.layoutToSuperview(.bottom, offset: -30)
        paddingView.layoutToSuperview(.left, offset: 40)
        paddingView.layoutToSuperview(.right, offset: -40)
        
    }
    
    
    func setupTitleLabel() {
        
        paddingView.addSubview(titleLabel)
        titleLabel.layoutToSuperview(.top, offset: 0)
        titleLabel.layoutToSuperview(.left, offset: 0)
        
    }
    
    func setupLoginCornerButton() {
        paddingView.addSubview(loginCornerButton)
        
        loginCornerButton.layout(.left, to: .right, of: titleLabel, offset: 20)
        
        loginCornerButton.layoutToSuperview(.top, offset: 0)
        loginCornerButton.layoutToSuperview(.right, offset: 0)
    }
    
    func setupNameTextField() {
        
        paddingView.addSubview(nameTextField)
        nameTextField.layout(.top, to: .bottom, of: loginCornerButton, offset: 10)
        nameTextField.layout(.top, to: .bottom, of: titleLabel, offset: 10)
        nameTextField.layoutToSuperview(.left, offset: 0)
        nameTextField.layoutToSuperview(.right, offset: 0)
        
        let height: CGFloat = 35
        nameTextField.set(.height, of: height)
    }
    
    func setupEmailTextField() {
        
        paddingView.addSubview(emailTextField)
        emailTextField.layout(.top, to: .bottom, of: nameTextField, offset: 10)
        emailTextField.layoutToSuperview(.left, offset: 0)
        emailTextField.layoutToSuperview(.right, offset: 0)
        
        let height: CGFloat = 35
        emailTextField.set(.height, of: height)
    }
    
    func setupPassTextField() {
        
        paddingView.addSubview(passTextField)
        passTextField.layout(.top, to: .bottom, of: emailTextField, offset: 10)
        passTextField.layoutToSuperview(.left, offset: 0)
        passTextField.layoutToSuperview(.right, offset: 0)
        
        let height: CGFloat = 35
        passTextField.set(.height, of: height)
    }
    
    func setupSegment() {
        
        paddingView.addSubview(segmentClassYear)
        segmentClassYear.layout(.top, to: .bottom, of: passTextField, offset: 10)
        segmentClassYear.layoutToSuperview(.left, offset: 0)
        segmentClassYear.layoutToSuperview(.right, offset: 0)

        
        let height: CGFloat = 35
        segmentClassYear.set(.height, of: height)
    }
    
    func setupSignupButton() {
        
        paddingView.addSubview(signupButton)
        signupButton.layout(.top, to: .bottom, of: segmentClassYear, offset: 10)
        signupButton.layoutToSuperview(.left, offset: 0)
        signupButton.layoutToSuperview(.right, offset: 0)
        
        let height: CGFloat = 40
        signupButton.set(.height, of: height)
    }
    
    func setupDetailLabel() {
        
        paddingView.addSubview(detailLabel)
        detailLabel.layout(.top, to: .bottom, of: signupButton, offset: 20)
//
        detailLabel.layoutToSuperview(.right, offset: 0)
        detailLabel.layoutToSuperview(.left, offset: 0)
        detailLabel.layoutToSuperview(.bottom, offset: 0)
        
    }
    
    func setupPrivacyButton() {
//        paddingView.addSubview(privacyButton)
        
//        privacyButton.layout(.top, to: .bottom, of: detailLabel, offset: 0)
        
//        privacyButton.layoutToSuperview(.right, offset: 0)
//        privacyButton.layoutToSuperview(.left, offset: 0)
//        privacyButton.layoutToSuperview(.bottom, offset: 0)
    }
    
    
    
    
    
    
    
//    @objc func signupButtonPressed() {
//        self.loginVC?.signupButtonPressed()
//        
//    }
    
    @objc func switchToLoginView() {
       let x = LoginManager()
        x.presentLoginVC()
    }
    
    
    @objc func privacyButtonTapped() {
        self.emailTextField.resignFirstResponder()
        self.nameTextField.resignFirstResponder()
        self.passTextField.resignFirstResponder()
        
        SwiftEntryKit.dismiss {
            let vc = InfoVC(style: .insetGrouped)
            vc.title = "Terms & Privacy"
            vc.infoText = "Pretty simple.\n\n1. Be a prospective or current student at Grinnell.\n2. Use your real name.\n3. Don't write anything offensive in profile fields.\n4. We reserve right to remove anyone not following 1-3.\n\n5. All data to & from the app is stored on Firebase servers.\n6. Only app admin has root access to database.\n\n7. We're not liable for user's actions stemming on & off the platform.\n\nEnjoy!"
            let nvc = UINavigationController(rootViewController: vc)
            UIApplication.topViewController()?.present(nvc, animated: true, completion: nil)
        }
    }
        
    

    
}



extension SignupView : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        textField.layoutIfNeeded()
    }
}
