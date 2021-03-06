//
//  ContactTableViewCell.swift
//  ShowPlanner
//
//  Created by Leslie Kim on 11/19/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit
import Contacts

class ContactTableViewCell: UITableViewCell {
    @IBOutlet weak var contactNameLabel: UILabel!                   // code connection for contact name label
    
    let blueColor = UIColor(red: 0x25, green: 0x3b, blue: 0x4b)     // app icon blue color var
    
    var contact: Contact? {
        didSet {
            if let contact = contact, contactNameLabel = contactNameLabel {
                contactNameLabel.text = contact.name                // set contactNameLabel text to contact name
                contactNameLabel.textColor = blueColor              // set contactNameLabel textColor to app icon blue
            }
        }
    }
}
