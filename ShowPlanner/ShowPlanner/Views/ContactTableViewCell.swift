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
    @IBOutlet weak var contactNameLabel: UILabel!

    var contact: Contact? {
        didSet {
            if let contact = contact, contactNameLabel = contactNameLabel {
                contactNameLabel.text = contact.name
            }
        }
    }
}
