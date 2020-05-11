import UIKit
import SDWebImage
import QuickLayout

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
        gradient.colors = [UIColor.black.withAlphaComponent(0.00).cgColor,
                           UIColor.black.withAlphaComponent(0.8).cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        return gradient
    }()
    
    private let gradientLayer2: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.withAlphaComponent(0.00).cgColor,
                           UIColor.black.withAlphaComponent(0.8).cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 1)
        gradient.endPoint = CGPoint(x: 0.5, y: 0)
        gradient.isHidden = true
        return gradient
    }()
    
    init(withImage image : UIImage?) {
        super.init(frame: .zero)
        
        self.imageView.image = image
        
        initialize()
    }
    
    func setupImage(withImageURL imageURL: URL?) {
        let placeholder : UIImage? = UIImage(named: "travisScott")
        self.imageView.sd_setImage(with: imageURL, placeholderImage: placeholder, options: [], context: nil)
        //[SDWebImageOptions.fromLoaderOnly]
    }
    
    func setupMembersStackView(userArray : [User]) {
        
        let height : CGFloat = 120.0
        let m = MembersStackView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: height), collectionViewLayout: UICollectionViewFlowLayout())
        m.clipsToBounds = true
        //FIX: FUTURE
        if userArray.count > 4 {
            m.userArray = userArray.shuffled()
        } else {
            m.userArray = userArray
        }
        addSubview(m)
        m.layoutToSuperview(.top, offset: 0)
        m.layoutToSuperview(.left, offset: 0)
        m.layoutToSuperview(.right, offset: 0)
        m.set(.height, of: height)
        
        self.gradientLayer2.isHidden = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    private func initialize() {
        addSubview(backgroundView)
        backgroundView.anchorToSuperview()
        backgroundView.addSubview(imageView)
        imageView.anchorToSuperview()
        self.applyShadow(radius: 8, opacity: 0.2, offset: CGSize(width: 0, height: 2))
        
        self.backgroundView.layer.insertSublayer(self.gradientLayer, above: self.imageView.layer)
        
        self.backgroundView.layer.insertSublayer(self.gradientLayer2, above: self.imageView.layer)
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let heightFactor: CGFloat = 0.35
        gradientLayer.frame = CGRect(x: 0, y: (1 - heightFactor) * bounds.height,
                                     width: bounds.width,
                                     height: heightFactor * bounds.height)
        
        gradientLayer2.frame = CGRect(x: 0, y: 0,
                                     width: bounds.width,
                                     height: 180)
        
    }
    
    
}
