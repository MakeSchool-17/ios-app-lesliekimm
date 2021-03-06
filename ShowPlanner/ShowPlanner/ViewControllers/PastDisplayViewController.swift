//
//  PastDisplayViewController.swift
//  Show Planner
//
//  Created by Leslie Kim on 12/12/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class PastDisplayViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var navItem: UINavigationItem!                       // code connection for navigation item
    @IBOutlet weak var nameTextView: UITextView!                        // code connection for name textview
    @IBOutlet weak var locationTextView: UITextView!                    // code connection for location textview
    @IBOutlet weak var dateTimeTextView: UITextView!                    // code connection for date and time textview
    @IBOutlet weak var lineupTextView: UITextView!                      // code connection for lineup textview
    @IBOutlet weak var notesTextView: UITextView!                       // code connection for notes textview
    
    @IBOutlet weak var eventNameLabel: UILabel!                         // code connection for event name label
    @IBOutlet weak var locationLabel: UILabel!                          // code connection for location label
    @IBOutlet weak var dateTimeLabel: UILabel!                          // code connection for date and time label
    @IBOutlet weak var lineupLabel: UILabel!                            // code connection for lineup label
    @IBOutlet weak var notesLabel: UILabel!                             // code connection for notes label
    
    let blueColor = UIColor(red: 0x25, green: 0x3b, blue: 0x4b)         // app icon blue color var

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
    
    var event: Event? {                                                 // optional Event var
        didSet {
            displayEvent(event)                                         // display event everytime changes are made
        }
    }
    
    // Set the view when loaded for the first time
    override func viewDidLoad() {
        super.viewDidLoad()

        notesTextView.delegate = self                                   // set notesTextView delegate to itself
        
        // Initialize UITapGestureRecognizer
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)                                  // add tap gesture to view
    }
    
    // Set the view every time it appears
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true                     // hide tab bar controller in this VC
        
        navItem.title = event!.name                                     // use event's name as title
        setColors()
        displayEvent(event)                                             // display event
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false                    // display tab bar controller when leaving this view
    }
    
    // View will resign first responder status
    func dismissKeyboard() {
        view.endEditing(true)                                           // dismiss keyboard
        view.resignFirstResponder()                                     // resign first responder
    }
    
    // Set the view everytime it disappears
    func displayEvent(event: Event?) {
        // add lineupTextField = lineupTextField into if let after fixing lineupArray
        if let event = event, nameTextView = nameTextView, locationTextView = locationTextView, dateTimeTextView = dateTimeTextView,  notesTextView = notesTextView {
            
            // If event has name, otherwise display "Event Name" in gray to indicate placeholder
            if event.name != "" {
                nameTextView.text = event.name                          // set nameTextView text to event name
                nameTextView.textColor = blueColor                      // set nameTextView textColor to app icon blue
            }
            else {
                nameTextView.text = "Event Name"                        // set nameTextView text to "Event Name"
                nameTextView.textColor = UIColor.lightGrayColor()       // set text color to gray
            }
            
            // If event has location, otherwise display "Location" in gray to indicate placeholder
            if event.location != "" {
                locationTextView.text = event.location                  // set locationTextView text to event location
                locationTextView.textColor = blueColor                  // set locationTextView textColor to app icon blue
            }
            else {
                locationTextView.text = "Location"                      // set locationTextView text to "Location"
                locationTextView.textColor = UIColor.lightGrayColor()   // set text color to gray
            }
            
            // Get date and time formatted properly
            let date = PastDisplayViewController.dateFormatter.stringFromDate(event.dateTime)
            let time = PastDisplayViewController.timeFormatter.stringFromDate(event.dateTime)
            dateTimeTextView.text = date + " " + time                   // set dateTimeTextView text to event date and time
            dateTimeTextView.textColor = blueColor                      // set dateTimeTextView textColor to app icon blue
            
            // If event has lineup, otherwise display "Lineup" in gray to indicate placeholder
            if event.lineupList.count > 0 {
                var lineupString = ""                                   // set lineupString to empty string
                for lineup in event.lineupList {                        // for each lineup in lineupList
                    lineupString = lineupString + lineup.name + " "     // add lineup name to lineupString
                }
                lineupTextView.text = lineupString                      // set lineupTextView text to lineupString
                lineupTextView.textColor = blueColor                    // set lineupTextView textColor to app icon blue
            }
            else {
                lineupTextView.text = "Lineup"                          // set lineupTextView text to "Lineup"
                lineupTextView.textColor = UIColor.lightGrayColor()     // set text color to gray
            }
            
            // If event has notes, otherwise display "Add Notes" in gray to indicate placeholder
            if event.notes != "" {
                notesTextView.text = event.notes                        // set notesTextView text to event's notes
                notesTextView.textColor = blueColor                     // set notesTextView textColor to app icon blue
            }
            else {
                notesTextView.text = "Add Notes"                        // set notesTextView text to "Add Notes"
                notesTextView.textColor = UIColor.lightGrayColor()      // set text color to gray
            }
        }
    }
    
    // MARK: Custom functions
    // Set colors of labels
    func setColors() {
        eventNameLabel.textColor = blueColor                            // set eventNameLabel textColor to app icon blue
        locationLabel.textColor = blueColor                             // set locationLabel textColor to app icon blue
        dateTimeLabel.textColor = blueColor                             // set dateTimeLabel textColor to app icon blue
        lineupLabel.textColor = blueColor                               // set lineupLabel textColor to app icon blue
        notesLabel.textColor = blueColor                                // set notesLabel textColor to app icon blue
    }
    
    // MARK: UITextViewDelegate
    // Set text color to app icon blue when editing notesTextView text and remove placeholder text
    func textViewDidBeginEditing(textView: UITextView) {
        // If notesTextView text color is gray, it is placeholder text
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = nil                                         // set notesTextView text to nil
            textView.textColor = blueColor                              // set text color to app icon blue
        }
    }
    
    // Set notexTextView when done editing
    func textViewDidEndEditing(textView: UITextView) {
        // If notesTextView is empty, put placeholder text back
        if textView.text.isEmpty {
            textView.text = "Add Notes"                                 // set notesTextView text to "Add Notes"
            textView.textColor = UIColor.lightGrayColor()               // set text color to gray
        }
    }
}