//
//  ConnectionVC.swift
//  Pluto
//
//  Created by Hunain Ali on 4/23/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class ConnectionVC : UITableViewController {
    
    
    var connection : Connection!
    
    var sharedInterestArray : [Interest] = []
    
    override init(style: UITableView.Style) {
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
        self.setupFetcher()
        
        self.tableView.register(AccessoryTableViewCell.classForCoder(), forCellReuseIdentifier: "connectionCell")
    }
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Users"
        }
        else if section == 1 {
            return "\(self.connection.sharedInterests.count) Mutual Artists"
        }
        else {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        else if section == 1 {
            return self.sharedInterestArray.count
        }
        else {
            return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.imageView?.sd_cancelCurrentImageLoad()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "connectionCell", for: indexPath)
        
        cell.textLabel?.numberOfLines = 99
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                let transformer = SDImageResizingTransformer(size: CGSize(width: 100, height: 100), scaleMode: .aspectFill)
                cell.imageView?.sd_setImage(with: URL(string: self.connection.userA.imageURL), placeholderImage: UIImage(named: "travisScott")?.resizedImage(newSize: CGSize(width: 40.0, height: 40.0)), options: [.scaleDownLargeImages], context: [.imageTransformer: transformer], progress: nil, completed: { (image, err, cacheType, url) in
                    cell.imageView?.image = cell.imageView?.image?.resizedImage(newSize: CGSize(width: 40.0, height: 40.0))
                    cell.imageView?.layer.masksToBounds = true
                    cell.imageView?.layer.cornerRadius = 10
                })
                cell.textLabel?.text = self.connection.userA.name
            }
            if indexPath.row == 1 {
                let transformer = SDImageResizingTransformer(size: CGSize(width: 100, height: 100), scaleMode: .aspectFill)
                cell.imageView?.sd_setImage(with: URL(string: self.connection.userB.imageURL), placeholderImage: UIImage(named: "travisScott")?.resizedImage(newSize: CGSize(width: 40.0, height: 40.0)), options: [.scaleDownLargeImages], context: [.imageTransformer: transformer], progress: nil, completed: { (image, err, cacheType, url) in
                    cell.imageView?.image = cell.imageView?.image?.resizedImage(newSize: CGSize(width: 40.0, height: 40.0))
                    cell.imageView?.layer.masksToBounds = true
                    cell.imageView?.layer.cornerRadius = 10
                })
                cell.textLabel?.text = self.connection.userB.name
            }
            
        }
        
        if indexPath.section == 1 {
            
            let i = self.sharedInterestArray[indexPath.row]
            
            let transformer = SDImageResizingTransformer(size: CGSize(width: 100, height: 100), scaleMode: .aspectFill)
            cell.imageView?.sd_setImage(with: URL(string: i.imageURL), placeholderImage: UIImage(named: "travisScott")?.resizedImage(newSize: CGSize(width: 40.0, height: 40.0)), options: [.scaleDownLargeImages], context: [.imageTransformer: transformer], progress: nil, completed: { (image, err, cacheType, url) in
                cell.imageView?.image = cell.imageView?.image?.resizedImage(newSize: CGSize(width: 40.0, height: 40.0))
                cell.imageView?.layer.masksToBounds = true
                cell.imageView?.layer.cornerRadius = 10
            })
            cell.textLabel?.text = i.name
            
        }
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let vc = UserProfileVC(style: .insetGrouped)
                vc.userID = self.connection.userA.userID
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 1 {
                let vc = UserProfileVC(style: .insetGrouped)
                vc.userID = self.connection.userB.userID
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        if indexPath.section == 1 {
            let i = self.sharedInterestArray[indexPath.row]
            let vc = InterestProfileVC(style: .insetGrouped)
            vc.interestID = i.interestID
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    
    
}
