import UIKit

class SampleCardFooterView: UIView {
    
    private var label = UILabel()
    
    private var gradientLayer: CAGradientLayer?
    var interest : Interest?
    
    private let boostButton: TinderButton = {
        let button = TinderButton()
//        button.setImage(UIImage(named: "lightning"), for: .normal)
        button.setImage(Constant.imageWith(name: "𝐢"), for: .normal)
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.tag = 5
        
        
        return button
    }()
    
    @objc func handleTap() {
        guard LoginManager.shared.isLoggedIn() else { return }
        guard let i = self.interest else { return }
        if let topVC = UIApplication.topViewController() as? SwipeVC {
            if let topNC = topVC.navigationController {
                let vc = InterestProfileVC(style: .insetGrouped)
                vc.interest = i
                topNC.pushViewController(vc, animated: true)
                
            }
        }
    }
    
    init(withTitle title: String?, subtitle: String?) {
        super.init(frame: CGRect.zero)
        backgroundColor = .clear
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        layer.cornerRadius = 10
        clipsToBounds = true
        isOpaque = false
        initialize(title: title, subtitle: subtitle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    private func initialize(title: String?, subtitle: String?) {
        let attributedText = NSMutableAttributedString(string: (title ?? "") + "\n", attributes: NSAttributedString.Key.titleAttributes)
        if let subtitle = subtitle, subtitle != "" {
            attributedText.append(NSMutableAttributedString(string: subtitle, attributes: NSAttributedString.Key.subtitleAttributes))
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            paragraphStyle.lineBreakMode = .byTruncatingTail
            attributedText.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSRange(location: 0, length: attributedText.length))
            label.numberOfLines = 2
        }
        
//        label.backgroundColor = UIColor.yellow.withAlphaComponent(0.36)
        
        label.attributedText = attributedText
        label.adjustsFontSizeToFitWidth = true
        addSubview(label)
        
//        label.translatesAutoresizingMaskIntoConstraints = false
        boostButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(boostButton)
        
        boostButton.layoutToSuperview(.right, offset: -20)
        boostButton.layoutToSuperview(.top, offset: 0)
//        boostButton.layoutToSuperview(.bottom, offset: -20)
//        boostButton.layoutToSuperview(.centerY)
        
//        boostButton.widthAnchor.constraint(equalTo: boostButton.heightAnchor, multiplier: 1.0).isActive = true
        
//        boostButton.layout(
        boostButton.set(.width, of: 50)
        boostButton.set(.height, of: 50)
        
        let v = UIView()
        v.backgroundColor = UIColor.green.withAlphaComponent(0.4)
        v.translatesAutoresizingMaskIntoConstraints = false
        addSubview(v)
//        v.layoutToSuperview(.right, offset: 0)
//        v.layoutToSuperview(.top, offset: 0)
//        v.layoutToSuperview(.bottom, offset: 0)
//        v.set(.width, of: 100)
    }
    
    override func layoutSubviews() {
        let padding : CGFloat = 20.0
        label.frame = CGRect(x: padding,
                             y: bounds.height - label.intrinsicContentSize.height - padding,
                             width: bounds.width - 2 * padding - 80,
                             height: label.intrinsicContentSize.height)
    }
}

extension NSAttributedString.Key {
    
    static var shadowAttribute: NSShadow = {
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: 0, height: 1)
        shadow.shadowBlurRadius = 2
        shadow.shadowColor = UIColor.black.withAlphaComponent(0.3)
        return shadow
    }()
    
    static var titleAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 36.0, weight: .bold),
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.shadow: NSAttributedString.Key.shadowAttribute
    ]
    
    static var subtitleAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0, weight: .medium),
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.shadow: NSAttributedString.Key.shadowAttribute
    ]
}
