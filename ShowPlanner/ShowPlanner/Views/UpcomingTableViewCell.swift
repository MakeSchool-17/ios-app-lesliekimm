//
//  UpcomingTableViewCell.swift
//  Show Planner
//
//  Created by Leslie Kim on 11/22/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

// SOURCES:
// 1) red x image: http://cod.esportspedia.com/w/images/archive/8/89/20150313002728!RedX.png
// 2) green check image: http://www.clipartbest.com/cliparts/4T9/Ejp/4T9Ejpy8c.png

import UIKit

class UpcomingTableViewCell: UITableViewCell {
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var lineupLabel: UILabel!
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
            if let event = event, eventNameLabel = eventNameLabel, lineupLabel = lineupLabel, locationLabel = locationLabel, dateLabel = dateLabel, timeLabel = timeLabel {
                eventNameLabel.text = event.name
                lineupLabel.text = event.lineup
                locationLabel.text = event.location
                dateLabel.text = UpcomingTableViewCell.dateFormatter.stringFromDate(event.dateTime)
                timeLabel.text = UpcomingTableViewCell.timeFormatter.stringFromDate(event.dateTime)
//                if event.confirmed {
//                    confirmedImage.image = UIImage(named: "green check")
//                }
//                else {
//                    confirmedImage.image = UIImage(named: "red x")
//                }
            }
        }
    }
}
