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
    @IBOutlet weak var hostLabel: UILabel!
    @IBOutlet weak var confirmedLabel: UILabel!

    var performer: Performer? {
        didSet {
            if let performer = performer, lineupNameLabel = lineupNameLabel, hostLabel = hostLabel, confirmedLabel = confirmedLabel {
                lineupNameLabel.text = performer.name
                if performer.host == true {
                    hostLabel.text = "Host"
                }
                else {
                    hostLabel.text = ""
                }
                if performer.confirmed == true {
                    confirmedLabel.text = "C"
                }
                else {
                    confirmedLabel.text = "x"
                }
            }
        }
    }
}
