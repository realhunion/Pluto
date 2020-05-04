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
        self.runIt()
    }
    
    func printDate(string: String) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSSS"
        print(string + formatter.string(from: date))
    }
    
    func runIt() {
        
        self.view.backgroundColor = UIColor.init(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1.0)
        
        var payload : [SampleCardModel] = []
        
        var spot = Constant.spotify600
        var retro = Constant.retro200
        var gen = Constant.gen200
        
        payload.append(retro.remove(at: 15))
        payload.append(spot.remove(at: 0))
        payload.append(gen.remove(at: 80))
        payload.append(spot.remove(at: 277))
        payload.append(spot.remove(at: 6))
        
        
        while(!spot.isEmpty || !retro.isEmpty || !gen.isEmpty) {
            let random = Int.random(in: 1...4)
            if random == 1 || random == 2 {
                if let element = spot.randomElement() {
                    payload.append(element)
                    spot.removeAll(where: {$0.title == element.title})
                }
                
            }
            else if random == 3 {
                if let element = retro.randomElement() {
                    payload.append(element)
                    retro.removeAll(where: {$0.title == element.title})
                }
            }
            else if random == 4 {
                if let element = gen.randomElement() {
                    payload.append(element)
                    gen.removeAll(where: {$0.title == element.title})
                }
            }
        }
        
        print("Pd count \(payload.count) - \(spot.count)- \(retro.count)- \(gen.count)")
        for i in 0...10 {
            print("pd \(payload[i].title)")
        }
//        return

        let db = Firestore.firestore()
        let batch1 = db.batch()
        let batch2 = db.batch()
        var id : Int = 1
//        for item in payload {
//
//            let ref = db.collection("Interest-Profile").document("\(id)")
//
//            if id%2==0 {
//                batch1.setData(["id":"\(id)","name":item.title, "description":item.description, "imageURL":item.imageURL?.absoluteString], forDocument: ref)
//            } else {
//                batch2.setData(["id":"\(id)","name":item.title, "description":item.description, "imageURL":item.imageURL?.absoluteString], forDocument: ref)
//            }
//            id+=1
//        }
        for index in 1...750 {
            let ref = db.collection("Interest-Profile").document("\(index)")
            if index%2==0 {
                batch1.setData(["id":Int(index)], forDocument: ref, merge: true)
            } else {
                batch2.setData(["id":Int(index)], forDocument: ref, merge: true)
            }
        }
        
        print("pd lastID \(id)")
        
        batch1.commit { (err) in
            print("pd batch1 done// \(err)")
            batch2.commit { (err) in
                print("pd batch2 done// \(err)")
            }
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
