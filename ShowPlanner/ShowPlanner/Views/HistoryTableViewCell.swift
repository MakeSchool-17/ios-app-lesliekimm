//
//  HistoryTableViewCell.swift
//  ShowPlanner
//
//  Created by Leslie Kim on 11/19/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
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
            if let event = event, nameLabel = nameLabel, locationLabel = locationLabel, dateLabel = dateLabel, timeLabel = timeLabel {
                nameLabel.text = event.name
                locationLabel.text = event.location
                dateLabel.text = EventTableViewCell.dateFormatter.stringFromDate(event.dateTime)
                timeLabel.text = EventTableViewCell.timeFormatter.stringFromDate(event.dateTime)
            }
        }
    }
}
