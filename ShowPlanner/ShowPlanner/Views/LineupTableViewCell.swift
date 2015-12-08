//
//  LineupTableViewCell.swift
//  Show Planner
//
//  Created by Leslie Kim on 11/22/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class LineupTableViewCell: UITableViewCell {
    @IBOutlet weak var lineupNameLabel: UILabel!
    @IBOutlet weak var confirmedLabel: UILabel!
    var lineup: Lineup? {
        didSet {
            if let lineup = lineup, lineupNameLabel = lineupNameLabel {
                lineupNameLabel.text = lineup.name
                if lineup.confirmed {
                    confirmedLabel.text = "Y"
                    confirmedLabel.textColor = UIColor.greenColor()
                }
            }
        }
    }
}
