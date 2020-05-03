//
//  UserProfileVC.swift
//  Pluto
//
//  Created by Hunain Ali on 4/19/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import UIKit
import QuickLayout
import SDWebImage

class UserProfileVC: UITableViewController {
    
    var userInterestsFetcher : InterestsFetcher?
    
    var user : User!
    
    var interestArray : [Interest] = []
    var connectionArray : [Connection] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = user.email
        
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .never
        
        self.setupHeaderProfile()
        
        self.setupSegmentControl()
        
        self.setupUserInterestFetcher()
        self.setupConnectionFetcher()
        
        self.tableView.register(AccessoryTableViewCell.classForCoder(), forCellReuseIdentifier: "userProfileCell")
    }
    
    func setupHeaderProfile() {
        
        let v = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 300))
        v.backgroundColor = .systemGroupedBackground
        
        let userImageView = UIImageView()
        userImageView.backgroundColor = UIColor.green.withAlphaComponent(0.8)
        userImageView.sd_setImage(with: URL(string: self.user.imageURL), completed: nil)
        userImageView.clipsToBounds = true
        userImageView.contentMode = .scaleAspectFill
        userImageView.layer.masksToBounds = true
        userImageView.layer.cornerRadius = 16.0
        userImageView.backgroundColor = .systemBackground
        v.addSubview(userImageView)
        
        let nameLabel = UILabel()
        nameLabel.text = self.user.name
        nameLabel.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
        nameLabel.textAlignment = .center
        v.addSubview(nameLabel)
        
        let descripLabel = UILabel()
        if user.classYear == 1 { descripLabel.text = "1st Year · \(self.user.description)" }
        else if user.classYear == 2 { descripLabel.text = "2nd Year · \(self.user.description)" }
        else if user.classYear == 3 { descripLabel.text = "3rd Year · \(self.user.description)" }
        else if user.classYear == 4 { descripLabel.text = "4th Year · \(self.user.description)" }
        else { descripLabel.text = self.user.description }
        descripLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        descripLabel.textAlignment = .center
        descripLabel.numberOfLines = 2
        v.addSubview(descripLabel)
        
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        userImageView.layoutToSuperview(.centerX)
        userImageView.layoutToSuperview(.top, offset: 20)
        userImageView.widthAnchor.constraint(equalTo: userImageView.heightAnchor, multiplier: 1.0).isActive = true
        
        nameLabel.set(.height, of: 40.0)
        nameLabel.layout(.top, to: .bottom, of: userImageView, offset: 10)
        nameLabel.layoutToSuperview(.left, offset: 30)
        nameLabel.layoutToSuperview(.right, offset: -30)
        
        descripLabel.set(.height, of: 40.0)
        descripLabel.layout(.top, to: .bottom, of: nameLabel, offset: 0)
        descripLabel.layoutToSuperview(.bottom, offset: -20)
        descripLabel.layoutToSuperview(.left, offset: 30)
        descripLabel.layoutToSuperview(.right, offset: -30)
        
        
        self.tableView.tableHeaderView = v
        
    }
    
    
    //MARK: - Table view segment
    
    var segmentControl : UISegmentedControl = UISegmentedControl()
    
    func setupSegmentControl() {
        self.segmentControl.frame = CGRect.zero
        
        self.segmentControl.insertSegment(withTitle: "Artists", at: 0, animated: false)
        self.segmentControl.insertSegment(withTitle: "Connections", at: 1, animated: false)
        self.segmentControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .subheadline).pointSize, weight: .medium)], for: .normal)
        
        self.segmentControl.selectedSegmentIndex = 0
        
        self.segmentControl.addTarget(self, action: #selector(self.segmentIndexChanged(_:)), for: .valueChanged)
    }
    
    @objc func segmentIndexChanged(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let containerView = UIView()
        containerView.backgroundColor = .systemGroupedBackground
        containerView.addSubview(self.segmentControl)
        
        self.segmentControl.layoutToSuperview(.top, offset: 0)
        self.segmentControl.layoutToSuperview(.left, offset: 0)
        self.segmentControl.layoutToSuperview(.right, offset: 0)
        self.segmentControl.layoutToSuperview(.bottom, offset: -10)
        
        return containerView
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.segmentControl.selectedSegmentIndex == 0 {
            return interestArray.count
        }
        else if self.segmentControl.selectedSegmentIndex == 1 {
            return connectionArray.count
        }
        else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.imageView?.sd_cancelCurrentImageLoad()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userProfileCell", for: indexPath)
        
        cell.textLabel?.numberOfLines = 99
        
        if self.segmentControl.selectedSegmentIndex == 0 {
            let i = self.interestArray[indexPath.row]
            
            let transformer = SDImageResizingTransformer(size: CGSize(width: 100, height: 100), scaleMode: .aspectFill)
            cell.imageView?.sd_setImage(with: URL(string: i.imageURL), placeholderImage: UIImage(named: "travisScott")?.resizedImage(newSize: CGSize(width: 40.0, height: 40.0)), options: [.scaleDownLargeImages], context: [.imageTransformer: transformer], progress: nil, completed: { (image, err, cacheType, url) in
                guard let img = image else { return }
                cell.imageView?.image = cell.imageView?.image?.resizedImage(newSize: CGSize(width: 40.0, height: 40.0))
                cell.imageView?.layer.masksToBounds = true
                cell.imageView?.layer.cornerRadius = 10
            })
            
            cell.textLabel?.text = i.name
            cell.detailTextLabel?.text = nil
            
        }
        else if self.segmentControl.selectedSegmentIndex == 1 {
            let c = connectionArray[indexPath.row]
            
            let transformer = SDImageResizingTransformer(size: CGSize(width: 100, height: 100), scaleMode: .aspectFill)
            cell.imageView?.sd_setImage(with: URL(string: c.userB.imageURL), placeholderImage: UIImage(named: "travisScott")?.resizedImage(newSize: CGSize(width: 40.0, height: 40.0)), options: [.scaleDownLargeImages], context: [.imageTransformer: transformer], progress: nil, completed: { (image, err, cacheType, url) in
                guard let img = image else { return }
                cell.imageView?.image = cell.imageView?.image?.resizedImage(newSize: CGSize(width: 40.0, height: 40.0))
                cell.imageView?.layer.masksToBounds = true
                cell.imageView?.layer.cornerRadius = 10
            })
            
            cell.textLabel?.text = c.userB.name
            cell.detailTextLabel?.text = "\(c.sharedInterests.count)"
        
        }
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.segmentControl.selectedSegmentIndex == 0 {
            let i = self.interestArray[indexPath.row]
            let vc = InterestProfileVC(style: .grouped)
            vc.interest = i
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        if self.segmentControl.selectedSegmentIndex == 1 {
            let c = self.connectionArray[indexPath.row]
            let vc = ConnectionVC(style: .insetGrouped)
            vc.connection = c
            vc.title = "Connection"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
