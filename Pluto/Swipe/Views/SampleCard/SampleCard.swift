
import QuickLayout
import Firebase

class SampleCard: SwipeCard {
    
    override func minimumSwipeSpeed(on direction: SwipeDirection) -> CGFloat {
        return 240
    }
    
    override var swipeDirections: [SwipeDirection] {
        return [.up, .right]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        footerHeight = 80
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    deinit {
        print("vvs deinit")
    }
    
    override func overlay(forDirection direction: SwipeDirection) -> UIView? {
        switch direction {
        case .up:
            return SampleCardOverlay.left()
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
        
        InterestDirectory.shared.getInterest(interestID: id) { (interest) in
            
            spinner.stopAnimating()
            guard let i = interest else { return }
            
            self.interest = i
            
            let content = self.content as! SampleCardContentView
            content.setupImage(withImageURL: URL(string: i.imageURL))
            
            let uIDArray = i.likedBy.map({$0.userID})
            
            if !i.likedBy.isEmpty {
                
                if Auth.auth().currentUser != nil {
                    UserDirectory.shared.getUsers(userIDArray: uIDArray) { (userArray) in
                        content.setupMembersStackView(userArray: userArray)
                    }
                }
            }

            let footer = SampleCardFooterView(withTitle: i.name, subtitle:  i.description)
            footer.interest = interest
            self.footer = footer

        }
    }
    
}
