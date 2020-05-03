import UIKit
import SDWebImage

class SampleCardContentView: UIView {
    
    private let backgroundView: UIView = {
        let background = UIView()
        background.clipsToBounds = true
        background.layer.cornerRadius = 10
        return background
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.withAlphaComponent(0.01).cgColor,
                           UIColor.black.withAlphaComponent(0.8).cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        return gradient
    }()
    
    init(withImageURL imageURL: URL?) {
        super.init(frame: .zero)
        
        self.setImage(withImageURL: imageURL)
        
        initialize()
    }
    
    init(withImage image : UIImage?) {
        super.init(frame: .zero)
        
        self.imageView.image = image
        
        initialize()
    }
    
    func setImage(withImageURL imageURL: URL?) {
        let placeholder : UIImage? = UIImage(named: "travisScott")
        self.imageView.sd_setImage(with: imageURL, placeholderImage: placeholder, options: [SDWebImageOptions.fromLoaderOnly], context: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    var membersStackView : MembersStackView?
    
    private func initialize() {
        addSubview(backgroundView)
        backgroundView.anchorToSuperview()
        backgroundView.addSubview(imageView)
        imageView.anchorToSuperview()
        self.applyShadow(radius: 8, opacity: 0.2, offset: CGSize(width: 0, height: 2))
        self.backgroundView.layer.insertSublayer(self.gradientLayer, above: self.imageView.layer)
        
    
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let heightFactor: CGFloat = 0.35
        gradientLayer.frame = CGRect(x: 0, y: (1 - heightFactor) * bounds.height,
                                     width: bounds.width,
                                     height: heightFactor * bounds.height)
        
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        guard self.membersStackView == nil else { return }
//        let width : CGFloat = 66.0
//        let height : CGFloat = 300.0
//        self.membersStackView = MembersStackView(frame: CGRect(x: bounds.width - width, y: (bounds.height-height)-80, width: width, height: height), collectionViewLayout: UICollectionViewFlowLayout())
//        self.addSubview(membersStackView!)
        
    }
    
    
}
