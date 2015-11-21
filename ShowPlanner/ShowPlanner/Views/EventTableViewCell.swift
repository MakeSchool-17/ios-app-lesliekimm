//
//  EventTableViewCell.swift
//  ShowPlanner
//
//  Created by Leslie Kim on 11/19/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var lineupLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var confirmedLabel: UILabel!
    
    var event: Event? {
        didSet {
            if let event = event, eventNameLabel = eventNameLabel, lineupLabel = lineupLabel, locationLabel = locationLabel, dateLabel = dateLabel, timeLabel = timeLabel, confirmedLabel = confirmedLabel {
                eventNameLabel.text = event.name
                lineupLabel.text = event.lineup
                locationLabel.text = event.location
                dateLabel.text = event.date
                timeLabel.text = event.time
                confirmedLabel.text = event.confirmed
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
