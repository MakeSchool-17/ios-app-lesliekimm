//
//  PastTableViewCell.swift
//  ShowPlanner
//
//  Created by Leslie Kim on 11/19/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class PastTableViewCell: UITableViewCell {
    @IBOutlet weak var eventNameLabel: UILabel!             // code connection for event name label
    @IBOutlet weak var locationLabel: UILabel!              // code connection for location label
    @IBOutlet weak var dateLabel: UILabel!                  // code connection for date label
    @IBOutlet weak var timeLabel: UILabel!                  // code connection for time label
    
    // Format appearance of dateLabel
    static var dateFormatter: NSDateFormatter = {
        var formatter = NSDateFormatter()                   // declare NSDateFormatter object
        formatter.dateStyle = .MediumStyle                  // use MediumStyle for date
        return formatter                                    // return NSDateFormatter object
    }()
    
    // Formate appearance of timeLabel
    static var timeFormatter: NSDateFormatter = {
        var formatter = NSDateFormatter()                   // declare NSDateFormatter object
        formatter.timeStyle = .ShortStyle                   // use ShortStyle for time
        return formatter                                    // return NSDateFormatter object
    }()
    
    // Create event var and use didSet method to keep event updated upon changes
    var event: Event? {
        didSet {
            if let event = event, eventNameLabel = eventNameLabel, locationLabel = locationLabel, dateLabel = dateLabel, timeLabel = timeLabel {
                eventNameLabel.text = event.name            // set eventNameLabel to event name
                locationLabel.text = event.location         // set locationLabel to event location
                // Set dateLabel and timeLabel to event date and time formatted using declared styles
                dateLabel.text = PastTableViewCell.dateFormatter.stringFromDate(event.dateTime)
                timeLabel.text = PastTableViewCell.timeFormatter.stringFromDate(event.dateTime)
            }
        }
    }
}
