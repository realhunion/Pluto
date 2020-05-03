//
//  SwipeManager.swift
//  Pluto
//
//  Created by Hunain Ali on 4/24/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation
import Firebase

class SwipeManager {
    
    static let shared : SwipeManager = SwipeManager()
    
    var db = Firestore.firestore()
    
    var x : [SampleCardModel] = [SampleCardModel(title: "Post Malone", description: "#music", imageURL: URL(string: "https://dazedimg-dazedgroup.netdna-ssl.com/1080/azure/dazed-prod/1250/4/1254317.jpg")),
                            SampleCardModel(title: "Drake", description: "#music", imageURL: URL(string: "https://media.resources.festicket.com/www/artists/Drake.jpg")),
                            SampleCardModel(title: "XXXTENTACION", description: "#music", imageURL: URL(string: "https://i.redd.it/xh8qdsmmio2z.jpg")),
                            SampleCardModel(title: "Billie Eilish", description: "#music", imageURL: URL(string: "https://i.pinimg.com/564x/38/71/b8/3871b8b9bbd4f4f2357d36f95d2a2188.jpg")),
                            SampleCardModel(title: "Juice WRLD", description: "#music", imageURL: URL(string: "https://dazedimg-dazedgroup.netdna-ssl.com/600/azure/dazed-prod/1280/1/1281173.jpg")),
                            SampleCardModel(title: "Khalid", description: "#music", imageURL: URL(string: "https://images.hdqwalls.com/download/khalid-iw-1125x2436.jpg")),
                            SampleCardModel(title: "Travis Scott", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/ac/46/de/ac46dea7fda7592582509602e0950356.jpg")),
                            SampleCardModel(title: "Lil Uzi Vert", description: "#music", imageURL: URL(string: "https://media.gq.com/photos/5d7a6ef69f076b0008f2c802/master/w_1600%2Cc_limit/lil-uzi-the-enormous-appetites-of-lil-uzi-vert-gq-october-2019-07.jpg")),
                            SampleCardModel(title: "Ariana Grande", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/4c/91/f8/4c91f8c67f06985a70439a6717a3ec42.jpg")),
                            SampleCardModel(title: "Kendrick Lamar", description: "#music", imageURL: URL(string: "https://i.redd.it/uyej6gw9pjry.jpg")),
                            SampleCardModel(title: "Migos", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/11/ea/da/11eadac3f869f16d06762979bb262354.jpg")),
                            SampleCardModel(title: "Ed Sheeran", description: "#music", imageURL: URL(string: "https://free2music.com/images/singer/2018/11/07/ed-sheeran_1.jpg")),
                            SampleCardModel(title: "The Weeknd", description: "#music", imageURL: URL(string: "https://vignette.wikia.nocookie.net/taylor-swift/images/3/3f/The_Weeknd_1.jpg/revision/latest?cb=20190330062206")),
                            SampleCardModel(title: "Lil Baby", description: "#music", imageURL: URL(string: "https://thefader-res.cloudinary.com/private_images/w_1440,c_limit,f_auto,q_auto:best/image2_1_nycz6e/lil-baby-harder-than-ever-yes-indeed-interview.jpg")),
                            SampleCardModel(title: "Cardi B", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/da/1d/38/da1d38945ff15a1e57874df6a4aa72a8.jpg")),
                            SampleCardModel(title: "Kodak Black", description: "#music", imageURL: URL(string: "https://static01.nyt.com/images/2016/06/23/arts/23KODAKBLACK/23KODAKBLACK-superJumbo.jpg")),
                            SampleCardModel(title: "J. Cole", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/f7/e4/dd/f7e4dd5c19315b87342088571896f241.jpg")),
                            SampleCardModel(title: "Future", description: "#music", imageURL: URL(string: "https://celebrityinsider.org/wp-content/uploads/2020/02/Future-Eliza-Reign-Lawsuit-Social-Media.jpg")),
                            SampleCardModel(title: "21 Savage", description: "#music", imageURL: URL(string: "https://media.newyorker.com/photos/5c59bb60e2fabe1577c2e1c1/master/w_1600%2Cc_limit/Younger-21SavageArrest.jpg")),
                            SampleCardModel(title: "The Chainsmokers", description: "#music", imageURL: URL(string: "https://media4.s-nbcnews.com/i/newscms/2019_18/1430974/citi-concert-series-the-chainsmokers-today-main-190429_a83245d20cfa164558ebc0d56123d98d.jpg")),
                            SampleCardModel(title: "A Boogie Wit da Hoodie", description: "#music", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/d/d6/A_Boogie_Wit_da_Hoodie_2017_November.jpg")),
                            SampleCardModel(title: "Logic", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/fb/d7/8e/fbd78e83aea96ce9fad83d89f9487512.jpg")),
                            SampleCardModel(title: "Marshmello", description: "#music", imageURL: URL(string: "https://3.bp.blogspot.com/-7i6ZjIPWEIA/XH_74V9TDXI/AAAAAAAADU8/2FjhiIa2AxwH-MAgx2rWLpTV-FDqYrytwCKgBGAs/w2048-h2732-c/fortnite-br-marshmello-uhdpaper.com-4K-84.jpg")),
                            SampleCardModel(title: "Taylor Swift", description: "#music", imageURL: URL(string: "https://66.media.tumblr.com/7911d448c43e3aeb442239c159ba808f/tumblr_p7nz3fdKIF1r9hliho1_400.png")),
                            SampleCardModel(title: "DaBaby", description: "#music", imageURL: URL(string: "https://images.thefacecdn.com/images/ED001_DABABY_WEB_1.jpg?fit=crop&crop=focalpoint&fp-x=0.5&fp-y=0.5&w=1180")),
                            SampleCardModel(title: "Young Thug", description: "#music", imageURL: URL(string: "https://media.gq.com/photos/56c39f0b480eac5d29f2ebe6/master/pass/young-thug-square.jpg")),
                            SampleCardModel(title: "Eminem", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/d4/a8/bd/d4a8bd35c209214cad0e69694d3fae79.jpg")),
                            SampleCardModel(title: "Halsey", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/75/15/53/751553b3531b77011d1933ad0fca0dbf.jpg")),
                            SampleCardModel(title: "Imagine Dragons", description: "#music", imageURL: URL(string: "https://s3.amazonaws.com/arc-wordpress-client-uploads/tbt/wp-content/uploads/2018/08/11004850/imaginedragons2.jpg")),
                            SampleCardModel(title: "Lil Nas X", description: "#music", imageURL: URL(string: "https://api.time.com/wp-content/uploads/2019/08/lil-nas-x-lede-social.jpg?quality=85")),
                            SampleCardModel(title: "Shawn Mendes", description: "#music", imageURL: URL(string: "https://www.j-14.com/wp-content/uploads/2019/02/is-shawn-mendes-single-dating-love-life.jpg?fit=3638%2C2341")),
                            SampleCardModel(title: "Camila Cabello", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/8c/37/5e/8c375e48f2ef293fc67369099bfafc6c.jpg")),
                            SampleCardModel(title: "YNW Melly", description: "#music", imageURL: URL(string: "https://images.complex.com/complex/images/c_scale,f_auto,q_auto,w_1920/fl_lossy,pg_1/o8gjpqchifc2gzso7uls/ynw-melly-david-cabrera-lead")),
                            SampleCardModel(title: "6ix9ine", description: "#music", imageURL: URL(string: "https://i.guim.co.uk/img/media/0b437608be961daf640bd75ca4e4e3a6e1483ae9/0_53_3000_1800/master/3000..jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=a243cc19dc3799f7fec21e73c0cd5ace")),
                            SampleCardModel(title: "Lil Skies", description: "#music", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/6/66/Lil_skiess.jpg")),
                            SampleCardModel(title: "Maroon 5", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/5a/9d/a8/5a9da83c654136e6346195feee34a168.jpg")),
                            SampleCardModel(title: "Trippie Redd", description: "#music", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/a/ac/Trippie_Redd_Photo_by_Kris_Knesel.jpg")),
                            SampleCardModel(title: "Bad Bunny", description: "#music", imageURL: URL(string: "https://www.interviewmagazine.com/wp-content/uploads/2019/05/Interview_2019_Web_Summer_BadBunny-05.jpg")),
                            SampleCardModel(title: "Bazzi", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/c7/bc/23/c7bc239a4b8e386637479c313cddfca5.jpg")),
                            SampleCardModel(title: "DJ Khaled", description: "#music", imageURL: URL(string: "https://api.time.com/wp-content/uploads/2016/05/dj-khaled-helps-millenials-through-snapchat.jpg")),
                            SampleCardModel(title: "Gucci Mane", description: "#music", imageURL: URL(string: "https://pbs.twimg.com/media/D4NdRnzUwAsbOhU.jpg")),
                            SampleCardModel(title: "Kanye West", description: "#music", imageURL: URL(string: "https://api.time.com/wp-content/uploads/2000/04/kanye-west-time-100-2015-titans.jpg?quality=85&w=1012")),
                            SampleCardModel(title: "Roddy Ricch", description: "#music", imageURL: URL(string: "https://thefader-res.cloudinary.com/private_images/w_1440,c_limit,f_auto,q_auto:best/IMGP2241_tx5ked/roddy-ricch-feed-tha-streets-meek-mill-interview.jpg")),
                            SampleCardModel(title: "Lauv", description: "#music", imageURL: URL(string: "https://video-images.vice.com/articles/5d42e91445eba80008390259/lede/1564667728307-Lauv-fuck-im-lonely-Press-Select-1-Photo-Cred-Chris-Noltehuhlmann.jpeg?crop=1xw%3A0.3745xh%3B0xw%2C0.2328xh&resize=2000%3A*")),
                            SampleCardModel(title: "Sam Smith", description: "#music", imageURL: URL(string: "https://www.rollingstone.com/wp-content/uploads/2020/03/10501076fyW.jpg")),
                            SampleCardModel(title: "Offset", description: "#music", imageURL: URL(string: "https://c0.wallpaperflare.com/preview/16/576/1014/migos.jpg")),
                            SampleCardModel(title: "Lil Tecca", description: "#music", imageURL: URL(string: "https://audibletreats.com/wp-content/uploads/2019/05/000022770008-e1567008621169.jpeg")),
                            SampleCardModel(title: "Selena Gomez", description: "#music", imageURL: URL(string: "https://www.hawtcelebs.com/wp-content/uploads/2017/06/selena-gomez-on-the-set-of-a-photoshoot-in-new-york-06-05-2017_3.jpg")),
                            SampleCardModel(title: "Calvin Harris", description: "#music", imageURL: URL(string: "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fblogs-images.forbes.com%2Fhughmcintyre%2Ffiles%2F2017%2F02%2FPress-Shot-2017-1200x975.jpg")),
                            SampleCardModel(title: "Lizzo", description: "#music", imageURL: URL(string: "https://www.rollingstone.com/wp-content/uploads/2019/12/Lizzo-1.jpg")),
                            SampleCardModel(title: "Dan + Shay", description: "#music", imageURL: URL(string: "https://www.gannett-cdn.com/presto/2019/10/04/PNAS/fc422a6d-4dec-4b0f-a60c-4bbd9bc6b5ef-bieber_dan_and_shay.jpg?crop=3352,1886,x0,y1570&width=3200&height=1680&fit=bounds")),
                            SampleCardModel(title: "Dua Lipa", description: "#music", imageURL: URL(string: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2020%2F04%2F21%2Fdua-lipa-1-1.jpg&q=85")),
                            SampleCardModel(title: "Zedd", description: "#music", imageURL: URL(string: "https://www.grammy.com/sites/com/files/styles/image_landscape_hero/public/muzooka/Zedd/Zedd_16_9_1581551807.jpg?itok=uZYfMbOl")),
                            SampleCardModel(title: "Luke Combs", description: "#music", imageURL: URL(string: "https://www.rollingstone.com/wp-content/uploads/2019/11/191025_IanBates_-177W.jpg")),
                            SampleCardModel(title: "Big Sean", description: "#music", imageURL: URL(string: "https://wallpapercave.com/wp/wp1879740.jpg")),
                            SampleCardModel(title: "Harry Styles", description: "#music", imageURL: URL(string: "https://images.thefacecdn.com/images/ED001_MASTERCROPS_Harry.jpg?fit=crop&crop=focalpoint&fp-x=0.4338&fp-y=0.233&w=1180")),
                            SampleCardModel(title: "Rae Sremmurd", description: "#music", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/d/d6/Rae_Sremmurd.jpg")),
                            SampleCardModel(title: "Bebe Rexha", description: "#music", imageURL: URL(string: "https://www.celebsfirst.com/wp-content/uploads/2017/05/bebe-rexha-tmrw-magazine-vol17-photoshoot_2.jpg")),
                            SampleCardModel(title: "Bruno Mars", description: "#music", imageURL: URL(string: "https://inglam.ru/img/2019/03/Bruno-Mars-Latina-Magazine-2016-002.jpg")),
                            SampleCardModel(title: "G-Eazy", description: "#music", imageURL: URL(string: "https://img.discogs.com/h52XN43pnAHdfQCJ1JAyM2OjoqM=/600x899/smart/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/A-2875151-1546926502-6565.jpeg.jpg")),
                            SampleCardModel(title: "Rich The Kid", description: "#music", imageURL: URL(string: "https://www.bet.com/music/2020/03/16/21-questions-with-rich-the-kid--the-boss-man/_jcr_content/bodycopycontainer/listiclecontainer/listicleitem_16/embedded_image/image.custom1200x1800.dimg/__1584367123944__1584315831773/031320-social-talent-visit-Rich-The-Kid-fullres-06.jpg")),
                            SampleCardModel(title: "Meek Mill", description: "#music", imageURL: URL(string: "https://wallpapercave.com/wp/wp1967332.jpg")),
                            SampleCardModel(title: "benny blanco", description: "#music", imageURL: URL(string: "https://websiteserviceapi.azurewebsites.net/api/Images/1411026/5")),
                            SampleCardModel(title: "French Montana", description: "#music", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/e/e9/FM_PRESS03-A.png")),
                            SampleCardModel(title: "Lil Wayne", description: "#music", imageURL: URL(string: "https://nyppagesix.files.wordpress.com/2019/12/191224-lil-wayne-plane.jpg?quality=80&strip=all")),
                            SampleCardModel(title: "Mustard", description: "#music", imageURL: URL(string: "https://media.gq.com/photos/565dfd5c49ad37bf78161b3a/master/pass/dj-mustard-gq-01.jpg")),
                            SampleCardModel(title: "Luis Fonsi", description: "#music", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/a/a8/Luis_Fonsi_La_Voz_US_2019.jpg")),
                            SampleCardModel(title: "Lil Mosey", description: "#music", imageURL: URL(string: "https://cdn-sidewalkhustle.netdna-ssl.com/wp-content/uploads/2019/04/lilmosey-drew-sidewalk-1.jpg")),
                            SampleCardModel(title: "Childish Gambino", description: "#music", imageURL: URL(string: "https://www.grammy.com/sites/com/files/styles/image_landscape_hero/public/muzooka/Childish%2BGambino/Childish%2520Gambino_16_9_1581371417.jpg?itok=_AuG73_8")),
                            SampleCardModel(title: "NAV", description: "#music", imageURL: URL(string: "https://image-cdn.hypb.st/https%3A%2F%2Fhypebeast.com%2Fimage%2F2019%2F09%2Fnav-streetsnaps-street-style-interview-london-02.jpg?q=75&w=800&cbr=1&fit=max")),
                            SampleCardModel(title: "Kygo", description: "#music", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/4/43/Kygo_%2828481718120%29_%282%29_%28cropped%29.jpg")),
                            SampleCardModel(title: "KYLE", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/30/7e/ba/307ebad3cb872f8ee98034684856173b.jpg")),
                            SampleCardModel(title: "Tyga", description: "#music", imageURL: URL(string: "https://i.dailymail.co.uk/1s/2019/10/23/00/20061168-7602675-image-a-14_1571787507845.jpg")),
                            SampleCardModel(title: "Lil Pump", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/1f/80/2f/1f802f0d87650bd5ea7ce9df26537fb1.jpg")),
                            SampleCardModel(title: "Jonas Brothers", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/11/5a/4e/115a4e6e26a4e071e46d423df8f146ff.jpg")),
                            SampleCardModel(title: "Playboi Carti", description: "#music", imageURL: URL(string: "https://www.musicinsf.com/wp-content/uploads/2018/07/V9A9632.jpg")),
                            SampleCardModel(title: "Chance the Rapper", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/bd/1e/1b/bd1e1b115ae1a85e1ef10bbde25061f9.jpg")),
                            SampleCardModel(title: "blackbear", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/24/ae/0a/24ae0afec457e65e0c75bcf02d3f4f8e.png")),
                            SampleCardModel(title: "BlocBoy JB", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/4a/59/ba/4a59ba5d930fa8e1ca68dd974b004ac4.jpg")),
                            SampleCardModel(title: "5 Seconds of Summer", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/2e/18/bc/2e18bc22aa6e26e3d03d8ac96c4a3ca4.jpg")),
                            SampleCardModel(title: "Chris Brown", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/cd/4d/e3/cd4de3b556759d7bf9d98c72dc40f36e.jpg")),
                            SampleCardModel(title: "Justin Bieber", description: "#music", imageURL: URL(string: "https://static.billboard.com/files/media/justin-bieber-bb35-2015-billboard-04-1500-1289x1650.jpg")),
                            SampleCardModel(title: "Tyler, The Creator", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/69/87/d8/6987d8565d14c1696a99ec611058d434.jpg")),
                            SampleCardModel(title: "Famous Dex", description: "#music", imageURL: URL(string: "https://lastfm.freetls.fastly.net/i/u/770x0/8e359a72316d8aca453ba29a95a32ca8.jpg")),
                            SampleCardModel(title: "Lewis Capaldi", description: "#music", imageURL: URL(string: "https://78.media.tumblr.com/6c00c3d20977146b4ff0c5f6b07ffdba/tumblr_inline_p4u7bs2nKx1s9on4d_540.jpg")),
                            SampleCardModel(title: "Hailee Steinfeld", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/35/6b/50/356b506e7ab8827798836f61d716f101.jpg")),
                            SampleCardModel(title: "Panic! At The Disco", description: "#music", imageURL: URL(string: "https://www.pollstar.com/Image/Photos/2018/10/9e62df12-8d6c-403c-a4e7-306305a44044-Phil_Clarkin-0262.jpg")),
                            SampleCardModel(title: "Sheck Wes", description: "#music", imageURL: URL(string: "https://pbs.twimg.com/media/DcijxQzWAAA_TTN.jpg:large")),
                            SampleCardModel(title: "Metro Boomin", description: "#music", imageURL: URL(string: "https://i.redd.it/pfobo9zitjk21.jpg")),
                            SampleCardModel(title: "NLE Choppa", description: "#music", imageURL: URL(string: "https://bloximages.newyork1.vip.townnews.com/yakimaherald.com/content/tncms/assets/v3/editorial/1/00/100ffb9e-aa46-5200-9e9f-342552273632/5dd5ae8484acd.image.jpg?resize=1200%2C1388")),
                            SampleCardModel(title: "2 Chainz", description: "#music", imageURL: URL(string: "https://iscale.iheart.com/catalog/artist/675872")),
                            SampleCardModel(title: "ZAYN", description: "#music", imageURL: URL(string: "https://s2.r29static.com/bin/entry/832/x,80/2157318/image.jpg")),
                            SampleCardModel(title: "Russ", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/4b/fe/64/4bfe64af3c2b3b95eb175a7829ccb814.jpg")),
                            SampleCardModel(title: "Lady Gaga", description: "#music", imageURL: URL(string: "https://i.redd.it/u1sv4zxiyk131.jpg")),
                            SampleCardModel(title: "NF", description: "#music", imageURL: URL(string: "https://www.pollstar.com/Image/Photos/2018/01/289087bf-97c3-4abf-a23d-9476e4c5aee0-bobigshownf.jpg")),
                            SampleCardModel(title: "Demi Lovato", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/01/ef/e8/01efe82a54f7564ceb6a8f6504cdc4a2.jpg")),
                            SampleCardModel(title: "Martin Garrix", description: "#music", imageURL: URL(string: "https://weraveyou.com/wp-content/uploads/2016/09/14280608_1321424694541808_1801048201_n.jpg")),
                            SampleCardModel(title: "J Balvin", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/98/23/ca/9823ca75663ec13576e7f7a1dd9f0cd1.jpg")),
                            SampleCardModel(title: "Sam Hunt", description: "#music", imageURL: URL(string: "https://static01.nyt.com/images/2020/03/22/arts/22hunt5/22hunt5-articleLarge.jpg?quality=85&auto=webp&disable=upscale")),
                            SampleCardModel(title: "SZA", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/b6/af/c3/b6afc364075d8af0e066186fe087a91b.png")),
                            SampleCardModel(title: "James Arthur", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/0c/1b/bf/0c1bbf78240f7357859b756e0ed3023a.jpg")),
                            SampleCardModel(title: "YG", description: "#music", imageURL: URL(string: "https://image-cdn.hypb.st/https%3A%2F%2Fhypebeast.com%2Fimage%2F2018%2F10%2F4hunnid-late-to-school-lookbook-playboi-carti-006.jpg?q=75&w=800&cbr=1&fit=max")),
                            SampleCardModel(title: "YoungBoy Never Broke Again", description: "#music", imageURL: URL(string: "https://incorporatedstyle.com/content/uploads/youngboy-nba-instagram-3-5-19-incorporated-style-cover.jpg")),
                            SampleCardModel(title: "Charlie Puth", description: "#music", imageURL: URL(string: "https://static01.nyt.com/images/2018/05/27/arts/27PUTH1/27PUTH1-superJumbo.jpg")),
                            SampleCardModel(title: "Ski Mask The Slump God", description: "#music", imageURL: URL(string: "https://pm1.narvii.com/6465/87c3d452858398baf9724be368bff5c653a35fa2_hq.jpg")),
                            SampleCardModel(title: "Joji", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/95/4e/cc/954ecc5c6dfb0f08014df9faf0436335.jpg")),
                            SampleCardModel(title: "Bryson Tiller", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/a2/2a/01/a22a010a75126f6f02858596365226f2.jpg")),
                            SampleCardModel(title: "Polo G", description: "#music", imageURL: URL(string: "https://memberdata.s3.amazonaws.com/hi/hitsdd/photos/hitsdd_photo_gal__photo_2069068611.jpg")),
                            SampleCardModel(title: "DJ Snake", description: "#music", imageURL: URL(string: "https://pbs.twimg.com/media/D22d1HzXQAIohkx.jpg")),
                            SampleCardModel(title: "Flipp Dinero", description: "#music", imageURL: URL(string: "https://one37pm.imgix.net/one37pm-editor-dev-images/s3fs-public/user-images/2019-11/Flipp-Dinero-5234-2.jpg")),
                            SampleCardModel(title: "Mac Miller", description: "#music", imageURL: URL(string: "https://www.giantartists.com/images/pics/180814_Vulture_MacMiller_091_bw.jpg")),
                            SampleCardModel(title: "Arizona Zervas", description: "#music", imageURL: URL(string: "https://pbs.twimg.com/media/DFn8ToRUAAUTTCa.jpg")),
                            SampleCardModel(title: "BTS", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/d1/66/f4/d166f420bfc3da03a359087a97768cc0.jpg")),
                            SampleCardModel(title: "Queen", description: "#music", imageURL: URL(string: "https://pmchollywoodlife.files.wordpress.com/2017/09/freddie-mercury-1.jpg?w=774")),
                            SampleCardModel(title: "Thomas Rhett", description: "#music", imageURL: URL(string: "https://4.bp.blogspot.com/-DQadvQJbmlU/T_b5BwkIu9I/AAAAAAAAB2w/5qvOvKQumjQ/s1600/TR_PHOTO_(Key)_MG_8525+MAIN.jpg")),
                            SampleCardModel(title: "Julia Michaels", description: "#music", imageURL: URL(string: "https://www.theplace2.ru/cache/archive/julia_michaels/img/2017_jack_brindgland_vevo_lift_(10)-gthumb-gwdata1200-ghdata1200-gfitdatamax.jpg")),
                            SampleCardModel(title: "Ellie Goulding", description: "#music", imageURL: URL(string: "https://www.hawtcelebs.com/wp-content/uploads/2016/06/ellie-goulding-by-nino-munoz-photoshoot_2.jpg")),
                            SampleCardModel(title: "Clean Bandit", description: "#music", imageURL: URL(string: "https://vignette.wikia.nocookie.net/annemarieiam/images/3/36/Clean_Bandit.png/revision/latest?cb=20180806145421")),
                            SampleCardModel(title: "Kane Brown", description: "#music", imageURL: URL(string: "https://wallpapersmug.com/download/750x1334/a8ce35/celebrity-singer-kane-brown.jpg")),
                            SampleCardModel(title: "Aminé", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/72/d7/40/72d7402e089e52807d52d9974bdb026c.jpg")),
                            SampleCardModel(title: "A$AP Ferg", description: "#music", imageURL: URL(string: "https://images.squarespace-cdn.com/content/v1/54836859e4b05657e7b49f80/1569121901686-OGAREKA914M1NFD1KNTD/ke17ZwdGBToddI8pDm48kEE2HPKvbn8onGarKqvOYaJ7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z5QPOohDIaIeljMHgDF5CVlOqpeNLcJ80NK65_fV7S1UXjI5F5hyY69Rh34wz6Nqp9cAiO_t_aIrgXTcQvOFx1Ya9nzg0O0_sCfDyH3Q6rDGQ/A%EF%BF%BDAP_FERG-1.jpg?format=500w")),
                            SampleCardModel(title: "Tones And I", description: "#music", imageURL: URL(string: "https://www.readdork.com/images/article/Artist-Images/T/Tones%20And%20I/_crop1500x1000/tones-and-i-apr20.jpg")),
                            SampleCardModel(title: "A$AP Rocky", description: "#music", imageURL: URL(string: "https://66.media.tumblr.com/a40d81a79a93f9e513f001b140d00c5b/tumblr_poqy9hIGLd1s2dlreo1_1280.jpg")),
                            SampleCardModel(title: "Nicki Minaj", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/e6/86/96/e686969e7ab6f0c9d95f0de1c12422e0.jpg")),
                            SampleCardModel(title: "Doja Cat", description: "#music", imageURL: URL(string: "https://images.thefacecdn.com/images/ED002_MASTERSOCIAL_DOJACAT_1.jpg?fit=crop&crop=focalpoint&fp-x=0.3548&fp-y=0.4555&w=1180")),
                            SampleCardModel(title: "Twenty One Pilots", description: "#music", imageURL: URL(string: "https://i.pinimg.com/736x/e6/da/67/e6da67a5d47bae5d75f8186c58536d95.jpg")),
                            SampleCardModel(title: "Liam Payne", description: "#music", imageURL: URL(string: "https://www.thefashionisto.com/wp-content/uploads/2019/12/Liam-Payne-2019-Tetu-Magazine-Photo-Shoot-006.jpg")),
                            SampleCardModel(title: "YBN Nahmir", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/46/94/91/469491708c8e1a1d6aa05690495e3ca7.jpg")),
                            SampleCardModel(title: "Niall Horan", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/3c/7c/21/3c7c210d00fb210186aa07eeabf8b5f8.jpg")),
                            SampleCardModel(title: "Quality Control", description: "#music", imageURL: URL(string: "https://static01.nyt.com/images/2017/11/26/arts/26QUALITY1/26QUALITY1-superJumbo.jpg")),
                            SampleCardModel(title: "Calboy", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/1f/e4/eb/1fe4ebaaf2f60bb46452c702994e2c2f.jpg")),
                            SampleCardModel(title: "Machine Gun Kelly", description: "#music", imageURL: URL(string: "https://cdn.shopify.com/s/files/1/1878/3879/products/N3670.jpg?v=1551271114")),
                            SampleCardModel(title: "Blueface", description: "#music", imageURL: URL(string: "https://ca-times.brightspotcdn.com/dims4/default/4a385ab/2147483647/strip/true/crop/2800x2531+0+0/resize/1486x1343!/quality/90/?url=https%3A%2F%2Fcalifornia-times-brightspot.s3.amazonaws.com%2F5c%2Fdc%2Fb5e37e3749c59fee703fe764a89b%2F3083367-et-0621-blueface-6c-gmf.JPG")),
                            SampleCardModel(title: "Lil Peep", description: "#music", imageURL: URL(string: "https://www.mariotestino.com/wp-content/uploads/2017/09/00030_170205_017_MT_v3-1-1072x1400.jpg")),
                            SampleCardModel(title: "Tee Grizzley", description: "#music", imageURL: URL(string: "https://s3.amazonaws.com/stockx-sneaker-analysis/wp-content/uploads/2019/06/80640004.jpg")),
                            SampleCardModel(title: "6LACK", description: "#music", imageURL: URL(string: "https://lastfm.freetls.fastly.net/i/u/ar0/805bdacb125483ba9da90972b6ad01aa.jpg")),
                            SampleCardModel(title: "H.E.R.", description: "#music", imageURL: URL(string: "https://www.citynews1130.com/wp-content/blogs.dir/sites/9/2018/11/07/NYET303-117_2018_201718_hd.jpg")),
                            SampleCardModel(title: "Jay Rock", description: "#music", imageURL: URL(string: "https://images.squarespace-cdn.com/content/v1/5a17cae9f9a61edc99d6e79f/1548329549866-IPX7CR1HEPR19HIQM386/ke17ZwdGBToddI8pDm48kEsloQSdTeqlYevNz3NCbl17gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z4YTzHvnKhyp6Da-NYroOW3ZGjoBKy3azqku80C789l0hx0TKp4jCW7sB_BGURRbuWBQdLiSRgTSPVQN3C2ocbPT9mi99zz1Rhsrcv1q-Dh1A/jay+rock.jpg")),
                            SampleCardModel(title: "Dean Lewis", description: "#music", imageURL: URL(string: "https://cdn.newsapi.com.au/image/v1/82b7398464324f040a9b57f2dfbca261")),
                            SampleCardModel(title: "Megan Thee Stallion", description: "#music", imageURL: URL(string: "https://static01.nyt.com/images/2020/03/15/magazine/15mag-megantheestallion-03/15mag-megantheestallion-03-verticalTwoByThree735-v3.jpg")),
                            SampleCardModel(title: "Lil Xan", description: "#music", imageURL: URL(string: "https://metro.co.uk/wp-content/uploads/2018/09/sei_25785873-4588-e1537961522125.jpg?quality=90&strip=all")),
                            SampleCardModel(title: "Mariah Carey", description: "#music", imageURL: URL(string: "https://www.instagram.com/p/Bn85Bc4HMZK/media/?size=l")),
                            SampleCardModel(title: "Ella Mai", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/75/dd/f2/75ddf2948dd8529cd7aeeac54521e7cf.jpg")),
                            SampleCardModel(title: "Avicii", description: "#music", imageURL: URL(string: "https://www.rollingstone.com/wp-content/uploads/2018/06/avicii-final-days-826e4c7e-ef8a-4ac2-9763-a0e9d5f6d613.jpg")),
                            SampleCardModel(title: "Katy Perry", description: "#music", imageURL: URL(string: "https://assets.vogue.com/photos/58e7e6d603410e59b84c182b/master/w_1866,h_2500,c_limit/05-katy-perry-vogue-may-2017-cover-story-photos.jpg")),
                            SampleCardModel(title: "Tory Lanez", description: "#music", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/e/e3/Tory_Lanez_2500x1669.jpg")),
                            SampleCardModel(title: "Y2K", description: "#music", imageURL: URL(string: "https://www.c-heads.com/wp-content/uploads/2017/09/IMG_1280-Kopie.jpg")),
                            SampleCardModel(title: "DRAM", description: "#music", imageURL: URL(string: "https://media.pitchfork.com/photos/5d4af4b1cd61a4000929c9e8/2:1/w_2634,h_1317,c_limit/DRAM.jpg")),
                            SampleCardModel(title: "Trevor Daniel", description: "#music", imageURL: URL(string: "https://www.rollingstone.com/wp-content/uploads/2020/03/TD1.jpg?resize=1800,1200&w=1800")),
                            SampleCardModel(title: "Portugal. The Man", description: "#music", imageURL: URL(string: "https://www.portugaltheman.com/sites/g/files/g2000000591/f/201908/Bg_FaceLift.jpg?itok=BRMuiV5a")),
                            SampleCardModel(title: "Ali Gatie", description: "#music", imageURL: URL(string: "https://pbs.twimg.com/media/DivSjI3WAAAMzS3.jpg")),
                            SampleCardModel(title: "Lil Yachty", description: "#music", imageURL: URL(string: "https://wallpaperaccess.com/full/198619.jpg")),
                            SampleCardModel(title: "David Guetta", description: "#music", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/3/33/David_Guetta_2013-04-12_001.jpg")),
                            SampleCardModel(title: "Rihanna", description: "#music", imageURL: URL(string: "https://abrilcapricho.files.wordpress.com/2017/11/rihanna-batom-vermelho-fenty-beauty-1.jpg?quality=85&strip=info&w=1024")),
                            SampleCardModel(title: "Miley Cyrus", description: "#music", imageURL: URL(string: "https://www.hawtcelebs.com/wp-content/uploads/2019/03/miley-cyrus-on-the-set-of-a-photoshoot-march-2019-11.jpg")),
                            SampleCardModel(title: "Yo Gotti", description: "#music", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/7/7c/Yo_Gotti_2013.jpg")),
                            SampleCardModel(title: "Justin Timberlake", description: "#music", imageURL: URL(string: "https://www.sweetandtalented.com/men/images/timberlake/timberlake27.jpg")),
                            SampleCardModel(title: "PnB Rock", description: "#music", imageURL: URL(string: "https://images.squarespace-cdn.com/content/v1/58d985e4b3db2bf10b5b11ce/1521670612182-7HMCUJ428DLN2O0T5A24/ke17ZwdGBToddI8pDm48kMXRibDYMhUiookWqwUxEZ97gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z4YTzHvnKhyp6Da-NYroOW3ZGjoBKy3azqku80C789l0luUmcNM2NMBIHLdYyXL-Jww_XBra4mrrAHD6FMA3bNKOBm5vyMDUBjVQdcIrt03OQ/IMG_5770.jpg?format=1500w")),
                            SampleCardModel(title: "Lil Tjay", description: "#music", imageURL: URL(string: "https://cuindependent.com/new/wp-content/uploads/2019/12/49128850676_8b77b94327_o-scaled.jpeg")),
                            SampleCardModel(title: "Miguel", description: "#music", imageURL: URL(string: "https://www.thefashionisto.com/wp-content/uploads/2015/10/Miguel-2015-Photo-Shoot-Guardian-007.jpg")),
                            SampleCardModel(title: "Lil Dicky", description: "#music", imageURL: URL(string: "https://www.wmagazine.com/wp-content/uploads/2016/07/18/578d3cd257a63ce6129955e7_062916_W_LilDicky_0325crop.jpg?crop=3px,524px,3567px,2675px&w=1536px")),
                            SampleCardModel(title: "Alessia Cara", description: "#music", imageURL: URL(string: "https://dancingastronaut.com/wp-content/uploads/2018/08/Alessia-Cara-suicide-prevention-1.jpg")),
                            SampleCardModel(title: "Michael Bublé", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/f2/ae/e2/f2aee2ddd902d397fbcbe0b3dcaa4bf8.jpg")),
                            SampleCardModel(title: "Ava Max", description: "#music", imageURL: URL(string: "https://celebmafia.com/wp-content/uploads/2019/08/ava-max-euphoria.-magazine-photoshoot-2019-5.jpg")),
                            SampleCardModel(title: "Jason Derulo", description: "#music", imageURL: URL(string: "https://thenypost.files.wordpress.com/2019/11/jd4.jpg?quality=80&strip=all&w=1024")),
                            SampleCardModel(title: "Morgan Wallen", description: "#music", imageURL: URL(string: "https://www.shakyboots.com/wp-www-shakyboots-com/wp/wp-content/uploads/2019/12/morgan-wallen-5f0c8fee.jpg")),
                            SampleCardModel(title: "Major Lazer", description: "#music", imageURL: URL(string: "https://musiklemon.com/admin/upload/57fccd9ad8961.png")),
                            SampleCardModel(title: "ScHoolboy Q", description: "#music", imageURL: URL(string: "https://m.media-amazon.com/images/M/MV5BYjViZmIzMGItMjA0My00MDUyLTk2MjctZDJkMzMzNmJkODVlXkEyXkFqcGdeQXVyNTI5NjIyMw@@._V1_.jpg")),
                            SampleCardModel(title: "Dreamville", description: "#music", imageURL: URL(string: "https://lh3.googleusercontent.com/proxy/RY_kNeGsDFtfcUI3ZeOyL-pZkbpkxJdQuNBM921ST6K9zgqBRPHhf8w48fvoPxY89jOk_fr2qvPBsffP9qIdqNnZDsXjf2UPaVI78hkcS2VtXSjPGW-7LaWtro-n3vno8Ir-Fez--8kif6MaQFIp8zWtxQ")),
                            SampleCardModel(title: "Nio Garcia", description: "#music", imageURL: URL(string: "https://bonchevip.com/wp-content/uploads/2019/11/Hoy-Se-Bebe-de-Nio-Garcia-1-en-Republica-Dominicana.jpg")),
                            SampleCardModel(title: "Diplo", description: "#music", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/6/62/Diplo_2014_Press_Photo_%28cropped%29.jpg")),
                            SampleCardModel(title: "Macklemore", description: "#music", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/6/63/Macklemore_The_Heist_Tour_1_cropped.jpg")),
                            SampleCardModel(title: "Quavo", description: "#music", imageURL: URL(string: "https://media.gq.com/photos/58ebb09d96a2450e5542a889/master/w_2096,h_3000,c_limit/Migos-0517-GQ-FAMI06-01.jpg")),
                            SampleCardModel(title: "Lorde", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/7d/77/24/7d7724330b2fa4e2506be320704c3a21.jpg")),
                            SampleCardModel(title: "OneRepublic", description: "#music", imageURL: URL(string: "https://iscale.iheart.com/v3/url/aHR0cDovL2ltYWdlLmloZWFydC5jb20vaW1hZ2VzL292ZXJyaWRlLzMzMjE0LTIuanBn?surrogate=1cOXl179JY-syhxYSCX6Q1a_Mcu6UO8d-F4oJzpZf1hcUbJr4aImx9MIFVetywNPMAlvx2GuTdkj7Js8clBEzd8RyVb3jc7rA0-ghcxAampl4oLAwpAhfoydg47et3fnJ4sJeViDqCijASYq_GJnymLZd9aiICO0cnRlm5sMH3ASHg8RxxrxlUrrz2s3ndA%3D")),
                            SampleCardModel(title: "Don Toliver", description: "#music", imageURL: URL(string: "https://img.texasmonthly.com/2020/03/don-toliver-houston.jpg?auto=compress&crop=faces&fit=crop&fm=jpg&h=1400&ixlib=php-1.2.1&q=45&w=1400")),
                            SampleCardModel(title: "Kesha", description: "#music", imageURL: URL(string: "https://external-preview.redd.it/A4R4r72kAuFvrNrW6LEtJ-xsI3wVXr2LdunKM-5Bo_8.jpg?auto=webp&s=0f1870ca40580935e0c34f5b317cbb6e632fb76d")),
                            SampleCardModel(title: "Florida Georgia Line", description: "#music", imageURL: URL(string: "https://nashvillelifestyles.com/downloads/25053/download/111318_FGL_10397.jpg?cb=431e8f43f600890c64160c935daadb53&w=1500")),
                            SampleCardModel(title: "Noah Cyrus", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/a2/3f/86/a23f86670e1637e66ebc5da2ee989c72.jpg")),
                            SampleCardModel(title: "AJR", description: "#music", imageURL: URL(string: "https://media.americansongwriter.com/wp-content/uploads/2020/04/07080227/AJR.jpg")),
                            SampleCardModel(title: "Tiësto", description: "#music", imageURL: URL(string: "https://static.independent.co.uk/s3fs-public/thumbnails/image/2018/06/12/12/screen-shot-2018-06-12-at-12.48.25.png?w968h681")),
                            SampleCardModel(title: "JACKBOYS", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/b6/dc/b4/b6dcb423231c760a5214e8da080818cf.jpg")),
                            SampleCardModel(title: "24kGoldn", description: "#music", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/06/24kgoldnrlla.jpg")),
                            SampleCardModel(title: "Cheat Codes", description: "#music", imageURL: URL(string: "https://www.thesun.co.uk/wp-content/uploads/2017/11/2-6-17-cheatcodes11809-copy-web-1.jpg")),
                            SampleCardModel(title: "City Girls", description: "#music", imageURL: URL(string: "https://cultureposters.com/wp-content/uploads/2019/03/city-girls.jpg")),
                            SampleCardModel(title: "Huncho Jack", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/00/8f/37/008f3745f169ecfd5a686741f93fd0b9.jpg")),
                            SampleCardModel(title: "Anuel AA", description: "#music", imageURL: URL(string: "https://bucket.mn2s.com/wp-content/uploads/2018/10/13144919/03-Anuel-AA-p-billboard-1548.jpg")),
                            SampleCardModel(title: "Gunna", description: "#music", imageURL: URL(string: "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fblogs-images.forbes.com%2Fjosephdeacetis%2Ffiles%2F2018%2F12%2Fimage1-2.jpg")),
                            SampleCardModel(title: "Ozuna", description: "#music", imageURL: URL(string: "https://static.billboard.com/files/media/02-ozuna-2019-cr-Juan-Albizu-billboard-1548-1024x677.jpg")),
                            SampleCardModel(title: "Ayo & Teo", description: "#music", imageURL: URL(string: "https://wallpaperaccess.com/full/291291.jpg")),
                            SampleCardModel(title: "Old Dominion", description: "#music", imageURL: URL(string: "https://express-images.franklymedia.com/6616/sites/392/2020/02/12112334/GettyImages-522362150.jpg")),
                            SampleCardModel(title: "Tame Impala", description: "#music", imageURL: URL(string: "https://mediad.publicbroadcasting.net/p/shared/npr/styles/x_large/nprshared/202003/805197792.jpg")),
                            SampleCardModel(title: "Daddy Yankee", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/86/21/8f/86218f8b5033a8f60ef235ae9c8ade36.jpg")),
                            SampleCardModel(title: "Nicky Jam", description: "#music", imageURL: URL(string: "https://i2.wp.com/coogradio.com/wp-content/uploads/2018/10/fdc8299bdaaaa31b-20170526__NICKY_JAM_Shot2_0146_V1G.jpg?fit=1024%2C1536")),
                            SampleCardModel(title: "Jonas Blue", description: "#music", imageURL: URL(string: "https://edm.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:good%2Cw_1200/MTY2MDgxMDE4Nzc0NjkzNTE4/jonas-blue.jpg")),
                            SampleCardModel(title: "Wiz Khalifa", description: "#music", imageURL: URL(string: "https://pbs.twimg.com/media/EB8eNtUUcAEId_R.jpg")),
                            SampleCardModel(title: "BROCKHAMPTON", description: "#music", imageURL: URL(string: "https://66.media.tumblr.com/36d8601d04fabc0f26a5fa29243f6a37/tumblr_p4z9qnBFWK1qc1ct4o3_1280.jpg")),
                            SampleCardModel(title: "KIDS SEE GHOSTS", description: "#music", imageURL: URL(string: "https://www.rollingstone.com/wp-content/uploads/2018/06/gettyimages-509641178-4238df07-a552-4984-9c50-6d9972379d5e.jpg?resize=1800,1200&w=1800")),
                            SampleCardModel(title: "Kehlani", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/60/83/4e/60834e251890433e43859b714cab9584.jpg")),
                            SampleCardModel(title: "Wham!", description: "#music", imageURL: URL(string: "https://wallpapercave.com/wp/wp4296988.jpg")),
                            SampleCardModel(title: "Tay-K", description: "#music", imageURL: URL(string: "https://wallpapercave.com/wp/wp2530870.jpg")),
                            SampleCardModel(title: "Rob $tone", description: "#music", imageURL: URL(string: "https://townsquare.media/site/812/files/2017/01/rob-stone.jpg?w=980&q=75")),
                            SampleCardModel(title: "Brett Young", description: "#music", imageURL: URL(string: "https://www.570news.com/wp-content/blogs.dir/sites/3/2018/09/14/NYET507-88_2018_191525_hd.jpg")),
                            SampleCardModel(title: "Zara Larsson", description: "#music", imageURL: URL(string: "https://cdn2.thelineofbestfit.com/images/made/images/remote/https_cdn2.thelineofbestfit.com/media/2014/zara-larsson-2019_1290_1201.jpg")),
                            SampleCardModel(title: "Jason Aldean", description: "#music", imageURL: URL(string: "https://128dagwixzkuuk9y3guyf7fd-wpengine.netdna-ssl.com/wp-content/uploads/2017/01/web1_k-M-jason-aldean.jpg")),
                            SampleCardModel(title: "Summer Walker", description: "#music", imageURL: URL(string: "https://static.billboard.com/files/media/02-Summer-Walker-press-by-Aiden-Cullen-2019-billboard-1548-compressed.jpg")),
                            SampleCardModel(title: "Starley", description: "#music", imageURL: URL(string: "https://images.ctfassets.net/5615tdzw3m8i/6LFMUxsAZvDP36lNuqo7rh/34d26919ea164281e819ece1fa3159fb/starley-wide-3wx.jpg")),
                            SampleCardModel(title: "Bryce Vine", description: "#music", imageURL: URL(string: "https://radio.rutgers.edu/wp-content/uploads/2018/11/photo-credit-juco-extralarge_1518724641538-1.jpg")),
                            SampleCardModel(title: "Loud Luxury", description: "#music", imageURL: URL(string: "https://edmidentity.com/wp-content/uploads/2020/03/IMG_1896.jpg")),
                            SampleCardModel(title: "Dennis Lloyd", description: "#music", imageURL: URL(string: "https://static.timesofisrael.com/www/uploads/2019/12/AP_19105118547025-e1576876836707.jpg")),
                            SampleCardModel(title: "PARTYNEXTDOOR", description: "#music", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/8/87/PartyNextDoor_2016_press_photo.png")),
                            SampleCardModel(title: "Desiigner", description: "#music", imageURL: URL(string: "https://images.squarespace-cdn.com/content/v1/561468bae4b0b2fafb9e14f5/1512514271324-LV3NCT31G8QPGQAUW9BQ/ke17ZwdGBToddI8pDm48kFWxnDtCdRm2WA9rXcwtIYR7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z5QPOohDIaIeljMHgDF5CVlOqpeNLcJ80NK65_fV7S1UcTSrQkGwCGRqSxozz07hWZrYGYYH8sg4qn8Lpf9k1pYMHPsat2_S1jaQY3SwdyaXg/Desiigner-Highsnobiety-Hyperlinked-Look-2-04.jpg?format=1000w")),
                            SampleCardModel(title: "Lana Del Rey", description: "#music", imageURL: URL(string: "https://dazedimg-dazedgroup.netdna-ssl.com/1080/azure/dazed-prod/1280/8/1288260.jpg")),
                            SampleCardModel(title: "Smokepurpp", description: "#music", imageURL: URL(string: "https://audibletreats.com/wp-content/uploads/2018/12/smokepurpp-from-instagram.jpg")),
                            SampleCardModel(title: "Jon Pardi", description: "#music", imageURL: URL(string: "https://d38trduahtodj3.cloudfront.net/images.ashx?t=ig&rid=GreeleyStampede&i=JP_93A0959_HIres_WEB(4).jpg")),
                            SampleCardModel(title: "GoldLink", description: "#music", imageURL: URL(string: "https://cdn.vor.us/event/358526/og/da8f2e234186415596d5e7fcff9cb2b4.image!jpeg.318126.jpg.goldlink.jpg")),
                            SampleCardModel(title: "MadeinTYO", description: "#music", imageURL: URL(string: "https://image-cdn.hypb.st/https%3A%2F%2Fhypebeast.com%2Fimage%2F2019%2F10%2Fmadeintyo-dj-jehmahk-streetsnaps-style-interview-3-1.jpg?q=75&w=800&cbr=1&fit=max")),
                            SampleCardModel(title: "Jon Bellion", description: "#music", imageURL: URL(string: "https://artist-assets.hubbardradio.com/jonbellion-1_v1000.jpg")),
                            SampleCardModel(title: "YK Osiris", description: "#music", imageURL: URL(string: "https://lastfm.freetls.fastly.net/i/u/ar0/1dd173286c2915f7801c67068da98e89.jpg")),
                            SampleCardModel(title: "Jack Harlow", description: "#music", imageURL: URL(string: "https://www.forecastlefest.com/wp-www-forecastlefest-com/wp/wp-content/uploads/2020/02/jack-harlow-9d9d0594.jpg")),
                            SampleCardModel(title: "Sia", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/13/2d/4d/132d4d27cbfe54611a4667643fbd2a1c.jpg")),
                            SampleCardModel(title: "Maluma", description: "#music", imageURL: URL(string: "https://media.gq.com/photos/5ddc296df9da7100098924ea/master/w_2500,h_3333,c_limit/maluma-gq-men-of-the-year-2019-12.jpg")),
                            SampleCardModel(title: "Dean Martin", description: "#music", imageURL: URL(string: "https://specials-images.forbesimg.com/imageserve/526877172/960x0.jpg?fit=scale")),
                            SampleCardModel(title: "Alec Benjamin", description: "#music", imageURL: URL(string: "https://api.time.com/wp-content/uploads/2019/06/alec-benjamin.jpg")),
                            SampleCardModel(title: "Saweetie", description: "#music", imageURL: URL(string: "https://images.squarespace-cdn.com/content/v1/56c346b607eaa09d9189a870/1550520403544-FO1N6H9PYO2XD6A998VO/ke17ZwdGBToddI8pDm48kNQ0Dds4OaVwXKz4lIliiXZ7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z4YTzHvnKhyp6Da-NYroOW3ZGjoBKy3azqku80C789l0rQeu_A0VlcGJEiWdfSJ_zX7AkVwxbMIAYVxku088aqE12hBAAPy02Op6r73ckLiPQ/FLAUNT-MAGAZINE-SAWEETIE-4.jpg")),
                            SampleCardModel(title: "KAROL G", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/f9/9a/b2/f99ab2b38de253a561ab474ffa83277c.jpg")),
                            SampleCardModel(title: "Rita Ora", description: "#music", imageURL: URL(string: "https://celebmafia.com/wp-content/uploads/2017/10/rita-ora-photoshoot-for-absolut-vodka-2017-2.jpg")),
                            SampleCardModel(title: "Fifth Harmony", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/45/b5/ea/45b5eab127c7a928637c7e8a5a53f194.jpg")),
                            SampleCardModel(title: "Nipsey Hussle", description: "#music", imageURL: URL(string: "https://www.usmagazine.com/wp-content/uploads/2019/09/Nipsey-Hussle-Puma-5.jpg")),
                            SampleCardModel(title: "JP Saxe", description: "#music", imageURL: URL(string: "https://static1.squarespace.com/static/58f7b83a46c3c4be2ebeaa00/t/59d700f1edaed8d460ea961c/1507262710311/JP_Press.jpg?format=1500w")),
                            SampleCardModel(title: "SHAED", description: "#music", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/d/d9/Shaed_03_14_2019_-22_%2846788082374%29.jpg")),
                            SampleCardModel(title: "P!nk", description: "#music", imageURL: URL(string: "https://66.media.tumblr.com/7d5f3f0256d212ddd8fee9c95476be39/tumblr_p0rdvbmrBT1vn1fhlo1_1280.png")),
                            SampleCardModel(title: "YFN Lucci", description: "#music", imageURL: URL(string: "https://i.pinimg.com/originals/f9/8a/bd/f98abd48208073511291a7ad6e63dcb8.jpg")),
                            SampleCardModel(title: "Frank Ocean", description: "#music", imageURL: URL(string: "https://dazedimg-dazedgroup.netdna-ssl.com/1600/azure/dazed-prod/1260/8/1268842.jpg")),
                            SampleCardModel(title: "Lord Huron", description: "#music", imageURL: URL(string: "https://149354818.v2.pressablecdn.com/wp-content/uploads/2018/06/8f5882ef-4197-485b-876c-673599defcfb.jpg")),
                            SampleCardModel(title: "Mabel", description: "#music", imageURL: URL(string: "https://dazedimg-dazedgroup.netdna-ssl.com/2000/azure/dazed-prod/1170/7/1177136.jpg")),
                            SampleCardModel(title: "Lunay", description: "#music", imageURL: URL(string: "https://wallpapercave.com/wp/wp4061947.jpg")),
                            SampleCardModel(title: "Mark Ronson", description: "#music", imageURL: URL(string: "https://si.wsj.net/public/resources/images/B3-DF308_MARK5__1000V_20190220195033.jpg")),
                            SampleCardModel(title: "MAX", description: "#music", imageURL: URL(string: "https://static.billboard.com/files/media/bb25-2017-hot100-MAX-cr-Courtesy-of-Crush-Music-billboard-1548-compressed.jpg")),
                            SampleCardModel(title: "Surfaces", description: "#music", imageURL: URL(string: "https://images.squarespace-cdn.com/content/5cae457151f4d4fb6d1c8a2a/1557791944925-BDFLR6V2J9UV8QTUHQI6/IMG_0596.JPG?format=1500w&content-type=image%2Fjpeg")),
                            SampleCardModel(title: "Maren Morris", description: "#music", imageURL: URL(string: "https://www.fayettevilleflyer.com/wp-content/uploads/2020/02/marenmorris.jpg")),
                            SampleCardModel(title: "TOKYO’S REVENGE", description: "#music", imageURL: URL(string: "https://pbs.twimg.com/media/EO-oWZIVUAA3Laf.jpg")),
                            SampleCardModel(title: "Hugh Jackman", description: "#music", imageURL: URL(string: "https://cdn.asiatatler.com/asiatatler/i/hk/2019/05/05175107-montblanc-hugh-jackman-4_cover_1335x2000.jpg")),
                            SampleCardModel(title: "Louis Tomlinson", description: "#music", imageURL: URL(string: "https://www.thesun.co.uk/wp-content/uploads/2020/01/NINTCHDBPICT000556913256.jpg")),
                            SampleCardModel(title: "BaKeem", description: "#music", imageURL: URL(string: "https://66.media.tumblr.com/0fc124b5974ccceab6fc4d39e0d757b4/tumblr_nm8l1qmzG11qasnrqo1_1280.jpg")),
                            SampleCardModel(title: "Zac Efron", description: "#music", imageURL: URL(string: "https://pbs.twimg.com/media/C5LMHZrWAAQzU3O.jpg")),
                            SampleCardModel(title: "Ant Saunders", description: "#music", imageURL: URL(string: "https://www.euphoriazine.com/wp-content/uploads/2020/01/Ant-Saunders-Press-Photo-3-Credit_-Khufu-Najee.jpg")),
                            SampleCardModel(title: "Cashmere Cat", description: "#music", imageURL: URL(string: "https://pbs.twimg.com/media/DVeTfSWUQAABSrg.jpg")),
                            SampleCardModel(title: "Dustin Lynch", description: "#music", imageURL: URL(string: "https://www.soundslikenashville.com/wp-content/uploads/2020/01/Dustin-Lynch-cover-1580142276.jpg")),
                            SampleCardModel(title: "N.E.R.D", description: "#music", imageURL: URL(string: "https://www.nme.com/wp-content/uploads/2016/09/11NERD01PMVH061113-696x464.jpg")),
                            SampleCardModel(title: "Jhay Cortez", description: "#music", imageURL: URL(string: "https://i.pinimg.com/736x/f4/fc/71/f4fc71c01480d18d144c52085ad615e7.jpg")),
                            SampleCardModel(title: "Idina Menzel", description: "#music", imageURL: URL(string: "https://www.geffenplayhouse.org/site/assets/files/21220/idinamenzel-1000x1400.jpg")),
                            SampleCardModel(title: "Maggie Lindemann", description: "#music", imageURL: URL(string: "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fblogs-images.forbes.com%2Fhughmcintyre%2Ffiles%2F2017%2F03%2FMAGGIE-L-300-RECORDS_-6-1200x958.jpg")),
                            SampleCardModel(title: "Steve Aoki", description: "#music", imageURL: URL(string: "https://static.independent.co.uk/s3fs-public/thumbnails/image/2018/02/09/12/steve-denim-2-clean-preview.jpeg")),
                            SampleCardModel(title: "Joyner Lucas", description: "#music", imageURL: URL(string: "https://www.washingtonpost.com/resizer/Syfg6JqvIiEQ5ZfeqfnCzS0PIXs=/1440x0/smart/arc-anglerfish-washpost-prod-washpost.s3.amazonaws.com/public/EQJ6Y2DI2AI6RP4M7HWS4ZZK34.jpg")),
                            SampleCardModel(title: "Blanco Brown", description: "#music", imageURL: URL(string: "https://www.blancobrown.com/app/uploads/2019/06/KAV_7931.jpg")),
                            SampleCardModel(title: "Conan Gray", description: "#music", imageURL: URL(string: "https://assets.rebelmouse.io/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpbWFnZSI6Imh0dHBzOi8vYXNzZXRzLnJibC5tcy8xOTM0Nzc2MC9vcmlnaW4uanBnIiwiZXhwaXJlc19hdCI6MTYwODUzODg1NX0.xRyEFuqcJEjdJ-JTLVWndAOHJMuD2KfoISOVRbVZu6I/img.jpg?width=980")),
                            SampleCardModel(title: "Rudimental", description: "#music", imageURL: URL(string: "https://s3.amazonaws.com/files.madeinkatana.com/warners/uploads/5b0bac9793881.jpg")),
                            SampleCardModel(title: "Keala Settle", description: "#music", imageURL: URL(string: "https://s3.amazonaws.com/sfc-datebook-wordpress/wp-content/uploads/sites/2/2020/02/MER74cd021694d45bc0ca9e2f97f1cad_popquiz0308_settle-1024x739.jpg"))]
    
    
    //MARK: - Get Cards
    
    func getCards(completion: @escaping (_ interestIDArray : [String]?) -> Void){
        
        self.maxInterestID { (maximumID) in
            guard let maxID = maximumID else { completion(nil); return }
            guard let maxIDNumber = Int(maxID) else { completion(nil); return }
            
            let iArrayNumber = Array(1...maxIDNumber)
            var iArray = iArrayNumber.map { String($0) }
            
            guard LoginManager.shared.isLoggedIn() else { completion(iArray); return }
            
            self.getMyUser { (myUser) in
                
                guard let myU = myUser else { completion(iArray); return}
                
                iArray = iArray.filter({!myU.interests.contains($0)})
                iArray = iArray.filter({!myU.interestsSeen.contains($0)})
                completion(iArray)
                return
                
            }
            
        }

    }
    
    
    func getMyUser(completion: @escaping (_ myUser : MyUser?) -> Void) {
        
        guard let myUID = Auth.auth().currentUser?.uid else { completion(nil); return }
        
        db.collection("User-Profile").document(myUID).getDocument { (snap, err) in
            guard let doc = snap else { completion(nil); return }
            
            if let email = doc.data()?["email"] as? String,
                let name = doc.data()?["name"] as? String,
                let description = doc.data()?["description"] as? String,
                let imageURL = doc.data()?["imageURL"] as? String,
                let dateJoined = doc.data()?["dateJoined"] as? Timestamp,
                let classYear = doc.data()?["classYear"] as? Int {
                
                let interests = doc.data()?["interests"] as? [String] ?? []
                let interestsSeen = doc.data()?["interestsSeen"] as? [String] ?? []
                
                let myUser = MyUser(userID: myUID, email: email, name: name, description: description, imageURL: imageURL, interests: interests, interestsSeen: interestsSeen, dateJoined: dateJoined, classYear: classYear)
                completion(myUser)
                return
            }
        }
        
    }
    
    func maxInterestID(completion: @escaping (_ maxInterestID : String?) -> Void) {
        
        db.collection("Interest-Profile").limit(to: 1).order(by: "id", descending: true).getDocuments { (snap, err) in
            guard let doc = snap?.documents.first else { completion(nil); return }
            
            completion(doc.documentID)
            return
        }
        
    }
    
    
    
    
    
    // MARK :- Sending Swipes
    
    func swipedLeft(interestID : String) {
        
        guard let myUID = Auth.auth().currentUser?.uid else { return }
        
        let batch = db.batch()
        
        let ref1 = db.collection("User-Profile").document(myUID)
        let payload1 = ["interestsSeen":FieldValue.arrayUnion([interestID]),
//                        "interests":FieldValue.arrayRemove([interestID]),
            ] as [String:Any]
        batch.updateData(payload1, forDocument: ref1)
        
//        let ref2 = db.collection("Interest-Profile").document(interestID)
//        let payload2 = ["likedBy":FieldValue.arrayRemove([myUID])] as [String:Any]
//        batch.updateData(payload2, forDocument: ref2)
        
        batch.commit()
        
        
    }
    
    func swipedRight(interestID : String) {
        
        guard let myUID = Auth.auth().currentUser?.uid else { return }
        
        let batch = db.batch()
        
        let ref1 = db.collection("User-Profile").document(myUID)
        let payload1 = ["interests":FieldValue.arrayUnion([interestID]),
//                        "interestsSeen":FieldValue.arrayRemove([interestID]),
            ] as [String:Any]
        batch.updateData(payload1, forDocument: ref1)
        
        let ref2 = db.collection("Interest-Profile").document(interestID)
        let payload2 = ["likedBy":FieldValue.arrayUnion([myUID])] as [String:Any]
        batch.updateData(payload2, forDocument: ref2)
        
        batch.commit()
        
    }
    
    
    
    
    
    //MARK: - GET INTEREST
    
    func getInterest(interestID : String, completion: @escaping (_ interest : Interest?) -> Void) {
        
        db.collection("Interest-Profile").document(interestID).getDocument { (snap, err) in
            guard let doc = snap else { completion(nil); return }
            
            if let name = doc.data()?["name"] as? String, let description = doc.data()?["description"] as? String, let imageURL = doc.data()?["imageURL"] as? String {
                
                let likedBy = doc.data()?["likedBy"] as? [String] ?? []
                
                let interest = Interest(interestID: interestID, name: name, description: description, imageURL: imageURL, likedBy: likedBy)
                completion(interest)
                return
                
            }
        }
        
    }
    
    
}
