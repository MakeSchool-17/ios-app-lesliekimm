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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
