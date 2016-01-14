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
    @IBOutlet weak var selectedButton: UIButton!

    let blueColor = UIColor(red: 0x25, green: 0x3b, blue: 0x4b)         // app icon blue color var
    let greenColor = UIColor(red: 0x00, green: 0xa3, blue: 0x88)
    let redColor = UIColor(red: 0xdd, green: 0x53, blue: 0x45)          // app icon red color var
    
    // Create contact var and use didSet method to keep contact updated upon changes
    var lineupSelection: LineupSelection? {
        didSet {
            if let lineupSelection = lineupSelection {
                selectLineupNameLabel.text = lineupSelection.name           // set lineupNameLabel text
                selectLineupNameLabel.textColor = blueColor
                
                if lineupSelection.selected {
                    selectedButton.setImage(UIImage(named: "green check"), forState: .Normal)
                    selectLineupNameLabel.textColor = greenColor               // set lineupNameLabel text color to blue
                }
                else {
                    selectedButton.setImage(UIImage(named: "red x"), forState: .Normal)
                    selectLineupNameLabel.textColor = blueColor               // set lineupNameLabel text color to blue
                }
            }
        }
    }
}
