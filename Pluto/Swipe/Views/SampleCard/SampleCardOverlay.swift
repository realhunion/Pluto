import UIKit

class SampleCardOverlay: UIView {
    
    static func left() -> UIView {
        let overlay = UIView()
        let leftTextView = SampleOverlayLabelView(withTitle: "PASS",
                                                  color: .systemPink,
                                                  rotation: 0)//rotation: -CGFloat.pi/20)
        overlay.addSubview(leftTextView)
        leftTextView.anchor(bottom: overlay.bottomAnchor, paddingBottom: 20)
        leftTextView.centerXAnchor.constraint(equalTo: overlay.centerXAnchor).isActive = true
        return overlay
    }
    
    static func right() -> UIView {
        let overlay = UIView()
        let rightTextView = SampleOverlayLabelView(withTitle: "LIKE",
                                                   color: .systemGreen,
                                                   rotation: 0) //rotation: -CGFloat.pi/20)
        overlay.addSubview(rightTextView)
        rightTextView.anchor(bottom: overlay.bottomAnchor, paddingBottom: 20)
        rightTextView.centerXAnchor.constraint(equalTo: overlay.centerXAnchor).isActive = true
        return overlay
    }
}

private class SampleOverlayLabelView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    init(withTitle title: String, color: UIColor, rotation: CGFloat) {
        super.init(frame: CGRect.zero)
        layer.borderColor = color.cgColor
        layer.borderWidth = 4
        layer.cornerRadius = 4
        transform = CGAffineTransform(rotationAngle: rotation)
        
        addSubview(titleLabel)
        titleLabel.textColor = color
        titleLabel.attributedText = NSAttributedString(string: title,
                                                       attributes: NSAttributedString.Key.overlayAttributes)
        titleLabel.anchor(top: topAnchor,
                          left: leftAnchor,
                          bottom: bottomAnchor,
                          right: rightAnchor,
                          paddingLeft: 8,
                          paddingRight: 3)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}

extension NSAttributedString.Key {
    
    static var overlayAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 42)!,
        NSAttributedString.Key.kern: 5.0
    ]
}
