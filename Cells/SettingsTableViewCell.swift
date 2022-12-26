//
//  SettingsTableViewCell.swift
//  SmallBiz
//
//  Created by Andrew Acton on 12/20/22.
//

import UIKit

protocol SettingsChangedProtocol: AnyObject {
    func settingToggled(item: SettingsItem)
}

class SettingsTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var settingsNameLabel: UILabel!
    @IBOutlet weak var settingsSwitch: UISwitch!
    
    //MARK: - Properties
    weak var delegate: SettingsChangedProtocol?
    
    var item: SettingsItem! {
        didSet {
            updateViews()
        }
    }

    func updateViews() {
        settingsNameLabel.text = item.settingTitle
        settingsSwitch.isOn = item.isActive
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //MARK: - Actions
    @IBAction func settingsSwitchToggled(_ sender: Any) {
        delegate?.settingToggled(item: item)
    }
    

}
