//
//  MyProfileVC.swift
//  Pluto
//
//  Created by Hunain Ali on 4/23/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class MyProfileVC: UITableViewController {
    
    override init(style: UITableView.Style) {
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var myProfileFetcher : MyUserProfileFetcher?
    var myUser : UserProfile?
    
    var connectionArray : [Connection] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .never
        
        self.setupBarButton()
        self.setupSegmentControl()
        
        self.setupMyProfileFetcher()
//        self.fetchConnections()
        
        self.tableView.register(AccessoryTableViewCell.classForCoder(), forCellReuseIdentifier: "myProfileCell")
    }
    
    
    func shutDown() {
        self.dismiss(animated: false, completion: nil)
        
        self.myProfileFetcher?.shutDown()
        self.myProfileFetcher = nil
        self.myUser = nil
        
        self.tableView.reloadData()
        
    }
    
    
    //MARK: - Setup
    
    
    func setupBarButton() {
        let btn = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(settingsButtonTapped))
        self.navigationItem.setRightBarButtonItems([btn], animated: true)
    }
    
    @objc func settingsButtonTapped() {
        let vc = SettingsVC(style: .insetGrouped)
        vc.title = "Settings"
        let nvc = UINavigationController(rootViewController: vc)
        nvc.modalPresentationStyle = .pageSheet
        self.present(nvc, animated: true, completion: nil)
        
    }
    
    
    
    //MARK: - Table view header
    
    
    var segmentControl : UISegmentedControl = UISegmentedControl()
    
    func setupSegmentControl() {
        self.segmentControl.frame = CGRect.zero
        
        self.segmentControl.insertSegment(withTitle: "Artists", at: 0, animated: false)
        self.segmentControl.insertSegment(withTitle: "Connections", at: 1, animated: false)
        self.segmentControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .subheadline).pointSize, weight: .medium)], for: .normal)
        
        self.segmentControl.selectedSegmentIndex = 1
        
        self.segmentControl.addTarget(self, action: #selector(self.segmentIndexChanged(_:)), for: .valueChanged)
    }
    
    @objc func segmentIndexChanged(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 30.0
        } else if section == 1 {
            return 65.0
        } else {
            return 0.0
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        guard section == 1 else { return nil }
        
        let containerView = UIView()
        containerView.backgroundColor = .systemGroupedBackground
        containerView.addSubview(self.segmentControl)
        
        self.segmentControl.set(.height, of: 45)
        self.segmentControl.layoutToSuperview(.left, offset: 0)
        self.segmentControl.layoutToSuperview(.right, offset: 0)
        self.segmentControl.layoutToSuperview(.bottom, offset: -10)
        
        return containerView
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let myU = self.myUser else { return 0 }
        if section == 0 {
            return 3
        } else {
            if self.segmentControl.selectedSegmentIndex == 0 {
                return myU.interests.count
            }
            else if self.segmentControl.selectedSegmentIndex == 1 {
                return connectionArray.count
            }
            else { return 0 }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.imageView?.sd_cancelCurrentImageLoad()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myProfileCell", for: indexPath)
        
        guard let myU = self.myUser else { return cell }
        
        cell.textLabel?.numberOfLines = 99
        cell.imageView?.image = nil
        cell.detailTextLabel?.text = nil
        cell.textLabel?.text = nil
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                cell.imageView?.center = cell.center
                let transformer = SDImageResizingTransformer(size: CGSize(width: 200, height: 200), scaleMode: .aspectFill)
                cell.imageView?.sd_setImage(with: URL(string: myU.imageURL), placeholderImage: UIImage(named: "travisScott")?.resizedImage(newSize: CGSize(width:  100.0, height: 100.0)), options: [.scaleDownLargeImages], context: [.imageTransformer: transformer], progress: nil, completed: { (image, err, cacheType, url) in
                    cell.imageView?.image = cell.imageView?.image?.resizedImage(newSize: CGSize(width: 100.0, height: 100.0))
                    cell.imageView?.layer.masksToBounds = true
                    cell.imageView?.layer.cornerRadius = 10
                })
                cell.imageView?.layer.cornerRadius = 12.0
                cell.imageView?.layer.masksToBounds = true
                
                cell.detailTextLabel?.text = "Edit"
            }
            if indexPath.row == 1 {
                cell.textLabel?.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
                cell.textLabel?.text = myU.name
                cell.textLabel?.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .title2).pointSize, weight: .bold)
                cell.textLabel?.textColor = .label
                
                cell.detailTextLabel?.text = "Edit"
            }
            if indexPath.row == 2 {
                cell.textLabel?.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize, weight: .regular)
                cell.textLabel?.textColor = UIColor.label
                cell.textLabel?.text = myU.description
                cell.textLabel?.numberOfLines = 3
                
                cell.detailTextLabel?.text = "Edit"
            }
            
            cell.selectionStyle = .none
        } else {
            
            cell.textLabel?.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize, weight: .regular)
            
            if self.segmentControl.selectedSegmentIndex == 0 {
                let i = myU.interests[indexPath.row]
                
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
        }
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let myU = self.myUser else { return }
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                self.editImageTapped()
            }
            if indexPath.row == 1 {
                self.editNameTapped()
            }
            if indexPath.row == 2 {
                self.editDescriptionTapped()
            }
            
        }
        if indexPath.section == 1 {
            if self.segmentControl.selectedSegmentIndex == 0 {
                let i = myU.interests[indexPath.row]
                let vc = InterestProfileVC(style: .grouped)
                vc.interestID = i.interestID
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
    
    
}
