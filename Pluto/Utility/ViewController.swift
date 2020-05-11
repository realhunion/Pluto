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
        self.view.backgroundColor = UIColor.systemPurple
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
//        self.runIt()
    }
    
    func printDate(string: String) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSSS"
        print(string + formatter.string(from: date))
    }
    
//    func runIt() {
//
//        self.view.backgroundColor = UIColor.init(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1.0)
//
//        var payload : [SampleCardModel] = []
//
//        var spot = Constant.spotify600
//        var retro = Constant.retro200
//        var gen = Constant.gen200
//
//        var spotTop50 = spot[0..<50]
//        var spotRest = spot[50..<spot.count]
//        var retroTop50 = retro[0..<50]
//        var retroRest = retro[50..<retro.count]
//        var genTop40 = gen[0..<40]
//        var genRest = gen[40..<gen.count]
//
//        payload.append(retroTop50.remove(at: 15))
//        payload.append(spotRest.remove(at: 278))
//        payload.append(genRest.remove(at: 80))
//        payload.append(spotTop50.remove(at: 3))
//        payload.append(retroTop50.remove(at: 48))
//
//        while(!spotTop50.isEmpty || !spotRest.isEmpty || !retroTop50.isEmpty || !retroRest.isEmpty || !genTop40.isEmpty || !genRest.isEmpty) {
//            let random = Int.random(in: 1...5)
//            if random == 1 || random == 2 {
//                if let element = spotRest.randomElement() {
//                    payload.append(element)
//                    spotRest.removeAll(where: {$0.title == element.title})
//                }
//
//            }
//            if random == 3 {
//                if let element = retroRest.randomElement() {
//                    payload.append(element)
//                    retroRest.removeAll(where: {$0.title == element.title})
//                }
//
//            }
//            if random == 4 {
//                if let element = genRest.randomElement() {
//                    payload.append(element)
//                    genRest.removeAll(where: {$0.title == element.title})
//                }
//
//            }
//
//            if random == 5 {
//                let random2 = Int.random(in: 1...3)
//                if random2 == 1 {
//                    if let element = spotTop50.randomElement() {
//                        payload.append(element)
//                        spotTop50.removeAll(where: {$0.title == element.title})
//                    }
//                }
//                if random2 == 2 {
//                    if let element = retroTop50.randomElement() {
//                        payload.append(element)
//                        retroTop50.removeAll(where: {$0.title == element.title})
//                    }
//                }
//                if random2 == 3 {
//                    if let element = genTop40.randomElement() {
//                        payload.append(element)
//                        genTop40.removeAll(where: {$0.title == element.title})
//                    }
//                }
//
//            }
//        }
//
//
//
//
//
//
////        payload.append(retro.remove(at: 15))
////        payload.append(spot.remove(at: 0))
////        payload.append(gen.remove(at: 80))
////        payload.append(spot.remove(at: 277))
////        payload.append(spot.remove(at: 6))
////
//
////        while(!spot.isEmpty || !retro.isEmpty || !gen.isEmpty) {
////            let random = Int.random(in: 1...4)
////            if random == 1 || random == 2 {
////                if let element = spot.randomElement() {
////                    payload.append(element)
////                    spot.removeAll(where: {$0.title == element.title})
////                }
////
////            }
////            else if random == 3 {
////                if let element = retro.randomElement() {
////                    payload.append(element)
////                    retro.removeAll(where: {$0.title == element.title})
////                }
////            }
////            else if random == 4 {
////                if let element = gen.randomElement() {
////                    payload.append(element)
////                    gen.removeAll(where: {$0.title == element.title})
////                }
////            }
////        }
//
//        print("Pd count \(payload.count) - \(spotTop50.count)- \(spotRest.count)- \(retroTop50.count)")
//        for i in 0...20 {
//            print("pd \(payload[i].title)")
//        }
////        return
//
//        let db = Firestore.firestore()
//        let batch1 = db.batch()
//        let batch2 = db.batch()
//        var id : Int = 1
//        for item in payload {
//
//            let ref = db.collection("Interest-Profile").document("\(id)")
//            //
//            if id%2==0 {
//                batch1.setData(["id":id,"name":item.title, "description":item.description, "imageURL":item.imageURL?.absoluteString], forDocument: ref)
//            } else {
//                batch2.setData(["id":id,"name":item.title, "description":item.description, "imageURL":item.imageURL?.absoluteString], forDocument: ref)
//            }
//
//            id+=1
//        }
//
//
//            print("pd lastID \(id)")
//
//            batch1.commit { (err) in
//                print("pd batch1 done// \(err)")
//                batch2.commit { (err) in
//                    print("pd batch2 done// \(err)")
//                }
//            }
//
//
//    }


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
