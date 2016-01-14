//
//  SelectLineupTableViewCell.swift
//  Show Planner
//
//  Created by Leslie Kim on 12/13/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class SelectLineupTableViewCell: UITableViewCell {
    @IBOutlet weak var selectLineupNameLabel: UILabel!                  // code connection for contact name label
    @IBOutlet weak var selectedButton: UIButton!                        // code connection for selected button

    let blueColor = UIColor(red: 0x25, green: 0x3b, blue: 0x4b)         // app icon blue color var
    let greenColor = UIColor(red: 0x00, green: 0xa3, blue: 0x88)        // app icon green color var
    let redColor = UIColor(red: 0xdd, green: 0x53, blue: 0x45)          // app icon red color var
    
    // Create lineupNS var and use didSet method to keep lineupNS updated upon changes
    var lineupNS: LineupNS? {
        didSet {
            if let lineupNS = lineupNS {
                selectLineupNameLabel.text = lineupNS.name              // set lineupNameLabel text
                selectLineupNameLabel.textColor = blueColor             // set lineupNameLabel textColor to app icon blue
                
                if lineupNS.selected {
                    selectedButton.setImage(UIImage(named: "green check"), forState: .Normal)
                    selectLineupNameLabel.textColor = greenColor        // set lineupNameLabel textColor to app icon blue
                }
                else {
                    selectedButton.setImage(UIImage(named: "red x"), forState: .Normal)
                    selectLineupNameLabel.textColor = blueColor         // set lineupNameLabel textColor to app icon blue
                }
            }
        }
    }
}
