
import QuickLayout


class SampleCard: SwipeCard {
    
    override func minimumSwipeSpeed(on direction: SwipeDirection) -> CGFloat {
        return 400
    }
    
    override var swipeDirections: [SwipeDirection] {
        return [.left, .up, .right]
    }
    
    override init(frame: CGRect) {
//        let animator =
        super.init(frame: frame)
        footerHeight = 80
//        self.animationOptions = CardAnimationOptions(totalSwipeDuration: 0.4)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.layoutButtonStackView()
    }
    
    var buttonStackView = ButtonStackView()
    private func layoutButtonStackView() {
        self.content?.addSubview(buttonStackView)
        buttonStackView.anchor(left: content?.safeAreaLayoutGuide.leftAnchor, bottom: content?.safeAreaLayoutGuide.bottomAnchor, right: content?.safeAreaLayoutGuide.rightAnchor, paddingLeft: 24, paddingBottom: 12, paddingRight: 24)
        buttonStackView.anchor(left: content?.safeAreaLayoutGuide.leftAnchor, bottom: content?.safeAreaLayoutGuide.bottomAnchor, right: content?.safeAreaLayoutGuide.rightAnchor, paddingLeft: 24, paddingBottom: 36, paddingRight: 32)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    deinit {
        print("vvs deinit")
    }
    
    override func overlay(forDirection direction: SwipeDirection) -> UIView? {
        switch direction {
        case .left:
            return SampleCardOverlay.left()
        case .up:
            return SampleCardOverlay.left()
//            return SampleCardOverlay.up()
        case.right:
            return SampleCardOverlay.right()
        default:
            return nil
        }
    }
    
    var interest : Interest?
    func configure(withID id: String) {
        
        self.content = SampleCardContentView(withImage: UIImage(named: "travisScott"))
        
        let spinner = UIActivityIndicatorView()
        self.content!.addSubview(spinner)
        spinner.center = self.content!.center
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        spinner.layoutToSuperview(.centerX)
        spinner.layoutToSuperview(.centerY)
        
        SwipeManager.shared.getInterest(interestID: id) { (interest) in
            
            spinner.stopAnimating()
            
            guard let i = interest else { return }
            
            self.interest = i
            
            let content = self.content as! SampleCardContentView
            content.setImage(withImageURL: URL(string: i.imageURL))
            
            let footer = SampleCardFooterView(withTitle: i.name, subtitle:  "\(i.likedBy.count) Members")
            
            footer.interest = interest
            self.footer = footer
            
        }
    }
    
}
