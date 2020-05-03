//
//  SettingsVC.swift
//  Pluto
//
//  Created by Hunain Ali on 4/25/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import UIKit
import Firebase

struct SettingsCell {
    var title : String
    var image : UIImage?
    var disclosureIndicator : Bool
}

class SettingsVC: UITableViewController {
    
    let settingCellArray : [[SettingsCell]] = [
        
        [SettingsCell(title: "Hunain Ali x James Lim", image: nil, disclosureIndicator: false)],
        
        [SettingsCell(title: "Quarantine Build. For 2024. Something we wish we had coming into Grinnell. Find a roomate. Discover your campus.", image: nil, disclosureIndicator: false)],
        
        [SettingsCell(title: "Helpline", image: nil, disclosureIndicator: true),
         SettingsCell(title: "Terms & Privacy", image: nil, disclosureIndicator: true),
         SettingsCell(title: "Shoutouts", image: nil, disclosureIndicator: true)
        ],
        
        [SettingsCell(title: "Log Out", image: nil, disclosureIndicator: false)]
    ]
    
    
    override init(style: UITableView.Style) {
        super.init(style: .insetGrouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("noti SETTINGS TVC is deinit")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SubtitleTableViewCell.classForCoder(), forCellReuseIdentifier: "settingsCell")
    }
    
    
    
    
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "The Who"
        }
        if section == 1 {
            return "The Why"
        }
        else if section == 2 {
            return nil
        }
        else {
            return nil
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.settingCellArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingCellArray[section].count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
        cell.selectionStyle = .none
        
        cell.textLabel?.numberOfLines = 99
        cell.detailTextLabel?.numberOfLines = 99
        cell.textLabel?.text = nil
        cell.detailTextLabel?.text = nil
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = self.settingCellArray[indexPath.section][indexPath.row].title
            cell.textLabel?.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize, weight: .semibold)
            cell.textLabel?.textAlignment = .center
        }
        else if indexPath.section == 1 {
            cell.textLabel?.text = self.settingCellArray[indexPath.section][indexPath.row].title
        }
        else {
            cell.textLabel?.text = self.settingCellArray[indexPath.section][indexPath.row].title
        }
        
        if self.settingCellArray[indexPath.section][indexPath.row].disclosureIndicator {
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        guard LoginManager.shared.isLoggedIn() else { return }
        
        let settingsCell = self.settingCellArray[indexPath.section][indexPath.row]
        
        switch settingsCell.title {
            
//        case "My Profile":
//            self.presentMyProfile()
//
//        case "Silence Mode":
//            self.presentSilenceMenu()
//
//        case "What is Bump?":
//            self.presentWhatIsBump()
//
//        case "How To Use":
//            self.presentHowToUse()
//
//        case "Send a Suggestion":
//            self.presentSendASuggestion()
//
        case "Helpline":
            self.presentHelpline()

        case "Terms & Privacy":
            let vc = InfoVC(style: .insetGrouped)
            vc.infoText = "Pretty simple.\n\n1. Be a prospective or current student at Grinnell.\n2. Use your real name.\n3. Don't write anything offensive in profile fields.\n4. We reserve right to remove anyone not following 1-3.\n\n5. All data to & from the app is stored on Firebase servers.\n6. Only app admin has root access to database.\n\n7. We're not liable for user's actions stemming on & off the platform.\n\nEnjoy!"
            vc.title = "Terms & Privacy"
            self.navigationController?.pushViewController(vc, animated: true)
            
        case "Shoutouts":
            let vc = InfoVC(style: .insetGrouped)
            vc.infoText = "Shoutout Solly for brilliant idea of Connections.\n\nShoutout Firebase\nShoutout Shuffle.\nShoutout QuickLayout\nShoutout SDWebImage\n\nrentry.co/kctax"
            vc.title = "Shoutouts"
            self.navigationController?.pushViewController(vc, animated: true)
 
        case "Log Out":
            (UIApplication.shared.delegate as! AppDelegate).pluto?.logOut()
            
        default:
            break
        }
    }
    
    
    func presentHelpline() {
        let email = "alihunai@grinnell.edu"
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
    }


}





    
