//
//  UpcomingTableViewCell.swift
//  Show Planner
//
//  Created by Leslie Kim on 12/13/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class UpcomingTableViewCell: UITableViewCell {
    @IBOutlet weak var eventNameLabel: UILabel!                         // code connection for event name label
    @IBOutlet weak var locationLabel: UILabel!                          // code connection for location label
    @IBOutlet weak var lineupLabel: UILabel!                            // code connection for lineup label
    @IBOutlet weak var dateLabel: UILabel!                              // code connection for date label
    @IBOutlet weak var timeLabel: UILabel!                              // code connection for time label
    @IBOutlet weak var confirmationImage: UIImageView!                  // code connection for confirmation image
    
    let blueColor = UIColor(red: 0x25, green: 0x3b, blue: 0x4b)
    let redColor = UIColor(red: 0xdd, green: 0x53, blue: 0x45)
    
    // Format appearance of dateLabel
    static var dateFormatter: NSDateFormatter = {
        var formatter = NSDateFormatter()                               // declare NSDateFormatter object
        formatter.dateStyle = .MediumStyle                              // use MediumStyle for date
        return formatter                                                // return NSDateFormatter object
    }()
    
    // Formate appearance of timeLabel
    static var timeFormatter: NSDateFormatter = {
        var formatter = NSDateFormatter()                               // declare NSDateFormatter object
        formatter.timeStyle = .ShortStyle                               // use ShortStyle for time
        return formatter                                                // return NSDateFormatter object
    }()
    
    // Create event var and use didSet method to keep event updated upon changes
    var event: Event? {
        didSet {
            if let event = event, eventNameLabel = eventNameLabel, locationLabel = locationLabel, dateLabel = dateLabel, timeLabel = timeLabel {
                eventNameLabel.text = event.name                        // set eventNameLabel to event name
                locationLabel.text = event.location                     // set locationLabel to event location
                
                lineupLabel.text = ""                                   // set lineupLabetl text to emptry string
                for lineup in event.lineupList {                        // for each Lineup object in lineupList
                    // Add lineup name to lineupLabel text
                    lineupLabel.text = lineupLabel.text! + lineup.name + " "
                }
                
                // Set dateLabel and timeLabel to event date and time formatted using declared styles
                dateLabel.text = UpcomingTableViewCell.dateFormatter.stringFromDate(event.dateTime)
                timeLabel.text = UpcomingTableViewCell.timeFormatter.stringFromDate(event.dateTime)
                
                // If all lineup is confirmed, set all text color to app icon blue and confirmationImage to empty
                if event.confirmed {
                    eventNameLabel.textColor = blueColor                // set eventNameLabel color to blue
                    locationLabel.textColor = blueColor                 // set locationLabel color to blue
                    lineupLabel.textColor = blueColor                   // set lineupLabel color to blue
                    dateLabel.textColor = blueColor                     // set dateLabel color to blue
                    timeLabel.textColor = blueColor                     // set timeLabel color to blue
                    confirmationImage.image = UIImage(named: "")        // set confirmationImage to empty
                }
                // Otherwise, set all text color to app icon red and confirmationImage to red x
                else {
                    eventNameLabel.textColor = redColor                 // set eventNameLabel color to blue
                    locationLabel.textColor = redColor                  // set locationLabel color to blue
                    lineupLabel.textColor = redColor                    // set lineupLabel color to blue
                    dateLabel.textColor = redColor                      // set dateLabel color to blue
                    timeLabel.textColor = redColor                      // set timeLabel color to blue
                    confirmationImage.image = UIImage(named: "red x")   // set confirmationImage to red x
                }
            }
        }
    }
}
