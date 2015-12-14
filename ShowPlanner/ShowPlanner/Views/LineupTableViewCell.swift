//
//  LineupTableViewCell.swift
//  Show Planner
//
//  Created by Leslie Kim on 12/13/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class LineupTableViewCell: UITableViewCell {
    @IBOutlet weak var lineupNameLabel: UILabel!                // code connection for lineup name label
    @IBOutlet weak var confirmationButton: UIButton!            // code connection for confirmation button

    // Create lineup var and use didSet method to keep lineup updated upon changes
    var lineup: Lineup? {
        didSet {
            if let lineup = lineup {
                lineupNameLabel.text = lineup.name              // set lineupNameLabel text
                
                // If lineup confirmed, display green check, otherwise, display red x
                if lineup.confirmed {
                    confirmationButton.setImage(UIImage(named: "green check"), forState: .Normal)
                }
                else {
                    confirmationButton.setImage(UIImage(named: "red x"), forState: .Normal)
                }
            }
        }
    }
}
