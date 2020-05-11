//
//  DirectoryTVC.swift
//  Pluto
//
//  Created by Hunain Ali on 4/18/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class DirectoryVC: UITableViewController {
    
    var myUserFetcher : MyUserFetcher?
    
    var userArray : [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupRefreshControl()
        
        self.setupFetcher()
        
        self.tableView.register(SubtitleTableViewCell.classForCoder(), forCellReuseIdentifier: "directoryCell")
    }
    
    func shutDown() {
        self.dismiss(animated: false, completion: nil)
        self.navigationController?.popToRootViewController(animated: false)
        
        self.myUserFetcher?.shutDown()
        self.myUserFetcher = nil
        
        self.userArray = []
        self.tableView.reloadData()
        
    }
    
    
    //MARK: - Setup
    
    var spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    func setupSpinner() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: spinner)
        spinner.isHidden = false
        self.spinner.startAnimating()
    }
    
    
    func setupRefreshControl() {
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action:  #selector(didRefreshControl), for: .valueChanged)
        
    }
    
    
    
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userArray.count
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.imageView?.sd_cancelCurrentImageLoad()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "directoryCell", for: indexPath)
        
        guard let myUID = Auth.auth().currentUser?.uid else { return cell }
        
        cell.textLabel?.numberOfLines = 99
        
        let u = self.userArray[indexPath.row]
        
        let transformer = SDImageResizingTransformer(size: CGSize(width: 100, height: 100), scaleMode: .aspectFill)
        cell.imageView?.sd_setImage(with: URL(string: u.imageURL), placeholderImage: UIImage(named: "travisScott")?.resizedImage(newSize: CGSize(width: 50.0, height: 50.0)), options: [], context: [.imageTransformer: transformer], progress: nil, completed: { (image, err, cacheType, url) in
            cell.imageView?.image = cell.imageView?.image?.resizedImage(newSize: CGSize(width: 50.0, height: 50.0))
            cell.imageView?.layer.masksToBounds = true
            cell.imageView?.layer.cornerRadius = 10
        })
        
        
        cell.textLabel?.text = u.name
        
        if u.userID == myUID {
            cell.detailTextLabel?.text = "\(u.interests.count) artists"
        } else {
            cell.detailTextLabel?.text = "\(u.interests.count) artists · \(self.getMutualArtists(for: u)) mutual"
        }
        
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let u = self.userArray[indexPath.row]
        let vc = UserProfileVC(style: .insetGrouped)
        vc.userID = u.userID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
