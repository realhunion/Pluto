//
//  InfoVC.swift
//  Pluto
//
//  Created by Hunain Ali on 4/26/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import UIKit

class InformationVC: UITableViewController {
    
    var infoText : String!
    
    
    override init(style: UITableView.Style) {
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SubtitleTableViewCell.classForCoder(), forCellReuseIdentifier: "infoCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)

        cell.textLabel?.numberOfLines = 999
        cell.textLabel?.text = self.infoText
        
        cell.selectionStyle = .none

        return cell
    }
    
}
