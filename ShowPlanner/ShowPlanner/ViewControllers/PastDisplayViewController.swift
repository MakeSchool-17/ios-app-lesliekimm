//
//  PastDisplayViewController.swift
//  Show Planner
//
//  Created by Leslie Kim on 12/12/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class PastDisplayViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var navItem: UINavigationItem!           // code connection for navigation item
    @IBOutlet weak var nameTextField: UITextField!          // code connection for name textfield
    @IBOutlet weak var locationTextField: UITextField!      // code connection for location textfield
    @IBOutlet weak var dateTimeTextField: UITextField!      // code connection for datePicker date
    @IBOutlet weak var lineupTextField: UITextField!        // code connection for lineup textfield
    @IBOutlet weak var notesTextView: UITextView!           // code connection for notes textview

    // Format appearance of dateLabel
    static var dateFormatter: NSDateFormatter = {
        var formatter = NSDateFormatter()                   // declare NSDateFormatter object
        formatter.dateStyle = .MediumStyle                  // use MediumStyle for date
        return formatter                                    // return NSDateFormatter object
    }()
    
    // Formate appearance of timeLabel
    static var timeFormatter: NSDateFormatter = {
        var formatter = NSDateFormatter()                           // declare NSDateFormatter object
        formatter.timeStyle = .ShortStyle                           // use ShortStyle for time
        return formatter                                            // return NSDateFormatter object
    }()
    
    var event: Event? {                                             // optional Event var
        didSet {
            displayEvent(event)                                     // display event everytime changes are made
        }
    }
    
    // Set the view when loaded for the first time
    override func viewDidLoad() {
        super.viewDidLoad()

        notesTextView.delegate = self                               // set notesTextView delegate to itself
        
        // Initialize UITapGestureRecognizer
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)                              // add tap gesture to view
    }
    
    // Set the view every time it appears
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true                 // hide tab bar controller in this VC
        
        navItem.title = event!.name                                 // use event's name as title
        displayEvent(event)                                         // display event
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
    
    // View will resign first responder status
    func dismissKeyboard() {
        view.endEditing(true)                                       // dismiss keyboard
        view.resignFirstResponder()                                 // resign first responder
    }
    
    // Set the view everytime it disappears
    func displayEvent(event: Event?) {
        // add lineupTextField = lineupTextField into if let after fixing lineupArray
        if let event = event, nameTextField = nameTextField, locationTextField = locationTextField, dateTimeTextField = dateTimeTextField,  notesTextView = notesTextView {
            nameTextField.text = event.name                         // set nameTextField text to event's name
            locationTextField.text = event.location                 // set locationTextField text to event's location
            
            // Get date and time formatted properly
            let date = PastDisplayViewController.dateFormatter.stringFromDate(event.dateTime)
            let time = PastDisplayViewController.timeFormatter.stringFromDate(event.dateTime)
            dateTimeTextField.text = date + " " + time              // set dateTimeTextField text to event's date and time
            
//            if event.lineupArray!.count > 0 {
//                var lineupString = ""
//                for contact in event.lineupArray! {
//                    lineupString = lineupString + contact.name + " "
//                }
//                lineupTextField.text = lineupString
//            }
//            else {
//                lineupTextField.text = ""
//            }
            
            // If event has notes, display them in black, otherwise display "Notes" in gray to indicate placeholder
            if event.notes != "" {
                notesTextView.text = event.notes                    // set notesTextView text to event's notes
                notesTextView.textColor = UIColor.blackColor()      // set text color to black
            }
            else {
                notesTextView.text = "Notes"                        // set notesTextView text to "Notes"
                notesTextView.textColor = UIColor.lightGrayColor()  // set text color to gray
            }
        }
    }
    
    // MARK: UITextViewDelegate
    // Set text color to black when editing notesTextView text and remove placeholder text
    func textViewDidBeginEditing(textView: UITextView) {
        // If notesTextView text color is gray, it is placeholder text
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = nil                                     // set notesTextView text to nil
            textView.textColor = UIColor.blackColor()               // set text color to black
        }
    }
    
    // Set notexTextView when done editing
    func textViewDidEndEditing(textView: UITextView) {
        // If notesTextView is empty, put placeholder text back
        if textView.text.isEmpty {
            textView.text = "Notes"                                 // set notesTextView text to "Notes"
            textView.textColor = UIColor.lightGrayColor()           // set text color to gray
        }
    }
}
