//
//  InterestProfileTVC.swift
//  Pluto
//
//  Created by Hunain Ali on 4/19/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import UIKit
import SDWebImage

class InterestProfileVC: UITableViewController {
    
    deinit {
        print("inProf de init")
    }
    
    override init(style: UITableView.Style) {
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var interest : Interest!
    
    var interestUsersFetcher : UsersFetcher?
    
    var userArray : [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .never
        
        self.setupFetcher()
        
        self.setupHeaderProfile()
        
        self.tableView.register(SubtitleTableViewCell.classForCoder(), forCellReuseIdentifier: "interestProfileCell")
    }
    
    func setupFetcher() {
        self.interestUsersFetcher = UsersFetcher(userIDArray: self.interest.likedBy)
        self.interestUsersFetcher?.delegate = self
        self.interestUsersFetcher?.fetchInterestProfile()
    }
    
    
    
    //MARK: - Header
    
    func setupHeaderProfile() {
        
        let v = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 300))
        v.backgroundColor = .systemGroupedBackground
        
        let userImageView = UIImageView()
        userImageView.backgroundColor = UIColor.green.withAlphaComponent(0.8)
        userImageView.sd_setImage(with: URL(string: self.interest.imageURL), completed: nil)
        userImageView.clipsToBounds = true
        userImageView.contentMode = .scaleAspectFit
        userImageView.layer.masksToBounds = true
        userImageView.layer.cornerRadius = 16.0
        userImageView.backgroundColor = .systemGroupedBackground
        v.addSubview(userImageView)
        
        let nameLabel = UILabel()
        nameLabel.text = self.interest.name
        nameLabel.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
        nameLabel.textAlignment = .center
        v.addSubview(nameLabel)
        
        let descripLabel = UILabel()
        descripLabel.text = "\(self.interest.likedBy.count) Members"
        descripLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        descripLabel.textAlignment = .center
        descripLabel.numberOfLines = 1
        v.addSubview(descripLabel)
        
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        userImageView.layoutToSuperview(.centerX)
        userImageView.layoutToSuperview(.top, offset: 20)
        
        nameLabel.set(.height, of: 40.0)
        nameLabel.layout(.top, to: .bottom, of: userImageView, offset: 10)
        nameLabel.layoutToSuperview(.left, offset: 30)
        nameLabel.layoutToSuperview(.right, offset: -30)
        
        descripLabel.set(.height, of: 20.0)
        descripLabel.layout(.top, to: .bottom, of: nameLabel, offset: 0)
        descripLabel.layoutToSuperview(.bottom, offset: 0)
        descripLabel.layoutToSuperview(.left, offset: 30)
        descripLabel.layoutToSuperview(.right, offset: -30)
        
        self.tableView.tableHeaderView = v
        
    }
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard !self.userArray.isEmpty else { return nil }
        
        return "Members"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userArray.count
    }

    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.imageView?.sd_cancelCurrentImageLoad()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "interestProfileCell", for: indexPath)
        
                cell.textLabel?.numberOfLines = 99
        
        let u = self.userArray[indexPath.row]
        
        cell.accessoryType = .disclosureIndicator

        let transformer = SDImageResizingTransformer(size: CGSize(width: 100, height: 100), scaleMode: .aspectFill)
        cell.imageView?.sd_setImage(with: URL(string: u.imageURL), placeholderImage: UIImage(named: "travisScott")?.resizedImage(newSize: CGSize(width: 40.0, height: 40.0)), options: [.scaleDownLargeImages], context: [.imageTransformer: transformer], progress: nil, completed: { (image, err, cacheType, url) in
            guard let img = image else { return }
            cell.imageView?.image = cell.imageView?.image?.resizedImage(newSize: CGSize(width: 40.0, height: 40.0))
            cell.imageView?.layer.masksToBounds = true
            cell.imageView?.layer.cornerRadius = 10
        })
        
        cell.textLabel?.text = u.name

        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = self.userArray[indexPath.row]
        
        let vc = UserProfileVC(style: .insetGrouped)
        vc.user = user
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
