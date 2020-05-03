//
//  ViewController.swift
//  Pluto
//
//  Created by Hunain Ali on 4/18/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.runIt()
        
//        self.view.backgroundColor = UIColor.systemPurple
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        
        // 2. add the gesture recognizer to a view
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.runIt()
        print("done/ Help!")
    }
    
    func printDate(string: String) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSSS"
        print(string + formatter.string(from: date))
    }
    
    func runIt() {

        var db = Firestore.firestore()

        var payload : [SampleCardModelX] = [SampleCardModelX(title: "The Beatles", description: "#music", imageURL: "https://www.beatlesbible.com/wp/media/beatles-mad-day-out_13.jpg"),
                                           SampleCardModelX(title: "The Rolling Stones", description: "#music", imageURL: "https://66.media.tumblr.com/bbce574155a5fd7f40b88a5643530638/tumblr_mymkd1BMZ81r6sispo1_r1_1280.jpg"),
                                           SampleCardModelX(title: "Elvis Presley", description: "#music", imageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/35/Elvis_Presley_Jailhouse_Rock.jpg/1200px-Elvis_Presley_Jailhouse_Rock.jpg"),
                                           SampleCardModelX(title: "Bob Dylan", description: "#music", imageURL: "https://images.genius.com/f5c25eb5996f2f78f7ad8cc3a45d00fe.1000x750x1.jpg"),
                                           SampleCardModelX(title: "U2", description: "#music", imageURL: "https://i.pinimg.com/originals/18/87/fd/1887fd9a69303bdd151077d559bf28b5.jpg"),
                                           SampleCardModelX(title: "Bruce Springsteen", description: "#music", imageURL: "https://i.pinimg.com/originals/e9/87/74/e98774a2ef77333dc833f3fb1d00c567.jpg"),
                                           SampleCardModelX(title: "Madonna", description: "#music", imageURL: "https://3.bp.blogspot.com/-iHUXQmYapMg/VPlj8eCtv1I/AAAAAAAAHaw/0Xf19cWn7AM/s1600/madonna-for-tom-munro-photoshoot-3-madonna-let-s-see-what-you-ve-still-got.jpeg"),
                                           SampleCardModelX(title: "Elton John", description: "#music", imageURL: "https://iconicimages.net/app/uploads/2017/01/EJ035.jpg"),
                                           SampleCardModelX(title: "Michael Jackson", description: "#music", imageURL: "https://papers.co/wallpaper/papers.co-hc08-michael-jackson-concert-king-of-pop-40-wallpaper.jpg?download=true"),
                                           SampleCardModelX(title: "Pink Floyd", description: "#music", imageURL: "https://iconicimages.net/app/uploads/2017/01/BW_PF009.jpg"),
                                           SampleCardModelX(title: "Prince", description: "#music", imageURL: "https://images.squarespace-cdn.com/content/v1/562eaa6ae4b05b1125147be2/1547262760091-XEBVN4OPRYNELJU5DUJK/ke17ZwdGBToddI8pDm48kGWSdQKjlHWYv6-Km_O64AsUqsxRUqqbr1mOJYKfIPR7LoDQ9mXPOjoJoqy81S2I8GRo6ASst2s6pLvNAu_PZdLNSyvILuuIZXttN5iGDlJ68XcSNXCslwDXtpjoF6UQfnWDpg_rM9mH5t3BIXV0L_Q/b0204be647f5af5cf7a86d83013b28bd--prince-purple-rain-heart.jpg"),
                                           SampleCardModelX(title: "Rod Stewart", description: "#music", imageURL: "https://www.gannett-cdn.com/media/Nashville/Nashville/2014/09/18/1411051440001-Rod-Stewart-02.JPG?width=1588"),
                                           SampleCardModelX(title: "Led Zeppelin", description: "#music", imageURL: "https://bloximages.chicago2.vip.townnews.com/kearneyhub.com/content/tncms/assets/v3/editorial/4/3c/43cf2b0c-ec8d-11e9-af4f-b315d7820c2d/5da12888296da.image.jpg"),
                                           SampleCardModelX(title: "Frank Sinatra", description: "#music", imageURL: "https://cdn.britannica.com/20/187920-050-0425AFBB/Frank-Sinatra-1947.jpg"),
                                           SampleCardModelX(title: "Barbra Streisand", description: "#music", imageURL: "https://upload.wikimedia.org/wikipedia/en/b/ba/Barbra_Streisand_singing-_1969.jpg"),
                                           SampleCardModelX(title: "David Bowie", description: "#music", imageURL: "https://thefader-res.cloudinary.com/private_images/w_1440,c_limit,f_auto,q_auto:best/GettyImages-92783142_pt323t/how-to-stay-glam-as-fuck-forever-according-to-david-bowie.jpg"),
                                           SampleCardModelX(title: "Queen", description: "#music", imageURL: "https://pmchollywoodlife.files.wordpress.com/2017/09/freddie-mercury-1.jpg?w=774"),
                                           SampleCardModelX(title: "Bon Jovi", description: "#music", imageURL: "https://flashbak.com/wp-content/uploads/2018/04/1983_bon_jovi_1983_s00266.jpg"),
                                           SampleCardModelX(title: "Celine Dion", description: "#music", imageURL: "https://i.pinimg.com/originals/88/c6/09/88c6096b9d5ce0772da2352aca548c02.jpg"),
                                           SampleCardModelX(title: "Neil Young", description: "#music", imageURL: "https://www.needsomefun.net/wp-content/uploads/2019/02/neil-young-black-and-white-20.jpg"),
                                           SampleCardModelX(title: "REM", description: "#music", imageURL: "https://www.rollingstone.com/wp-content/uploads/2018/06/rm-rem-43860984-d38c-44fb-bea7-c56403c265c0.jpg"),
                                           SampleCardModelX(title: "Mariah Carey", description: "#music", imageURL: "https://www.instagram.com/p/Bn85Bc4HMZK/media/?size=l"),
                                           SampleCardModelX(title: "AC/DC", description: "#music", imageURL: "https://i.pinimg.com/originals/5b/e2/aa/5be2aaad4215b0fb5a7c762d51a24ccd.jpg"),
                                           SampleCardModelX(title: "Bee Gees", description: "#music", imageURL: "https://i.pinimg.com/originals/70/dd/e9/70dde99fad50a4db9ee61ea49f31a4e1.jpg"),
                                           SampleCardModelX(title: "Santana", description: "#music", imageURL: "https://bento.cdn.pbs.org/hostedbento-prod/filer_public/latinmusicusa/Artists/santana_16x9.jpg"),
                                           SampleCardModelX(title: "Metallica", description: "#music", imageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/James_Hetfield_2017.jpg/1200px-James_Hetfield_2017.jpg"),
                                           SampleCardModelX(title: "Eminem", description: "#music", imageURL: "https://i.pinimg.com/originals/d4/a8/bd/d4a8bd35c209214cad0e69694d3fae79.jpg"),
                                           SampleCardModelX(title: "Eric Clapton", description: "#music", imageURL: "https://www.morrisonhotelgallery.com/images/big/Eric%20Clapton%20with%20Sunglasses.jpg"),
                                           SampleCardModelX(title: "Phil Collins", description: "#music", imageURL: "https://www.morrisonhotelgallery.com/images/big/SPS_PHIL%20COLLINS.jpg"),
                                           SampleCardModelX(title: "Neil Diamond", description: "#music", imageURL: "https://images.forwardcdn.com/image/1300x/center/top/images/cropped/gettyimages-636555232-1516743112.jpg"),
                                           SampleCardModelX(title: "Whitney Houston", description: "#music", imageURL: "https://upload.wikimedia.org/wikipedia/commons/a/a7/Whitney_Houston_Welcome_Home_Heroes_1_cropped.jpg"),
                                           SampleCardModelX(title: "Fleetwood Mac", description: "#music", imageURL: "https://m.media-amazon.com/images/M/MV5BNDI0Y2FkYzUtNjViZS00YTY0LWFhMjItZDYxY2MyMzVkOTdjXkEyXkFqcGdeQXVyNDUzOTQ5MjY@._V1_SY1000_CR0,0,830,1000_AL_.jpg"),
                                           SampleCardModelX(title: "Abba", description: "#music", imageURL: "https://66.media.tumblr.com/28cf422e58e3b0c453ce36a068cbb90b/tumblr_o3quqhWPfR1slfhvyo1_1280.jpg"),
                                           SampleCardModelX(title: "The Beach Boys", description: "#music", imageURL: "https://cdn.britannica.com/28/198728-050-178A6431/The-Beach-Boys-Al-Jardine-Dennis-Wilson-1966.jpg"),
                                           SampleCardModelX(title: "Pearl Jam", description: "#music", imageURL: "https://i.pinimg.com/originals/85/dc/9f/85dc9f76e06c4802c9f11e50157701b2.jpg"),
                                           SampleCardModelX(title: "Jimi Hendrix", description: "#music", imageURL: "https://cdn.mos.cms.futurecdn.net/Er7f2aS9ukBKBsVfR2Z9uE.jpg"),
                                           SampleCardModelX(title: "Eagles", description: "#music", imageURL: "https://preview.redd.it/bt9ud6vbgnf21.jpg?auto=webp&s=33968d116a75bfd660dc0313dcdc01e93fc3e840"),
                                           SampleCardModelX(title: "Billy Joel", description: "#music", imageURL: "https://images.fineartamerica.com/images/artworkimages/mediumlarge/2/billy-joel-express.jpg"),
                                           SampleCardModelX(title: "Depeche Mode", description: "#music", imageURL: "https://pbs.twimg.com/media/Dm1pD-PXcAApyNR.jpg"),
                                           SampleCardModelX(title: "Genesis", description: "#music", imageURL: "https://cdn.mos.cms.futurecdn.net/3bYWfU3GejxyxBoAtygVFc.jpg"),
                                           SampleCardModelX(title: "Dire Straits", description: "#music", imageURL: "https://guitar.com/wp-content/uploads/2019/08/young-mark-knopfler-red-strat@1050x1400.jpg"),
                                           SampleCardModelX(title: "Simon & Garfunkel", description: "#music", imageURL: "https://www.ft.com/__origami/service/image/v2/images/raw/ftcms%3A7d96b6b4-e736-11e8-8827-ff56e7163c11?source=ig"),
                                           SampleCardModelX(title: "Paul McCartney", description: "#music", imageURL: "https://data.whicdn.com/images/18162522/original.jpg"),
                                           SampleCardModelX(title: "The Who", description: "#music", imageURL: "https://i.pinimg.com/originals/f4/e4/6f/f4e46f0d521b41a295e9f5418e4b6bb5.jpg"),
                                           SampleCardModelX(title: "John Lennon", description: "#music", imageURL: "https://api.time.com/wp-content/uploads/2015/10/151001-john-lennon-23.jpg?quality=85"),
                                           SampleCardModelX(title: "Iron Maiden", description: "#music", imageURL: "https://www.theplace2.ru/archive/iron_maiden/img/f654629fbbfe68fa2a4e.jpg"),
                                           SampleCardModelX(title: "Stevie Wonder", description: "#music", imageURL: "https://upload.wikimedia.org/wikipedia/commons/5/54/Stevie_Wonder_1973.JPG"),
                                           SampleCardModelX(title: "Deep Purple", description: "#music", imageURL: "https://i.pinimg.com/originals/07/47/c6/0747c698ebc54a4f335149c3e88c5093.jpg"),
                                           SampleCardModelX(title: "Red Hot Chili Peppers", description: "#music", imageURL: "https://cuffarophoto.com/wp-content/uploads/2013/08/08_c55473.jpg"),
                                           SampleCardModelX(title: "Sting", description: "#music", imageURL: "https://upload.wikimedia.org/wikipedia/commons/4/40/Sting_in_April_2018.jpg"),
                                           SampleCardModelX(title: "Radiohead", description: "#music", imageURL: "https://i.pinimg.com/originals/00/c7/71/00c7711a4e3e1ef9fd05c59e84b2bb3a.jpg"),
                                           SampleCardModelX(title: "Nirvana", description: "#music", imageURL: "https://upload.wikimedia.org/wikipedia/commons/5/59/Kurt_St_Thomas_1991_cropped.jpg"),
                                           SampleCardModelX(title: "Van Morrison", description: "#music", imageURL: "https://www.rollingstone.com/wp-content/uploads/2018/11/van-morrison-astral-weeks.jpg"),
                                           SampleCardModelX(title: "Guns n' Roses", description: "#music", imageURL: "https://i.pinimg.com/originals/14/b5/aa/14b5aab6d1f81a43aa1e07b47a3d6c93.jpg"),
                                           SampleCardModelX(title: "Chicago", description: "#music", imageURL: "https://static.stereogum.com/uploads/2016/04/chicago-compressed.jpg"),
                                           SampleCardModelX(title: "Coldplay", description: "#music", imageURL: "https://cdn1.thr.com/sites/default/files/2014/05/coldplay_royce_hall_a_p.jpg"),
                                           SampleCardModelX(title: "Britney Spears", description: "#music", imageURL: "https://i.pinimg.com/originals/5b/e4/bf/5be4bfc52251cb8780ee32c399e3b5aa.jpg"),
                                           SampleCardModelX(title: "Jethro Tull", description: "#music", imageURL: "https://live.staticflickr.com/2752/4374242878_81383d0058_b.jpg"),
                                           SampleCardModelX(title: "Bryan Adams", description: "#music", imageURL: "https://www.theplace2.ru/cache/archive/bryan_adams/img/bryan_adams-gthumb-gwdata1200-ghdata1200-gfitdatamax.jpg"),
                                           SampleCardModelX(title: "Aerosmith", description: "#music", imageURL: "https://www.morrisonhotelgallery.com/images/big/14%20Steven%20Tyler%20of%20Aerosmith,%201986.jpg"),
                                           SampleCardModelX(title: "Johnny Cash", description: "#music", imageURL: "https://i.pinimg.com/originals/79/84/76/7984762d2e499543506bcaa97a8829df.jpg"),
                                           SampleCardModelX(title: "Paul Simon", description: "#music", imageURL: "https://www.morrisonhotelgallery.com/images/big/10%20Paul%20Simon,%201978.jpg"),
                                           SampleCardModelX(title: "Bob Marley", description: "#music", imageURL: "https://the1a.org/wp-content/uploads/sites/4/2017/07/GettyImages-3259910-683x1024.jpg"),
                                           SampleCardModelX(title: "Van Halen", description: "#music", imageURL: "https://townsquare.media/site/295/files/2019/01/GettyImages-136658770.jpg?w=980&q=75"),
                                           SampleCardModelX(title: "Janet Jackson", description: "#music", imageURL: "https://i.pinimg.com/originals/e2/fa/9c/e2fa9c680bbf2ae49c85953affbd149c.jpg"),
                                           SampleCardModelX(title: "Garth Brooks", description: "#music", imageURL: "https://lh3.googleusercontent.com/proxy/HGyIlS5wPSnTPV9VaBUwq7fQpQjVoEqH4KE4AZhQ61-gVUjm2krEFpbhq-erPfZBH03J8s998oHSIiBe8CY9EPG1jL3mu2UZ4InFoEuaHiNvi8Q3Ac8GcTv-5IpUBKeHLucCaSUUji7uFakq-FZW4WOrG4GMqaDWRJ9R_IT0lFEZ3o2L7a4xCF7lRKhz6Zc"),
                                           SampleCardModelX(title: "Andrea Bocelli", description: "#music", imageURL: "https://307047-939351-raikfcquaxqncofqfm.stackpathdns.com/wp-content/uploads/2019/04/hero-mobil-tour.jpg"),
                                           SampleCardModelX(title: "Kiss", description: "#music", imageURL: "https://www.ft.com/__origami/service/image/v2/images/raw/http%3A%2F%2Fcom.ft.imagepublish.upp-prod-us.s3.amazonaws.com%2Fade583b4-9ccf-11e9-9c06-a4640c9feebb?fit=scale-down&source=next&width=700"),
                                           SampleCardModelX(title: "Miles Davis", description: "#music", imageURL: "https://i.pinimg.com/originals/dd/af/5b/ddaf5b606acbd29d0db20cedfdaa1358.jpg"),
                                           SampleCardModelX(title: "Green Day", description: "#music", imageURL: "https://dt7v1i9vyp3mf.cloudfront.net/styles/news_large/s3/imagelibrary/C/ClassicTracks_01-0211-dKANrpCPACcpq2Qvt1NT6d84Pzuls91..jpg"),
                                           SampleCardModelX(title: "Robbie Williams", description: "#music", imageURL: "https://www.thesun.co.uk/wp-content/uploads/2016/06/nintchdbpict000247195645.jpg"),
                                           SampleCardModelX(title: "The Backstreet Boys", description: "#music", imageURL: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fcdn-img.instyle.com%2Fsites%2Fdefault%2Ffiles%2Fstyles%2F684xflex%2Fpublic%2Fimages%2F2016%2F04%2F040516-backstreet-boys-lead.jpg%3Fitok%3Day44Wa1t"),
                                           SampleCardModelX(title: "The Police", description: "#music", imageURL: "https://i.pinimg.com/originals/9d/4a/72/9d4a723aaea4813679594f89472b359e.jpg"),
                                           SampleCardModelX(title: "The Doors", description: "#music", imageURL: "https://iscale.iheart.com/catalog/artist/58402"),
                                           SampleCardModelX(title: "Wings", description: "#music", imageURL: "https://paulmccartneypod.files.wordpress.com/2017/07/band-1.jpg?w=1000&h=1000&crop=1"),
                                           SampleCardModelX(title: "Linkin Park", description: "#music", imageURL: "https://cdn.vox-cdn.com/thumbor/rK3T3qJKt9TD9tjiQZJNU6RWiIM=/0x144:3000x2000/1400x1400/filters:focal(1587x973:2067x1453):format(jpeg)/cdn.vox-cdn.com/uploads/chorus_image/image/55808999/687020280.0.jpg"),
                                           SampleCardModelX(title: "Herb Alpert", description: "#music", imageURL: "https://upload.wikimedia.org/wikipedia/commons/e/e0/Herb_Alpert_1966.jpg"),
                                           SampleCardModelX(title: "The Cure", description: "#music", imageURL: "https://wallpapercave.com/wp/wp1899621.jpg"),
                                           SampleCardModelX(title: "Rush", description: "#music", imageURL: "https://i.pinimg.com/originals/b1/38/69/b1386968fb8a78ab3131f0bf99dbbf52.jpg"),
                                           SampleCardModelX(title: "Oasis", description: "#music", imageURL: "https://www.liveabout.com/thmb/UlQbTbdWMKi9mbyJKOkj-4mcdV4=/2883x2162/smart/filters:no_upscale()/51129222-58b8e5665f9b58af5c912c9c.jpg"),
                                           SampleCardModelX(title: "Peter Gabriel", description: "#music", imageURL: "https://i.pinimg.com/originals/37/80/db/3780db4d42b022b1d69ccebde0c4c9e3.jpg"),
                                           SampleCardModelX(title: "Def Leppard", description: "#music", imageURL: "https://i.pinimg.com/474x/93/d4/de/93d4de14b07af44772e9865bf22b281d.jpg"),
                                           SampleCardModelX(title: "Lionel Richie", description: "#music", imageURL: "https://i.huffpost.com/gen/1201948/thumbs/o-LIONEL-RICHIE-JHER-CURL-570.jpg?4"),
                                           SampleCardModelX(title: "Alanis Morissette", description: "#music", imageURL: "https://static01.nyt.com/images/2019/12/01/magazine/01mag-morissette-image-02/01mag-morissette-image-02-mobileMasterAt3x.jpg"),
                                           SampleCardModelX(title: "Cat Stevens", description: "#music", imageURL: "https://www.rollingstone.com/wp-content/uploads/2018/06/rs-27915-catstevens-1800-1386942005.jpg"),
                                           SampleCardModelX(title: "Johnny Mathis", description: "#music", imageURL: "https://images-na.ssl-images-amazon.com/images/I/C1WYETpNAiS._SL1000_.png"),
                                           SampleCardModelX(title: "Simply Red", description: "#music", imageURL: "https://66.media.tumblr.com/56b83726a720ee385880257f11e4b677/tumblr_oxw91msfBF1u6qucvo1_500.jpg"),
                                           SampleCardModelX(title: "James Last", description: "#music", imageURL: "https://upload.wikimedia.org/wikipedia/commons/2/2b/Grand_Gala_du_Disque_in_RAI_Amsterdam._James_Last_Band%2C_Bestanddeelnr_923-3019.jpg"),
                                           SampleCardModelX(title: "Tina Turner", description: "#music", imageURL: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2018%2F01%2Ftina-turner-12.jpg"),
                                           SampleCardModelX(title: "Elvis Costello", description: "#music", imageURL: "https://4.bp.blogspot.com/-Nizlr3i2mK8/UdG9QNUNfII/AAAAAAAAFG8/wW-TS6r1DPs/s1600/Elvis_Costello_f16A.JPG"),
                                           SampleCardModelX(title: "Tom Petty & The Heartbreakers", description: "#music", imageURL: "https://www.rollingstone.com/wp-content/uploads/2018/09/1320_FOB_MIX_Campbell_B.jpg?w=724"),
                                           SampleCardModelX(title: "George Michael", description: "#music", imageURL: "https://www.morrisonhotelgallery.com/images/big/George%20Michael%201988.jpg"),
                                           SampleCardModelX(title: "Aretha Franklin", description: "#music", imageURL: "https://media.newyorker.com/photos/5b76fc414e612448fe8219f2/master/pass/StFelix-ArethaFranklin-2.jpg"),
                                           SampleCardModelX(title: "Joe Cocker", description: "#music", imageURL: "https://www.ft.com/__origami/service/image/v2/images/raw/http%3A%2F%2Fcom.ft.imagepublish.upp-prod-us.s3.amazonaws.com%2Fbaa43ece-6ca5-11e9-a9a5-351eeaef6d84?fit=scale-down&source=next&width=700"),
                                           SampleCardModelX(title: "Creedence Clearwater Revival", description: "#music", imageURL: "https://iscale.iheart.com/catalog/artist/35051"),
                                           SampleCardModelX(title: "Michael Buble", description: "#music", imageURL: "https://press.warnerrecords.com/wp-content/uploads/2018/01/photo-credit-evaan-kheraj-extralarge_1471396669602.jpg"),
                                           SampleCardModelX(title: "Ray Charles", description: "#music", imageURL: "https://hips.hearstapps.com/esq.h-cdn.co/assets/15/17/1429827516-74257065.jpg"),
                                           SampleCardModelX(title: "Black Sabbath", description: "#music", imageURL: "https://www.morrisonhotelgallery.com/images/big/Ozzy%20jpg451.jpg"),
                                           SampleCardModelX(title: "Supertramp", description: "#music", imageURL: "https://i.pinimg.com/originals/ab/9f/3d/ab9f3d9e2c8d777e3257c47a3414869f.jpg"),
                                           SampleCardModelX(title: "Donna Summer", description: "#music", imageURL: "https://imaging.broadway.com/images/custom/w1470/111475-0.jpg"),
                                           SampleCardModelX(title: "Mike Oldfield", description: "#music", imageURL: "https://www.innerviews.org/inner/oldfield/mo12.jpg"),]
        
        var interestIDArray : [String] = ["0TtwOtkUFm1QQQSPJDMt", "0cCo3FfXzztvJfeFLwj1", "0cmMeXsL1k8vaplXfW2V", "0r2Jd5ZqFrYtseQmfupo", "2B0obYFAtmFMEToxIoTy", "2i1b9bzCUCkk6VnZxNQh", "2sZST2abOZ4IfCLhF3oL", "3bsa3GNfKesKDkl95LLC", "3l4tBsm3h5Bvf1htp1oI", "3v8o00iITSO5UdiNauN5", "453YNHW0T1qJXtcLWi72", "4lhD6djRrr8MT4wZ2i0K", "4odeYnZOd3pK6UE2wrJP", "5wjrOZxGgpRhVZF7u94N", "7XjqwxZOZ7jiTHYJMiOp", "ASOteJ8ihlAKxhgVRZer", "Ai73cId3rcIWF73e9ekF", "AiYew1cAkMNi8YUxUl7P", "AmlzsMnTxqcNgp8fE2bT", "BvpFJjGCUyGhHZSrALSN", "CkFiqAXlnfS1k3d5f5GO", "DpbAnDwoTc1VvBjZxPap", "E2TehgEAqPFHRzGkjNjt", "EHsF0VCKTnWI3JnU46vT", "EPVtqJPJi6YI0OIXyhlJ", "ETQ4XnL5EPfP7P0uNV0P", "EiltGAYr7lvAP9kzheeK", "G0ZvXhbKHZrCxPxXyMiK", "GDpcpb6siyZplrHxM9hv", "IzIcTjPelMpbU9kgLhXZ", "JFOGMVFyBqb5DLGdsNYd", "JW9Z5wSF2VAiOEskqsz8", "JY9wUqvbXWoze69xKUle", "K3UZ8eZ2rRlG8qjUL9Z2", "LL8PhMgJRZ5wMUAZaouu", "MkiW3kObmY1nPhaJbANV", "MsbvWDBVsZG4RTVhxdAq", "NQvSLNPw5Hgt9Tw7iTc0", "OIeXvrSaC1J2J3qF6q3C", "ORh7XWDNkFQKuSMEEXLl", "OTkTOBWNK44zn1EpUXEM", "OqYqWxLcvymh4YtxPZg2", "R5EeYwycwfY443OntilR", "RHEHaZ2RsekLv28uuo7J", "RNsfjRyfloFFE7XfEuTQ", "TaWRATLGAEUp0wfS1kbn", "W0rtum6wPlOwuRIckKD8", "XMlyuZYHGV4I5yqfvylH", "XZaBx53bV7TJJ5G5HO94", "XaZ8yFjlYq1KooRW7D9P", "YLlm2yNII412it9Fk18f", "aqO8CXuCmbaafCohJ5hZ", "byTrs3t4gh8OZAwNbaVs", "cRlXD6379McxgiBzQLUH", "cVv3AF1ra1ho8ed4NYun", "d3QCcRofc7kSaoQmfqJF", "dNZh7pqPSelXDXAq3Ser", "dqsfyYCJIUlHVudrUA1G", "egWNxI1JJVIovvakYH0z", "f7au2k4OmijI1EZdBXOA", "fpaYUYKcodzpREhRtxfx", "gUNLykVpHOChcIM85ASH", "gfYK4XH96gpmWQKm1TY8", "gpcev14kWngWc52ktQqb", "hQtdopdR5JKKhlyFq7Wo", "hWvZuEF7wAvQS5ETJpMe", "hkiN1185lsC3Ikr49Vyg", "hxQmhCy2nIVSYxCkIbzR", "i3sZeJR5WSvcBjlEH02H", "iMb4kRIfLQ4Shb9DgorI", "iQuVnw6hVjgCYKKyWwkS", "idakibf3d8RLnU5e0u08", "igby3F7cqhQ4OnOgEDgR", "iv3ec9MH8p5ioyvolj0b", "j3tciGD56cDFNjMY3j94", "js7t44yHTeGf4cp9INez", "k9hvnc35WiEVtTb5AHuy", "lWef17YuuzTrjjHgHSwd", "mvdDiESKrgxSijYnpZGC", "nCgcSeFSOsYLFaa34sze", "nDUlFEkN0WkB56DiKoS0", "nbcfFKBl5M0ZZnRAAypN", "nj2OyCMxZAUp0xHJVkRl", "oQMqQIGI8jlzFvT17OGM", "oWzLxPjzcQuW1JQrSEzi", "p0kneqyerdO4PYBOcatz", "tVOiHXaFfFiBvt2CeoiL", "uXbgLl98Pbf09W8Gh3Gt", "uk54ZPfUmBrA7pXYCrPW", "vrZwBJXQ30KbvQyHwg51", "wCIzzQgNrZhpcHhLQShT", "wSbMOBrqqDZIT4Fpo35q", "wduvJBf1m62mINwbMWP4", "x1krKajG1i2BdSlkJtXB", "xMMDTFem2568RZ9n6Edx", "xQfBj96MSJan0ltSddwQ", "xwOv5fcCvD41gncunGat", "xyhGh1rals55lF9echPI", "y5Yraru1s1lPO6ohqS8I", "yel0HgYDXkma87HMrqrR", "zbfrh8M4Ns5qcVe0gbw4"]
        
        var likedBy : [String] = ["2K3ygENQdVwdh06tEwKV", "2ahRCvGibHsUsFwSkggi", "2e13WT7PFK4HMwEkCFM2", "3TT3m8ypSvd03C0hU1k6", "3prvylwaV1zEEIM56P7l", "46rUKilX8BecFRJ68bmK", "4kNG4hwiv0eVKLCG3v05", "4qNkI45rEQ0RZD3BObLW", "58xWZbYqEgvVjyWQOMol", "5exkXBI7eOjD7qQdzQbL", "5p7UuXfi9CIWwR8IAwgL", "5vDlKJSxOe4oMxUZkLmg", "6Ci0AieoOhHWkrmlot2V", "6ySdCyg8KKUfMozrjoVJ", "86Q3KO2rfZ55KoNYJ0IA", "8foNRjy9P9iT1nEEef8P", "9zzfSYxlSUnPYRUjTJvo", "A2T3RM4KC5C3jvh2IoEl", "AnIutU4YmVcitwiIWHki", "BA2oXdz6xARAUTiMIWVb", "BgyzMvySim9YYxxds5e8", "C9wyrAFOEpLerVMPABIf", "CWM0mZaT06GLEDpeEfko", "Cbn8WPGoGthsW4QJZsB5", "DcPldc0rOsAXb8Yvo1I0", "DpHnEEOJCvTGpR0gub77", "G5VJNYKPFEdrjPIe6UAn", "GJ9zPVs87dlwodeWOLqU", "GaxJY8OtwboxkX6pAe15", "HiQmkTeBZ03CqlntUOHD", "HvxKMoqBeUjat1DwjrXo", "Icp90E6kjid7GO4qYcrR", "JFIUyjs6ouHqpUzChq8D", "K79JoAhzKeCe4t0drQ2B", "KonFeCOco2qZF5hX7vQT", "LAtuPckUPpcPGIsBlmPJ", "LGzemwihPMuZ7NM51rfa", "LO9Y1rfqPc3UretTZqbX", "M3LOvNktSWDkVG5glDlx", "MyZZKMLiLNpKlUyOzAVp", "ORqk5v3u6uC7NnF0MFzJ", "PBiy3NvGbVop5rIcZiCu", "PwXtTjV12RIBoCjMnFHL", "QIy9lO9kPYBOyKDuHpKd", "SlFV2HIaHhmWj0LF34HF", "Sx2ypDHCSMEjTQzTXWmj", "T1dIqhP6oRFcZOB2KLzT", "TcN6LPhCHrXAY0UjnUYs", "VEIyl8b0UzrCU39eeyGL", "Vo35WA68zhSllHm8hTQI", "XQqbCVYX1s07Prmwamwk", "YtU0GTGqVsdK4RenXz6D", "YxR5C3HB3F0urcw97qKi", "ZOvnwDcLdcLhwgBa2coC", "ZSHQofuY1V2qBAGHAvsI", "ZvTvHQx1MC0a49ZEOsVG", "acArh6nPrO5jPNS9fnNd", "bG8lT8N3k65xY3MvJ3pw", "bMmgnx5PWld47HCZmr2P", "bnMvg6zOwIpAYOJUwVJJ", "cmUa1L550SMyEa7r4lg7", "d7yZU8LzGISyojEobL7u", "dB9YGTLfMlF6rhLRoRiT", "dPUkOLEjFFdDgUw4zCaS", "eM7d0G4qMpxpV8bjtrd5", "euN4WP3hUFbLF7V7uMUg", "h1vNtsXTyel7ETjhoc6U", "h45BnJtsaeSlXx6HBCCC", "hqSJ8vRIY7ZZVDk6DBDO", "iOfrfvYo0lwU2gnSdLzL", "iRMcsC6NCRb3Q4SvjBjQ", "iSod0a1RYsBJNXezjMOG", "iY1DJAz37XOGWlvWRoQk", "itndEDObGt1AIE2hX4C2", "lhjBegpra9mYPKYBH1aE", "m3PFo7zfd896tubZOK9I", "n5YSiAMi5L4qSZYig6h6", "nX7Llr1Cb5bBragK1zvB", "nZb6KvTfHJA6iPhO6sNR", "o7U6Y8ojqIUkrnHXdZjU", "odwa18dZAKYBklBnlEIK", "onca85nHA4HwfR9x5FWm", "pAwSQrjEEOJSqYCSnHrW", "praWiSqyXv9bCJF8VKnX", "qFfMo3gEdrPoHBsNiOFt", "qLWbA0x8Nvaq5V3LRlmP", "qYjdezvXbBJmRXW1Cujx", "qsrJKftsCsqGeuV625MI", "rBdWn5rY69R7etMOr5BY", "rwAETywKF6QTKwVJgi0O", "sX2xVwv4dHmdRAOPAcIW", "sj2aOyJRgsaC9A8rnY8B", "tQNRsugFm3DKKpfu4CBN", "vLMCiyQEKdgr8QYOiTDV", "vZhx86GHcNTRpqB0pFXG", "wRPXdJNRFSvUtUtFlLEA", "wz0VNUtxdIFNQXP6k81q", "xhzwx9GDLGQJq98ogcla", "yKYxqbCyCSBvxp7RlaWu", "yPvLYE6YFQtyjwrj1P2u", "zfsZ8hukZ63rzh4wgTOm"]
        
        
        let batch = db.batch()
        var id : Int = 1
        for item in payload {
            
            let ref = db.collection("Interest-Profile").document("\(id)")
            batch.setData(["id":"\(id)","name":item.title, "description":item.description, "imageURL":item.imageURL, "likedBy":[]], forDocument: ref)
            
            id += 1
        }
        
        print("dope \(id)")
        
        batch.commit { (err) in
            print("dope done")
            print("done/")
        }
        
    }


}




class SampleCardModelX {
    var title : String
    var description : String
    var imageURL : String
    init(title: String, description: String, imageURL : String) {
        self.title = title
        self.description = description
        self.imageURL = imageURL
    }
}
