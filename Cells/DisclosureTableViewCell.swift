//
//  DisclosureTableViewCell.swift
//  SmallBiz
//
//  Created by Andrew Acton on 12/25/22.
//

import UIKit

class DisclosureTableViewCell: UITableViewCell {

    @IBOutlet weak var disclosureTitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
