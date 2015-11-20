//
//  ContactTableViewCell.swift
//  ShowPlanner
//
//  Created by Leslie Kim on 11/19/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactEmailLabel: UILabel!
    @IBOutlet weak var contactCellLabel: UILabel!
    
    var contact: Contact? {
        didSet {
            if let contact = contact, contactNameLabel = contactNameLabel, contactEmailLabel = contactEmailLabel, contactCellLabel = contactCellLabel {
                contactNameLabel.text = contact.name
                contactEmailLabel.text = contact.email
                contactCellLabel.text = contact.cell
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
