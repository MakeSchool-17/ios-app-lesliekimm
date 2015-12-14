//
//  SelectLineupTableViewCell.swift
//  Show Planner
//
//  Created by Leslie Kim on 12/13/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class SelectLineupTableViewCell: UITableViewCell {
    @IBOutlet weak var selectLineupNameLabel: UILabel!              // code connection for contact name label

    // Create contact var and use didSet method to keep contact updated upon changes
    var contact: Contact? {
        didSet {
            if let contact = contact {
                selectLineupNameLabel.text = contact.name           // set lineupNameLabel text
            }
        }
    }
}
