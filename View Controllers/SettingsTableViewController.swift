//
//  SettingsTableViewController.swift
//  SmallBiz
//
//  Created by Andrew Acton on 12/20/22.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Settings Controller")
    }

    // MARK: - Table view data source
    
    lazy var datasource: [SettingsItem] = {
        var item = SettingsItem(settingTitle: "New Employee default items", isActive: false, type: .toggleSwitch)
        item.readDefaults()
        var secondItem = SettingsItem(settingTitle: "Default Items", isActive: false, type: .disclosure)
        return [item, secondItem]
    }()

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = datasource[indexPath.row]
        
        switch item.type {
            case .toggleSwitch:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as? SettingsTableViewCell else { return UITableViewCell()}
            
                cell.settingsNameLabel.text = item.settingTitle
                cell.settingsSwitch.isOn = item.isActive
                cell.delegate = self
                cell.item = item
                return cell
            
            case .disclosure:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "disclosureCell", for: indexPath) as? DisclosureTableViewCell else { return UITableViewCell()}
                cell.disclosureTitleLabel.text = item.settingTitle
                return cell
        }

    }

  
    // MARK: - Navigation

}

struct SettingsItem {
    var settingTitle: String
    var isActive: Bool
    var type: SettingCellType
    
    mutating func readDefaults() {
        let defaults = UserDefaults.standard
        self.isActive = defaults.bool(forKey: self.settingTitle)
    }
}

enum SettingCellType {
    case toggleSwitch
    case disclosure
}

extension SettingsTableViewController: SettingsChangedProtocol {
    func settingToggled(item: SettingsItem) {
        let defaults = UserDefaults.standard
        defaults.set(!item.isActive, forKey: item.settingTitle)
    }
}
