//
//  ShowTableViewCell.swift
//  ShowPlanner
//
//  Created by Leslie Kim on 11/13/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class ShowTableViewCell: UITableViewCell {
    @IBOutlet weak var showNameLabel: UILabel!
    @IBOutlet weak var lineupLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var show: Show? {
        didSet {
            if let show = show, showNameLabel = showNameLabel, lineupLabel = lineupLabel, locationLabel = locationLabel {
                showNameLabel.text = show.name
                lineupLabel.text = show.lineup
                locationLabel.text = show.location
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
