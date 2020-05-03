//
//  Utility.swift
//  Pluto
//
//  Created by Hunain Ali on 4/18/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import SwiftEntryKit



class BaseTextField: UITextField {
    
    var padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.cornerRadius = 6
        
        self.backgroundColor = UIColor.systemGray.withAlphaComponent(0.2)
        self.textAlignment = NSTextAlignment.left
        self.adjustsFontSizeToFitWidth = true
        self.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension String {
    func stringByRemovingEmoji() -> String {
        return String(self.filter { !$0.isEmoji() })
    }
}

extension Character {
    fileprivate func isEmoji() -> Bool {
        return Character(UnicodeScalar(UInt32(0x1d000))!) <= self && self <= Character(UnicodeScalar(UInt32(0x1f77f))!)
            || Character(UnicodeScalar(UInt32(0x2100))!) <= self && self <= Character(UnicodeScalar(UInt32(0x26ff))!)
    }
}


extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

enum Constant {
    
    static let oPrimary = UIColor(red: 0.96, green: 0.00, blue: 0.34, alpha: 1.00)
    static let oSecondary = UIColor(red: 0.09, green: 0.47, blue: 0.95, alpha: 1.00)
    
    
    static let oGray = UIColor(red:0.905, green:0.91, blue:0.925, alpha:1.0)
    static let oGrayLight = UIColor(red:0.94, green:0.95, blue:0.96, alpha:1.0)
    
    static let oBlack = UIColor(red:0.08, green:0.09, blue:0.10, alpha:1.0)
    
    
    static let bottomPopUpAttributes : EKAttributes = {
        var attributes = EKAttributes.bottomFloat
        attributes.hapticFeedbackType = EKAttributes.NotificationHapticFeedback.none
        attributes.displayDuration = .infinity
        attributes.screenBackground = .color(color: EKColor(UIColor.black.withAlphaComponent(0.8)))
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .easeOut)
        attributes.roundCorners = .all(radius: 18.0)
        attributes.entranceAnimation = .init(translate: .init(duration: 0.4, spring: .init(damping: 1, initialVelocity: 0)))
        attributes.statusBar = .light
        
        attributes.exitAnimation = .init(translate: .init(duration: 0.15))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.2)))
        attributes.positionConstraints.size = .init(width: .offset(value: 10), height: .intrinsic)
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.bounds.width), height: .constant(value: UIScreen.main.bounds.height))
        
        return attributes
    }()
    
    static let centerPopUpAttributes : EKAttributes = {
        var attributes = EKAttributes.centerFloat
        attributes.hapticFeedbackType = EKAttributes.NotificationHapticFeedback.none
        attributes.displayDuration = .infinity
        attributes.screenBackground = .color(color: EKColor(UIColor.black.withAlphaComponent(0.8)))
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .easeOut)
        attributes.roundCorners = .all(radius: 18.0)
        attributes.entranceAnimation = .init(translate: .init(duration: 0.4, spring: .init(damping: 1, initialVelocity: 0)))
        attributes.statusBar = .light
        
        attributes.exitAnimation = .init(translate: .init(duration: 0.15))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.2)))
        attributes.positionConstraints.size = .init(width: .offset(value: 20), height: .intrinsic)
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.bounds.width), height: .constant(value: UIScreen.main.bounds.height))
        
        return attributes
    }()
    
    static func fixedPopUpAttributes(heightWidthRatio : CGFloat) -> EKAttributes {
        var attributes = EKAttributes.bottomFloat
        attributes.displayDuration = .infinity
        attributes.screenBackground = .color(color: EKColor(UIColor.black.withAlphaComponent(0.8)))
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .easeOut)
        attributes.roundCorners = .all(radius: 18.0)
        attributes.entranceAnimation = .init(translate: .init(duration: 0.4, spring: .init(damping: 1, initialVelocity: 0)))
        attributes.statusBar = .light
        
        attributes.exitAnimation = .init(translate: .init(duration: 0.15))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.2)))
        attributes.positionConstraints.size = .init(width: .offset(value: 10), height: .constant(value: UIScreen.main.bounds.width * heightWidthRatio))
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.bounds.width), height: .constant(value: UIScreen.main.bounds.height))
        
        return attributes
    }
    
    
    static let payload = [
        SampleCardModel(title: "The Beatles", description: "#music", imageURL: URL(string: "https://www.beatlesbible.com/wp/media/beatles-mad-day-out_13.jpg")),
        SampleCardModel(title: "The Rolling Stones", description: "#music", imageURL: URL(string: "https://66.media.tumblr.com/bbce574155a5fd7f40b88a5643530638/tumblr_mymkd1BMZ81r6sispo1_r1_1280.jpg")),
        SampleCardModel(title: "Elvis Presley", description: "#music", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/35/Elvis_Presley_Jailhouse_Rock.jpg/1200px-Elvis_Presley_Jailhouse_Rock.jpg")),
        SampleCardModel(title: "Bob Dylan", description: "#music", imageURL: URL(string: "https://images.genius.com/f5c25eb5996f2f78f7ad8cc3a45d00fe.1000x750x1.jpg")),
        SampleCardModel(title: "U2", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/18/87/fd/1887fd9a69303bdd151077d559bf28b5.jpg")),
        SampleCardModel(title: "Bruce Springsteen", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/e9/87/74/e98774a2ef77333dc833f3fb1d00c567.jpg")),
        SampleCardModel(title: "Madonna", description: "#music", imageURL: URL(string: "https://3.bp.blogspot.com/-iHUXQmYapMg/VPlj8eCtv1I/AAAAAAAAHaw/0Xf19cWn7AM/s1600/madonna-for-tom-munro-photoshoot-3-madonna-let-s-see-what-you-ve-still-got.jpeg")),
        SampleCardModel(title: "Elton John", description: "#music", imageURL: URL(string: "https://iconicimages.net/app/uploads/2017/01/EJ035.jpg")),
        SampleCardModel(title: "Michael Jackson", description: "#music", imageURL: URL(string: "https://papers.co/wallpaper/papers.co-hc08-michael-jackson-concert-king-of-pop-40-wallpaper.jpg?download=true")),
        SampleCardModel(title: "Pink Floyd", description: "#music", imageURL: URL(string: "https://iconicimages.net/app/uploads/2017/01/BW_PF009.jpg")),
        SampleCardModel(title: "Prince", description: "#music", imageURL: URL(string: "https://images.squarespace-cdn.com/content/v1/562eaa6ae4b05b1125147be2/1547262760091-XEBVN4OPRYNELJU5DUJK/ke17ZwdGBToddI8pDm48kGWSdQKjlHWYv6-Km_O64AsUqsxRUqqbr1mOJYKfIPR7LoDQ9mXPOjoJoqy81S2I8GRo6ASst2s6pLvNAu_PZdLNSyvILuuIZXttN5iGDlJ68XcSNXCslwDXtpjoF6UQfnWDpg_rM9mH5t3BIXV0L_Q/b0204be647f5af5cf7a86d83013b28bd--prince-purple-rain-heart.jpg")),
        SampleCardModel(title: "Rod Stewart", description: "#music", imageURL: URL(string: "https://www.gannett-cdn.com/media/Nashville/Nashville/2014/09/18/1411051440001-Rod-Stewart-02.JPG?width=1588")),
        SampleCardModel(title: "Led Zeppelin", description: "#music", imageURL: URL(string: "https://bloximages.chicago2.vip.townnews.com/kearneyhub.com/content/tncms/assets/v3/editorial/4/3c/43cf2b0c-ec8d-11e9-af4f-b315d7820c2d/5da12888296da.image.jpg")),
        SampleCardModel(title: "Frank Sinatra", description: "#music", imageURL: URL(string: "https://cdn.britannica.com/20/187920-050-0425AFBB/Frank-Sinatra-1947.jpg")),
        SampleCardModel(title: "Barbra Streisand", description: "#music", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/en/b/ba/Barbra_Streisand_singing-_1969.jpg")),
        SampleCardModel(title: "David Bowie", description: "#music", imageURL: URL(string: "https://thefader-res.cloudinary.com/private_images/w_1440,c_limit,f_auto,q_auto:best/GettyImages-92783142_pt323t/how-to-stay-glam-as-fuck-forever-according-to-david-bowie.jpg")),
        SampleCardModel(title: "Queen", description: "#music", imageURL: URL(string: "https://pmchollywoodlife.files.wordpress.com/2017/09/freddie-mercury-1.jpg?w=774")),
        SampleCardModel(title: "Bon Jovi", description: "#music", imageURL: URL(string: "https://flashbak.com/wp-content/uploads/2018/04/1983_bon_jovi_1983_s00266.jpg")),
        SampleCardModel(title: "Celine Dion", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/88/c6/09/88c6096b9d5ce0772da2352aca548c02.jpg")),
        SampleCardModel(title: "Neil Young", description: "#music", imageURL: URL(string: "https://www.needsomefun.net/wp-content/uploads/2019/02/neil-young-black-and-white-20.jpg")),
        SampleCardModel(title: "REM", description: "#music", imageURL: URL(string: "https://www.rollingstone.com/wp-content/uploads/2018/06/rm-rem-43860984-d38c-44fb-bea7-c56403c265c0.jpg")),
        SampleCardModel(title: "Mariah Carey", description: "#music", imageURL: URL(string: "https://www.instagram.com/p/Bn85Bc4HMZK/media/?size=l")),
        SampleCardModel(title: "AC/DC", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/5b/e2/aa/5be2aaad4215b0fb5a7c762d51a24ccd.jpg")),
        SampleCardModel(title: "Bee Gees", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/70/dd/e9/70dde99fad50a4db9ee61ea49f31a4e1.jpg")),
        SampleCardModel(title: "Santana", description: "#music", imageURL: URL(string: "https://bento.cdn.pbs.org/hostedbento-prod/filer_public/latinmusicusa/Artists/santana_16x9.jpg")),
        SampleCardModel(title: "Metallica", description: "#music", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/James_Hetfield_2017.jpg/1200px-James_Hetfield_2017.jpg")),
        SampleCardModel(title: "Eminem", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/d4/a8/bd/d4a8bd35c209214cad0e69694d3fae79.jpg")),
        SampleCardModel(title: "Eric Clapton", description: "#music", imageURL: URL(string: "https://www.morrisonhotelgallery.com/images/big/Eric%20Clapton%20with%20Sunglasses.jpg")),
        SampleCardModel(title: "Phil Collins", description: "#music", imageURL: URL(string: "https://www.morrisonhotelgallery.com/images/big/SPS_PHIL%20COLLINS.jpg")),
        SampleCardModel(title: "Neil Diamond", description: "#music", imageURL: URL(string: "https://images.forwardcdn.com/image/1300x/center/top/images/cropped/gettyimages-636555232-1516743112.jpg")),
        SampleCardModel(title: "Whitney Houston", description: "#music", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/a/a7/Whitney_Houston_Welcome_Home_Heroes_1_cropped.jpg")),
        SampleCardModel(title: "Fleetwood Mac", description: "#music", imageURL: URL(string: "https://m.media-amazon.com/images/M/MV5BNDI0Y2FkYzUtNjViZS00YTY0LWFhMjItZDYxY2MyMzVkOTdjXkEyXkFqcGdeQXVyNDUzOTQ5MjY@._V1_SY1000_CR0,0,830,1000_AL_.jpg")),
        SampleCardModel(title: "Abba", description: "#music", imageURL: URL(string: "https://66.media.tumblr.com/28cf422e58e3b0c453ce36a068cbb90b/tumblr_o3quqhWPfR1slfhvyo1_1280.jpg")),
        SampleCardModel(title: "The Beach Boys", description: "#music", imageURL: URL(string: "https://cdn.britannica.com/28/198728-050-178A6431/The-Beach-Boys-Al-Jardine-Dennis-Wilson-1966.jpg")),
        SampleCardModel(title: "Pearl Jam", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/85/dc/9f/85dc9f76e06c4802c9f11e50157701b2.jpg")),
        SampleCardModel(title: "Jimi Hendrix", description: "#music", imageURL: URL(string: "https://cdn.mos.cms.futurecdn.net/Er7f2aS9ukBKBsVfR2Z9uE.jpg")),
        SampleCardModel(title: "Eagles", description: "#music", imageURL: URL(string: "https://preview.redd.it/bt9ud6vbgnf21.jpg?auto=webp&s=33968d116a75bfd660dc0313dcdc01e93fc3e840")),
        SampleCardModel(title: "Billy Joel", description: "#music", imageURL: URL(string: "https://images.fineartamerica.com/images/artworkimages/mediumlarge/2/billy-joel-express.jpg")),
        SampleCardModel(title: "Depeche Mode", description: "#music", imageURL: URL(string: "https://pbs.twimg.com/media/Dm1pD-PXcAApyNR.jpg")),
        SampleCardModel(title: "Genesis", description: "#music", imageURL: URL(string: "https://cdn.mos.cms.futurecdn.net/3bYWfU3GejxyxBoAtygVFc.jpg")),
        SampleCardModel(title: "Dire Straits", description: "#music", imageURL: URL(string: "https://guitar.com/wp-content/uploads/2019/08/young-mark-knopfler-red-strat@1050x1400.jpg")),
        SampleCardModel(title: "Simon & Garfunkel", description: "#music", imageURL: URL(string: "https://www.ft.com/__origami/service/image/v2/images/raw/ftcms%3A7d96b6b4-e736-11e8-8827-ff56e7163c11?source=ig")),
        SampleCardModel(title: "Paul McCartney", description: "#music", imageURL: URL(string: "https://data.whicdn.com/images/18162522/original.jpg")),
        SampleCardModel(title: "The Who", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/f4/e4/6f/f4e46f0d521b41a295e9f5418e4b6bb5.jpg")),
        SampleCardModel(title: "John Lennon", description: "#music", imageURL: URL(string: "https://api.time.com/wp-content/uploads/2015/10/151001-john-lennon-23.jpg?quality=85")),
        SampleCardModel(title: "Iron Maiden", description: "#music", imageURL: URL(string: "https://www.theplace2.ru/archive/iron_maiden/img/f654629fbbfe68fa2a4e.jpg")),
        SampleCardModel(title: "Stevie Wonder", description: "#music", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/5/54/Stevie_Wonder_1973.JPG")),
        SampleCardModel(title: "Deep Purple", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/07/47/c6/0747c698ebc54a4f335149c3e88c5093.jpg")),
        SampleCardModel(title: "Red Hot Chili Peppers", description: "#music", imageURL: URL(string: "https://cuffarophoto.com/wp-content/uploads/2013/08/08_c55473.jpg")),
        SampleCardModel(title: "Sting", description: "#music", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/4/40/Sting_in_April_2018.jpg")),
        SampleCardModel(title: "Radiohead", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/00/c7/71/00c7711a4e3e1ef9fd05c59e84b2bb3a.jpg")),
        SampleCardModel(title: "Nirvana", description: "#music", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/5/59/Kurt_St_Thomas_1991_cropped.jpg")),
        SampleCardModel(title: "Van Morrison", description: "#music", imageURL: URL(string: "https://www.rollingstone.com/wp-content/uploads/2018/11/van-morrison-astral-weeks.jpg")),
        SampleCardModel(title: "Guns n' Roses", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/14/b5/aa/14b5aab6d1f81a43aa1e07b47a3d6c93.jpg")),
        SampleCardModel(title: "Chicago", description: "#music", imageURL: URL(string: "https://static.stereogum.com/uploads/2016/04/chicago-compressed.jpg")),
        SampleCardModel(title: "Coldplay", description: "#music", imageURL: URL(string: "https://cdn1.thr.com/sites/default/files/2014/05/coldplay_royce_hall_a_p.jpg")),
        SampleCardModel(title: "Britney Spears", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/5b/e4/bf/5be4bfc52251cb8780ee32c399e3b5aa.jpg")),
        SampleCardModel(title: "Jethro Tull", description: "#music", imageURL: URL(string: "https://live.staticflickr.com/2752/4374242878_81383d0058_b.jpg")),
        SampleCardModel(title: "Bryan Adams", description: "#music", imageURL: URL(string: "https://www.theplace2.ru/cache/archive/bryan_adams/img/bryan_adams-gthumb-gwdata1200-ghdata1200-gfitdatamax.jpg")),
        SampleCardModel(title: "Aerosmith", description: "#music", imageURL: URL(string: "https://www.morrisonhotelgallery.com/images/big/14%20Steven%20Tyler%20of%20Aerosmith,%201986.jpg")),
        SampleCardModel(title: "Johnny Cash", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/79/84/76/7984762d2e499543506bcaa97a8829df.jpg")),
        SampleCardModel(title: "Paul Simon", description: "#music", imageURL: URL(string: "https://www.morrisonhotelgallery.com/images/big/10%20Paul%20Simon,%201978.jpg")),
        SampleCardModel(title: "Bob Marley", description: "#music", imageURL: URL(string: "https://the1a.org/wp-content/uploads/sites/4/2017/07/GettyImages-3259910-683x1024.jpg")),
        SampleCardModel(title: "Van Halen", description: "#music", imageURL: URL(string: "https://townsquare.media/site/295/files/2019/01/GettyImages-136658770.jpg?w=980&q=75")),
        SampleCardModel(title: "Janet Jackson", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/e2/fa/9c/e2fa9c680bbf2ae49c85953affbd149c.jpg")),
        SampleCardModel(title: "Garth Brooks", description: "#music", imageURL: URL(string: "https://townsquare.media/site/204/files/2019/12/garth-brooks-2020-dive-bar-tour-dates.jpg?w=980&q=75")),
        SampleCardModel(title: "Andrea Bocelli", description: "#music", imageURL: URL(string: "https://307047-939351-raikfcquaxqncofqfm.stackpathdns.com/wp-content/uploads/2019/04/hero-mobil-tour.jpg")),
        SampleCardModel(title: "Kiss", description: "#music", imageURL: URL(string: "https://www.ft.com/__origami/service/image/v2/images/raw/http%3A%2F%2Fcom.ft.imagepublish.upp-prod-us.s3.amazonaws.com%2Fade583b4-9ccf-11e9-9c06-a4640c9feebb?fit=scale-down&source=next&width=700")),
        SampleCardModel(title: "Miles Davis", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/dd/af/5b/ddaf5b606acbd29d0db20cedfdaa1358.jpg")),
        SampleCardModel(title: "Green Day", description: "#music", imageURL: URL(string: "https://dt7v1i9vyp3mf.cloudfront.net/styles/news_large/s3/imagelibrary/C/ClassicTracks_01-0211-dKANrpCPACcpq2Qvt1NT6d84Pzuls91..jpg")),
        SampleCardModel(title: "Robbie Williams", description: "#music", imageURL: URL(string: "https://www.thesun.co.uk/wp-content/uploads/2016/06/nintchdbpict000247195645.jpg")),
        SampleCardModel(title: "The Backstreet Boys", description: "#music", imageURL: URL(string: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fcdn-img.instyle.com%2Fsites%2Fdefault%2Ffiles%2Fstyles%2F684xflex%2Fpublic%2Fimages%2F2016%2F04%2F040516-backstreet-boys-lead.jpg%3Fitok%3Day44Wa1t")),
        SampleCardModel(title: "The Police", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/9d/4a/72/9d4a723aaea4813679594f89472b359e.jpg")),
        SampleCardModel(title: "The Doors", description: "#music", imageURL: URL(string: "https://iscale.iheart.com/catalog/artist/58402")),
        SampleCardModel(title: "Wings", description: "#music", imageURL: URL(string: "https://paulmccartneypod.files.wordpress.com/2017/07/band-1.jpg?w=1000&h=1000&crop=1")),
        SampleCardModel(title: "Linkin Park", description: "#music", imageURL: URL(string: "https://cdn.vox-cdn.com/thumbor/rK3T3qJKt9TD9tjiQZJNU6RWiIM=/0x144:3000x2000/1400x1400/filters:focal(1587x973:2067x1453):format(jpeg)/cdn.vox-cdn.com/uploads/chorus_image/image/55808999/687020280.0.jpg")),
        SampleCardModel(title: "Herb Alpert", description: "#music", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/e/e0/Herb_Alpert_1966.jpg")),
        SampleCardModel(title: "The Cure", description: "#music", imageURL: URL(string: "https://wallpapercave.com/wp/wp1899621.jpg")),
        SampleCardModel(title: "Rush", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/b1/38/69/b1386968fb8a78ab3131f0bf99dbbf52.jpg")),
        SampleCardModel(title: "Oasis", description: "#music", imageURL: URL(string: "https://www.liveabout.com/thmb/UlQbTbdWMKi9mbyJKOkj-4mcdV4=/2883x2162/smart/filters:no_upscale()/51129222-58b8e5665f9b58af5c912c9c.jpg")),
        SampleCardModel(title: "Peter Gabriel", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/37/80/db/3780db4d42b022b1d69ccebde0c4c9e3.jpg")),
        SampleCardModel(title: "Def Leppard", description: "#music", imageURL: URL(string: "https://i.pinimg.com/474x/93/d4/de/93d4de14b07af44772e9865bf22b281d.jpg")),
        SampleCardModel(title: "Lionel Richie", description: "#music", imageURL: URL(string: "https://i.huffpost.com/gen/1201948/thumbs/o-LIONEL-RICHIE-JHER-CURL-570.jpg?4")),
        SampleCardModel(title: "Alanis Morissette", description: "#music", imageURL: URL(string: "https://static01.nyt.com/images/2019/12/01/magazine/01mag-morissette-image-02/01mag-morissette-image-02-mobileMasterAt3x.jpg")),
        SampleCardModel(title: "Cat Stevens", description: "#music", imageURL: URL(string: "https://www.rollingstone.com/wp-content/uploads/2018/06/rs-27915-catstevens-1800-1386942005.jpg")),
        SampleCardModel(title: "Johnny Mathis", description: "#music", imageURL: URL(string: "https://images-na.ssl-images-amazon.com/images/I/C1WYETpNAiS._SL1000_.png")),
        SampleCardModel(title: "Simply Red", description: "#music", imageURL: URL(string: "https://66.media.tumblr.com/56b83726a720ee385880257f11e4b677/tumblr_oxw91msfBF1u6qucvo1_500.jpg")),
        SampleCardModel(title: "James Last", description: "#music", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/2/2b/Grand_Gala_du_Disque_in_RAI_Amsterdam._James_Last_Band%2C_Bestanddeelnr_923-3019.jpg")),
        SampleCardModel(title: "Tina Turner", description: "#music", imageURL: URL(string: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2018%2F01%2Ftina-turner-12.jpg")),
        SampleCardModel(title: "Elvis Costello", description: "#music", imageURL: URL(string: "https://4.bp.blogspot.com/-Nizlr3i2mK8/UdG9QNUNfII/AAAAAAAAFG8/wW-TS6r1DPs/s1600/Elvis_Costello_f16A.JPG")),
        SampleCardModel(title: "Tom Petty & The Heartbreakers", description: "#music", imageURL: URL(string: "https://www.rollingstone.com/wp-content/uploads/2018/09/1320_FOB_MIX_Campbell_B.jpg?w=724")),
        SampleCardModel(title: "George Michael", description: "#music", imageURL: URL(string: "https://www.morrisonhotelgallery.com/images/big/George%20Michael%201988.jpg")),
        SampleCardModel(title: "Aretha Franklin", description: "#music", imageURL: URL(string: "https://media.newyorker.com/photos/5b76fc414e612448fe8219f2/master/pass/StFelix-ArethaFranklin-2.jpg")),
        SampleCardModel(title: "Joe Cocker", description: "#music", imageURL: URL(string: "https://www.ft.com/__origami/service/image/v2/images/raw/http%3A%2F%2Fcom.ft.imagepublish.upp-prod-us.s3.amazonaws.com%2Fbaa43ece-6ca5-11e9-a9a5-351eeaef6d84?fit=scale-down&source=next&width=700")),
        SampleCardModel(title: "Creedence Clearwater Revival", description: "#music", imageURL: URL(string: "https://iscale.iheart.com/catalog/artist/35051")),
        SampleCardModel(title: "Michael Buble", description: "#music", imageURL: URL(string: "https://press.warnerrecords.com/wp-content/uploads/2018/01/photo-credit-evaan-kheraj-extralarge_1471396669602.jpg")),
        SampleCardModel(title: "Ray Charles", description: "#music", imageURL: URL(string: "https://hips.hearstapps.com/esq.h-cdn.co/assets/15/17/1429827516-74257065.jpg")),
        SampleCardModel(title: "Black Sabbath", description: "#music", imageURL: URL(string: "https://www.morrisonhotelgallery.com/images/big/Ozzy%20jpg451.jpg")),
        SampleCardModel(title: "Supertramp", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/ab/9f/3d/ab9f3d9e2c8d777e3257c47a3414869f.jpg")),
        SampleCardModel(title: "Donna Summer", description: "#music", imageURL: URL(string: "https://imaging.broadway.com/images/custom/w1470/111475-0.jpg")),
        SampleCardModel(title: "Mike Oldfield", description: "#music", imageURL: URL(string: "https://www.innerviews.org/inner/oldfield/mo12.jpg")),
        SampleCardModel(title: "Yes", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/ca/c5/bb/cac5bbe6255577c3dddebaef2c5747bd.jpg")),
        SampleCardModel(title: "The Pet Shop Boys", description: "#music", imageURL: URL(string: "https://www.metroweekly.com/wp-content/uploads/2020/01/PSB1-Credit-Phil-Fisk.jpg")),
        SampleCardModel(title: "The Foo Fighters", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/3d/77/8d/3d778dc4cde3a62edf938dad3b74f154.jpg")),
        SampleCardModel(title: "Meat Loaf", description: "#music", imageURL: URL(string: "https://www.biography.com/.image/t_share/MTE1ODA0OTcxNDQ4Njk4Mzgx/meat-loaf-262383-1-402.jpg")),
        SampleCardModel(title: "Jay-Z", description: "#music", imageURL: URL(string: "https://static01.nyt.com/images/2017/07/23/arts/23JAYZJP2/23JAYZJP2-articleLarge.jpg?quality=100&auto=webp&disable=upscale")),
        SampleCardModel(title: "The Moody Blues", description: "#music", imageURL: URL(string: "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fblogs-images.forbes.com%2Frobinseatonjefferson%2Ffiles%2F2017%2F11%2FMoodyBlues12-1200x1214.jpg")),
        SampleCardModel(title: "Norah Jones", description: "#music", imageURL: URL(string: "https://lastfm.freetls.fastly.net/i/u/770x0/fb7c2e77c03d4492a33493a6408a2dc4.jpg")),
        SampleCardModel(title: "The Eurythmics", description: "#music", imageURL: URL(string: "https://cdn.smehost.net/eurythmicscom-ukprod/wp-content/uploads/2018/04/eur-hero-dark.jpg")),
        SampleCardModel(title: "Barry Manilow", description: "#music", imageURL: URL(string: "https://i.pinimg.com/474x/86/c4/8c/86c48c903a626227456f9454f10520ce--american-artists-teresa.jpg")),
        SampleCardModel(title: "Diana Ross", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/a7/2b/de/a72bde6705887d11a90ea0f4a4e38cc8.jpg")),
        SampleCardModel(title: "Sade", description: "#music", imageURL: URL(string: "https://cdn.britannica.com/65/137465-050-0A58A7AB/Sade-album-cover-Soldier-of-Love.jpg")),
        SampleCardModel(title: "Shania Twain", description: "#music", imageURL: URL(string: "https://i.guim.co.uk/img/media/fffd4e13dae017a5699061cdb3c88bc9fb0df61a/0_0_1989_3000/master/1989.jpg?width=700&quality=85&auto=format&fit=max&s=30ad070a75fa8ad4fb411d8d145840c5")),
        SampleCardModel(title: "George Strait", description: "#music", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/George_Strait_on_stage.jpg/1200px-George_Strait_on_stage.jpg")),
        SampleCardModel(title: "Cliff Richard", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/d7/5c/a3/d75ca32c6d9cb0bec1ff0df7202339f3.jpg")),
        SampleCardModel(title: "Duran Duran", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/2a/83/e7/2a83e7ac48cafee8b312d6772acd637d.jpg")),
        SampleCardModel(title: "ZZ Top", description: "#music", imageURL: URL(string: "https://cdn.britannica.com/95/103095-050-45E47ECB/ZZ-Top-Billy-Gibbons-Frank-Beard-Dusty-2003.jpg")),
        SampleCardModel(title: "Enya", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/2a/47/3f/2a473fcf7e84214da217066467e9543c.jpg")),
        SampleCardModel(title: "John Denver", description: "#music", imageURL: URL(string: "https://www.visithendersonvillenc.org/wp-content/uploads/Ted-Vigil-is-John-Denver-Logo-v1-1.jpg")),
        SampleCardModel(title: "Andy Williams", description: "#music", imageURL: URL(string: "https://static01.nyt.com/images/2012/09/27/obituaries/27williamsobit/27williamsobit-superJumbo.jpg")),
        SampleCardModel(title: "The Beastie Boys", description: "#music", imageURL: URL(string: "https://thenypost.files.wordpress.com/2019/07/beastie2.jpg?quality=80&strip=all&strip=all")),
        SampleCardModel(title: "Kenny Rogers", description: "#music", imageURL: URL(string: "https://countrymusichalloffame.org/content/uploads/2019/03/Rogers_Kenny.jpg")),
        SampleCardModel(title: "Pink", description: "#music", imageURL: URL(string: "https://cdn.nashvillescene.com/files/base/scomm/nvs/image/2019/03/960w/PINK_Ryan_Aylsworth_Main_Press.5c7ee014cd2c9.jpg")),
        SampleCardModel(title: "Electric Light Orchestra", description: "#music", imageURL: URL(string: "https://www.classicrockhistory.com/wp-content/uploads/2018/03/Electric_Light_Orchestra_1986.jpg")),
        SampleCardModel(title: "Grateful Dead", description: "#music", imageURL: URL(string: "https://1.bp.blogspot.com/-wK2K8jM4m0c/XUJ4Z_djrwI/AAAAAAAAA-g/stiYwbi2Z5gdbBhe-BkP_68mTInfkYLZQCEwYBhgL/s1600/69-08-16-dead2-upgrade.jpg")),
        SampleCardModel(title: "Taylor Swift", description: "#music", imageURL: URL(string: "https://66.media.tumblr.com/7911d448c43e3aeb442239c159ba808f/tumblr_p7nz3fdKIF1r9hliho1_400.png")),
        SampleCardModel(title: "Earth, Wind & Fire", description: "#music", imageURL: URL(string: "https://resize-parismatch.lanmedia.fr/img/var/news/storage/images/paris-match/culture/musique/maurice-white-s-est-eteint-mercredi-908137/9631939-1-fre-FR/Maurice-White-s-est-eteint-mercredi.jpg")),
        SampleCardModel(title: "Carpenters", description: "#music", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/d/dc/Carpenters_-_Nixon_-_Office.png")),
        SampleCardModel(title: "Linda Ronstadt", description: "#music", imageURL: URL(string: "https://www.morrisonhotelgallery.com/images/big/linda%20ronstadt%201978%2001.jpg")),
        SampleCardModel(title: "Talking Heads", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/9f/23/9b/9f239b4ab8cc23640dae156216ae7236.jpg")),
        SampleCardModel(title: "George Harrison", description: "#music", imageURL: URL(string: "https://img.washingtonpost.com/rf/image_1484w/2010-2019/WashingtonPost/2011/10/04/Style/Images/georgeharrison03.jpg?uuid=pWgsaO6-EeC0hVUH8UyoXw")),
        SampleCardModel(title: "Kanye West", description: "#music", imageURL: URL(string: "https://api.time.com/wp-content/uploads/2000/04/kanye-west-time-100-2015-titans.jpg?quality=85&w=1012")),
        SampleCardModel(title: "The Smashing Pumpkins", description: "#music", imageURL: URL(string: "https://artist-assets.hubbardradio.com/thesmashingpumpkins-1_v1000.jpg")),
        SampleCardModel(title: "The Temptations", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/f5/eb/0c/f5eb0cfa1608821e3829c55e2de1ac97.jpg")),
        SampleCardModel(title: "Tracy Chapman", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/8c/b6/61/8cb6612933b0a9ba0a41dff988d012a1.jpg")),
        SampleCardModel(title: "Simple Minds", description: "#music", imageURL: URL(string: "https://s3.amazonaws.com/oildale/wp-content/uploads/2018/01/22013132/Simple-Minds-resize-2.jpg")),
        SampleCardModel(title: "Status Quo", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/f7/f6/4a/f7f64aeb6f39b2b2d54860c193dd246c.jpg")),
        SampleCardModel(title: "Tom Jones", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/c9/6a/cd/c96acd367e4e7a0a9b935126d8df101c.jpg")),
        SampleCardModel(title: "Lenny Kravitz", description: "#music", imageURL: URL(string: "https://www.interviewmagazine.com/wp-content/uploads/2012/02/img-lenny-kravitz-1_111445467817-843x1000.jpg")),
        SampleCardModel(title: "The Alan Parsons Project", description: "#music", imageURL: URL(string: "https://yt3.ggpht.com/a/AATXAJw4ZQ8A2WRw6XHaJtOkfucUo77VRvaNoIQFTA=s900-c-k-c0xffffffff-no-rj-mo")),
        SampleCardModel(title: "Beyonce", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/7e/28/e1/7e28e11683c3d6ae42c5a7d5fab5f08a.jpg")),
        SampleCardModel(title: "Muse", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/6e/01/71/6e0171e79055408e14842d6896a9b9c1.jpg")),
        SampleCardModel(title: "Jack Johnson", description: "#music", imageURL: URL(string: "https://i.dailymail.co.uk/i/pix/2008/08/19/article-1046769-024A73BD00000578-996_468x664.jpg")),
        SampleCardModel(title: "Joni Mitchell", description: "#music", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/04/Joni_mitchell_1974.jpg")),
        SampleCardModel(title: "Nickelback", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/a5/d4/39/a5d439ed48a72c75a61ffeae4e6a3ca5.jpg")),
        SampleCardModel(title: "Mary J Blige", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/b5/aa/b1/b5aab1077fa8ee6e7d1a8e1db12c2215.jpg")),
        SampleCardModel(title: "Korn", description: "#music", imageURL: URL(string: "https://townsquare.media/site/366/files/2019/06/Korn.jpg?w=980&q=75")),
        SampleCardModel(title: "Alice Cooper", description: "#music", imageURL: URL(string: "https://www.motorcitycomiccon.com/wp-content/uploads/2020/01/AliceCooperHeashot3-e1579634476471.png")),
        SampleCardModel(title: "The Scorpions", description: "#music", imageURL: URL(string: "https://www.trbimg.com/img-5cb89ec9/turbine/la-1555603142-aark5btkpy-snap-image")),
        SampleCardModel(title: "Foreigner", description: "#music", imageURL: URL(string: "https://iscale.iheart.com/catalog/artist/35146")),
        SampleCardModel(title: "Ozzy Osbourne", description: "#music", imageURL: URL(string: "https://www.biography.com/.image/t_share/MTY5ODEzMTM4MzkxMTgxMTE1/ozzy-osbourne-gettyimages-660795784.jpg")),
        SampleCardModel(title: "Roxy Music", description: "#music", imageURL: URL(string: "https://m.media-amazon.com/images/M/MV5BMDZiY2YyMzEtZTJlNC00NTlmLWFhNDktZWM5YmUwYzg0MWQ4XkEyXkFqcGdeQXVyMjUyNDk2ODc@._V1_SY1000_SX1000_AL_.jpg")),
        SampleCardModel(title: "Michael Bolton", description: "#music", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/d/d0/Michael_Bolton_in_1997.jpg")),
        SampleCardModel(title: "Dave Matthews Band", description: "#music", imageURL: URL(string: "https://wtop.com/wp-content/uploads/2017/12/Music_Hurricane_Concert_73331.jpg")),
        SampleCardModel(title: "INXS", description: "#music", imageURL: URL(string: "https://i.ebayimg.com/images/g/L4IAAOxy4dNSxBcn/s-l1600.jpg")),
        SampleCardModel(title: "John Cougar Mellencamp", description: "#music", imageURL: URL(string: "https://dt7v1i9vyp3mf.cloudfront.net/styles/news_large/s3/imagelibrary/C/ClassicTracks_01-0911-QEy.7Gb1sGSGckaaMtYlqLt_WVCkwVXi.jpg")),
        SampleCardModel(title: "Julio Iglesias", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/48/f0/79/48f0791c997aac877b61daec1ae16d7a.jpg")),
        SampleCardModel(title: "Leonard Cohen", description: "#music", imageURL: URL(string: "https://maggiejankuloskawriter.files.wordpress.com/2016/11/lc-woods-scaled1000.jpg")),
        SampleCardModel(title: "Miley Cyrus", description: "#music", imageURL: URL(string: "https://www.hawtcelebs.com/wp-content/uploads/2019/03/miley-cyrus-on-the-set-of-a-photoshoot-march-2019-11.jpg")),
        SampleCardModel(title: "Alicia Keys", description: "#music", imageURL: URL(string: "https://warddpress.files.wordpress.com/2017/02/alicia-keys-bandana2.jpg")),
        SampleCardModel(title: "James Taylor", description: "#music", imageURL: URL(string: "https://www.morrisonhotelgallery.com/images/big/james1.jpg")),
        SampleCardModel(title: "Usher", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/c3/e1/a0/c3e1a0e836d14ce21dab8793ea99a0e7.jpg")),
        SampleCardModel(title: "Bob Seger & The Silver Bullet Band", description: "#music", imageURL: URL(string: "https://artist-assets.hubbardradio.com/bobsegerthesilverbulletband-1_v1000.jpg")),
        SampleCardModel(title: "Tom Waits", description: "#music", imageURL: URL(string: "https://images.squarespace-cdn.com/content/v1/5be0c3faf93fd4563ef7aaa5/1543030300005-E6TPLT6Z4D43JZ5Z10MX/ke17ZwdGBToddI8pDm48kJp_E_LOI-ft6x3AwwQkb5FZw-zPPgdn4jUwVcJE1ZvWQUxwkmyExglNqGp0IvTJZUJFbgE-7XRK3dMEBRBhUpwf9SrLQlzB2awYtT85FA0ZiZt9MVWfvJF7nlcFs034uVSYlfOolGL-3b0R6Wcwm-Q/TomWaits.jpg")),
        SampleCardModel(title: "The Kinks", description: "#music", imageURL: URL(string: "https://static.stereogum.com/uploads/2014/09/thekinks-compressed.jpg")),
        SampleCardModel(title: "Rihanna", description: "#music", imageURL: URL(string: "https://abrilcapricho.files.wordpress.com/2017/11/rihanna-batom-vermelho-fenty-beauty-1.jpg?quality=85&strip=info&w=1024")),
        SampleCardModel(title: "Cher", description: "#music", imageURL: URL(string: "https://www.wmagazine.com/wp-content/uploads/2016/12/15/58527284e3d613c03e1e6d44_Cher-marc-costumes-11.jpg?w=640px")),
        SampleCardModel(title: "Alan Jackson", description: "#music", imageURL: URL(string: "https://countrymusichalloffame.org/content/uploads/2017/10/Jackson_Alan.jpg")),
        SampleCardModel(title: "James Brown", description: "#music", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/9/99/James_Brown_Live_Hamburg_1973_1702730029.jpg/1200px-James_Brown_Live_Hamburg_1973_1702730029.jpg")),
        SampleCardModel(title: "The Monkees", description: "#music", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/8/8f/The_Monkees_1966.JPG")),
        SampleCardModel(title: "Henry Mancini", description: "#music", imageURL: URL(string: "https://www.stripes.com/polopoly_fs/1.19115.1356733730!/image/3424330632.jpg_gen/derivatives/landscape_900/3424330632.jpg")),
        SampleCardModel(title: "2Pac", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/4d/e9/5d/4de95d06ff91b6c09489272183a213af.jpg")),
        SampleCardModel(title: "John Williams", description: "#music", imageURL: URL(string: "https://images.fineartamerica.com/images/artworkimages/mediumlarge/2/portrait-of-john-williams-bachrach.jpg")),
        SampleCardModel(title: "Jennifer Lopez", description: "#music", imageURL: URL(string: "https://data.whicdn.com/images/308483106/original.jpg")),
        SampleCardModel(title: "Peter Maffay", description: "#music", imageURL: URL(string: "https://www.jesus.de/wp-content/uploads/2020/01/jde_maffay-scaled.jpg")),
        SampleCardModel(title: "Kylie Minogue", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/7b/7b/29/7b7b29c588cd2edc4bc48db4657da551.jpg")),
        SampleCardModel(title: "Roxette", description: "#music", imageURL: URL(string: "https://insidepulse.com/wp-content/uploads/2020/01/Roxette-Marie.jpg")),
        SampleCardModel(title: "Steely Dan", description: "#music", imageURL: URL(string: "https://si.wsj.net/public/resources/images/AR-AK759_DEACON_8S_20150904180010.jpg")),
        SampleCardModel(title: "Avril Lavigne", description: "#music", imageURL: URL(string: "https://celebmafia.com/wp-content/uploads/2019/05/avril-lavigne-photoshoot-for-v-magazine-2019-0.jpg")),
        SampleCardModel(title: "Journey", description: "#music", imageURL: URL(string: "https://townsquare.media/site/295/files/2019/05/Journey-Separate-Ways-Video-YouTube.png?w=980&q=75")),
        SampleCardModel(title: "Ray Conniff", description: "#music", imageURL: URL(string: "https://artist-assets.hubbardradio.com/ray-conniff-1_v1000.jpg")),
        SampleCardModel(title: "The Smiths", description: "#music", imageURL: URL(string: "https://songssmiths.files.wordpress.com/2015/05/the-smiths-1985-this-image-was-taken-during-the-shoot-for-the-cover-of-the-queen-is-dead-album-the-smiths-second-lp-release-in-june-1986-by-stephen-wright.jpg")),
        SampleCardModel(title: "Chris Rea", description: "#music", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/2/2d/Chris_Rea_01_AB.jpg")),
        SampleCardModel(title: "Beck", description: "#music", imageURL: URL(string: "https://www.rollingstone.com/wp-content/uploads/2018/06/rs-9305-130202-beck-1-rect-1359835977.jpg?resize=1800,1200&w=1800")),
        SampleCardModel(title: "Nat King Cole", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/6c/2c/0a/6c2c0a4fb1dbd61153fc1fd94e613067.jpg")),
        SampleCardModel(title: "Bjork", description: "#music", imageURL: URL(string: "https://www.indiewire.com/wp-content/uploads/2019/03/tjp04.jpg")),
        SampleCardModel(title: "Chris de Burgh", description: "#music", imageURL: URL(string: "https://www.irishtimes.com/polopoly_fs/1.3047553!/image/image.jpg_gen/derivatives/landscape_620/image.jpg")),
        SampleCardModel(title: "John Coltrane", description: "#music", imageURL: URL(string: "https://www.blumenthalarts.org/assets/img/John-Coltrane-Primary-blum-1440x1440-min-4de4593127.jpg")),
        SampleCardModel(title: "Shakira", description: "#music", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/7/7f/Shakira.JPG")),
        SampleCardModel(title: "Cream", description: "#music", imageURL: URL(string: "https://2.bp.blogspot.com/-chb35bUN2DI/Uk1jLQSeC1I/AAAAAAAATyk/oSM6fVj71Q4/s1600/tumblr_ml7sq3Ve5V1so5ik5o1_1280.jpg")),
        SampleCardModel(title: "Marvin Gaye", description: "#music", imageURL: URL(string: "https://2ab9pu2w8o9xpg6w26xnz04d-wpengine.netdna-ssl.com/wp-content/uploads/2015/04/Marvin-Gaye-Album-Cover-Crop.jpg")),
        SampleCardModel(title: "Snoop Dogg", description: "#music", imageURL: URL(string: "https://pbs.twimg.com/media/DAdVW71XUAAElzL.jpg")),
        SampleCardModel(title: "Nick Cave & The Bad Seeds", description: "#music", imageURL: URL(string: "https://cultmtl.com/wp-content/uploads/2019/09/Nick-Cave.jpg")),
        SampleCardModel(title: "Luther Vandross", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/80/d3/68/80d3684fe983cdcadb8f942568127f4e.jpg")),
        SampleCardModel(title: "Carole King", description: "#music", imageURL: URL(string: "https://troubadourtribune.files.wordpress.com/2012/03/caroleking-nymag-excerpt.jpg")),
        SampleCardModel(title: "Kate Bush", description: "#music", imageURL: URL(string: "https://rockandrollglobe.com/wp-content/uploads/2019/01/273d1d12fb649d32335dd76d785424f2.jpg")),
        SampleCardModel(title: "Willie Nelson", description: "#music", imageURL: URL(string: "https://cdn.britannica.com/39/67639-050-81F10048/Willie-Nelson-1992.jpg")),
        SampleCardModel(title: "Tori Amos", description: "#music", imageURL: URL(string: "https://www.yessaid.com/pic/94-03details1b.jpg")),
    ]
}


extension UIImage {
    
    /// Returns a image that fills in newSize
    func resizedImage(newSize: CGSize) -> UIImage {
        // Guard newSize is different
        guard self.size != newSize else { return self }
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func aspectResizedImage (newHeight: CGFloat) -> UIImage {
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        
        let newSize = CGSize(width: newWidth, height: newHeight)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}





class SubtitleTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView?.sd_cancelCurrentImageLoad()
    }
}

class AccessoryTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView?.sd_cancelCurrentImageLoad()
    }
}







extension UIView {
    
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat = 0, paddingLeft: CGFloat = 0, paddingBottom: CGFloat = 0, paddingRight: CGFloat = 0, width: CGFloat = 0, height: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: paddingTop))
        }
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: paddingLeft))
        }
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom))
        }
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -paddingRight))
        }
        if width > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: width))
        }
        if height > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: height))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
    
    @discardableResult
    func anchorToSuperview() -> [NSLayoutConstraint] {
        return anchor(top: superview?.topAnchor, left: superview?.leftAnchor, bottom: superview?.bottomAnchor, right: superview?.rightAnchor)
    }
}

extension UIView {
    
    func applyShadow(radius: CGFloat, opacity: Float, offset: CGSize, color: UIColor = .black) {
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
    }
    
}
