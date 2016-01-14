//
//  LineupTableViewCell.swift
//  Show Planner
//
//  Created by Leslie Kim on 12/13/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class LineupTableViewCell: UITableViewCell {
    @IBOutlet weak var lineupNameLabel: UILabel!                        // code connection for lineup name label
    @IBOutlet weak var confirmationButton: UIButton!                    // code connection for confirmation button

    let blueColor = UIColor(red: 0x25, green: 0x3b, blue: 0x4b)         // app icon blue color var
    let redColor = UIColor(red: 0xdd, green: 0x53, blue: 0x45)          // app icon red color var
    
    // Create lineupNS var and use didSet method to keep lineupNS updated upon changes
    var lineupNS: LineupNS? {
        didSet {
            if let lineupNS = lineupNS {
                lineupNameLabel.text = lineupNS.name                    // set lineupNameLabel text
                
                // If lineup confirmed, set text to app icon blue and set confirmationButton image to green check
                if lineupNS.confirmed {
                    lineupNameLabel.textColor = blueColor               // set lineupNameLabel text color to blue
                    confirmationButton.setImage(UIImage(named: "green check"), forState: .Normal)
                }
                // Otherwise, set text to red and set confirmationButton image to red x
                else {
                    lineupNameLabel.textColor = redColor                // set lineupNameLabel text color to red
                    confirmationButton.setImage(UIImage(named: "red x"), forState: .Normal)
                }
            }
        }
    }
}
