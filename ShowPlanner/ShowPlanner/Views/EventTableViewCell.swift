//
//  EventTableViewCell.swift
//  Show Planner
//
//  Created by Leslie Kim on 11/22/15.
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
    
    static var dateFormatter: NSDateFormatter = {
        var formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        return formatter
    }()
    
    static var timeFormatter: NSDateFormatter = {
        var formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        return formatter
    }()
    
    var event: Event? {
        didSet {
            if let event = event, eventNameLabel = eventNameLabel, lineupLabel = lineupLabel, locationLabel = locationLabel, dateLabel = dateLabel, timeLabel = timeLabel, confirmedLabel = confirmedLabel {
                eventNameLabel.text = event.name
                lineupLabel.text = event.lineup
                locationLabel.text = event.location
                dateLabel.text = EventTableViewCell.dateFormatter.stringFromDate(event.dateTime)
                timeLabel.text = EventTableViewCell.timeFormatter.stringFromDate(event.dateTime)
                confirmedLabel.text = "Not confirmed"
//                if event.confirmed {
//                    confirmedLabel.text = "All Confirmed"
//                }
//                else {
//                    confirmedLabel.text = "Not Confirmed"
//                }
            }
        }
    }
}
