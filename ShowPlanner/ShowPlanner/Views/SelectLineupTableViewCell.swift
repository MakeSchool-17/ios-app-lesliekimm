//
//  SelectLineupTableViewCell.swift
//  Show Planner
//
//  Created by Leslie Kim on 12/2/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit
import Contacts

class SelectLineupTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    var contact: Contact? {
        didSet {
            if let contact = contact, nameLabel = nameLabel {
                nameLabel.text = contact.name
            }
        }
    }
}
