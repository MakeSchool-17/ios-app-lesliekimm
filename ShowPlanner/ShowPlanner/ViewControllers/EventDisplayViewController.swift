//
//  EventDisplayViewController.swift
//  Show Planner
//
//  Created by Leslie Kim on 12/13/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

// SOURCES: 1) date picker color: http://stackoverflow.com/questions/29220535/changing-text-color-of-datepicker

import UIKit
import RealmSwift

class EventDisplayViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    @IBOutlet weak var navItem: UINavigationItem!                           // code connection for navigation item
    @IBOutlet weak var eventNameTextField: UITextField!                     // code connection for event name textfield
    @IBOutlet weak var locationTextField: UITextField!                      // code connection for location textfield
    @IBOutlet weak var datePicker: UIDatePicker!                            // code connection for datePicker date
    @IBOutlet weak var selectLineupButton: UIButton!                        // code connection for select lineup button
    @IBOutlet weak var lineupTableView: UITableView!                        // code connection for lineupTV
    @IBOutlet weak var trashButton: UIBarButtonItem!                        // code connection for trash button
    
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var lineupLabel: UILabel!
    
    var eventsDataSource = EventsDataSource()
    var event: Event? {                                                     // optional Event var
        didSet {
            displayEvent(event)                                             // display event everytime changes are made
        }
    }
    var selectedLineupNS: LineupNS?                                         // optional Lineup var used to change whether lineup is confirmed or not
    var lineupNSToAdd: LineupNS?                                            // optional Lineup var used to add Lineup objects to event LineupList
    var addNew: Bool = false                                                // Bool to indicate if we are adding new Event or not
    var editedLineupArray: Array<LineupNS>?                                 // optional Lineup Array var
    let blueColor = UIColor(red: 0x25, green: 0x3b, blue: 0x4b)             // app icon blue color var
    let redColor = UIColor(red: 0xdd, green: 0x53, blue: 0x45)              // app icon red color var
    let greenColor = UIColor(red: 0x00, green: 0xa3, blue: 0x88)            // app icon green color var
    
    // Depending on segue identifier, perform an action
    @IBAction func backToEventDisplayVC(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            switch identifier {
            case "saveLineup":                                              // if saveLineup segue
                let source = segue.sourceViewController as! SelectLineupViewController
                if lineupNSToAdd != nil {                                   // save if lineupToAdd is not nil
                    editedLineupArray!.append(lineupNSToAdd!)               // add lineupToAdd to event lineupList
                }
                source.lineupNS = nil                                       // set lineup in SelectLineupVC to nil
            default:
                print("No one loves \(identifier)")                         // print log message
            }
            lineupTableView.reloadData()
        }
    }
    
    // Set the view when loaded for the first time
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineupTableView.dataSource = self                                   // declare dataSource for lineupTV
        lineupTableView.delegate = self                                     // declare delegate for lineupTV
        lineupTableView.reloadData()                                        // reload data
        
        // Initialize UITapGestureRecognizer
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)                                      // add tap gesture to view
        tap.delegate = self                                                 // declare tap delegate
    }
    
    // Set the view every time it appears
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true                         // hide tab bar controller in this VC
        
        navItem.title = event!.name                                         // use event name as title
        setUpTextFieldDelegates()                                           // set up textfield delegates
        setColors()
        displayEvent(event)                                                 // display event
        
        if addNew {                                                         // if adding new Contact
            trashButton.enabled = false                                     // disable trash button
        }
    }
    
    // MARK: Custom functions
    // View will resign first responder status
    func dismissKeyboard() {
        view.endEditing(true)                                               // dismiss keyboard
    }
    
    // Set up textfield delegates
    func setUpTextFieldDelegates() {
        eventNameTextField.returnKeyType = .Next                            // change Return to Next
        eventNameTextField.delegate = self                                  // set event name textfield delegate to self
        locationTextField.returnKeyType = .Done                             // change Return to Next
        locationTextField.delegate = self                                   // set location textfield delegate to self
        datePicker.setValue(blueColor, forKeyPath: "textColor")
    }
    
    func setColors() {
        eventNameLabel.textColor = blueColor
        locationLabel.textColor = blueColor
        lineupLabel.textColor = blueColor
        selectLineupButton.tintColor = greenColor
        trashButton.tintColor = greenColor
    }
    
    // Display event info for optional Event object
    func displayEvent(event: Event?) {
        // TODO: edit selectLineupButton, lineupTableView
        if let event = event, eventNameTextField = eventNameTextField, locationTextField = locationTextField, datePicker = datePicker {
            eventNameTextField.text = event.name                            // set eventNameTextField text to event name
            locationTextField.text = event.location                         // set locationTextField text to event location
            datePicker.date = event.dateTime                                // set datePicker date to event dateTime
            
            // If lineupTV is empty, show "Select Lineup" on button, otherwise show "Edit Lineup"
            if event.lineupList.count > 0 {
                selectLineupButton.setTitle("Edit Lineup", forState: .Normal)
            }
            else {
                selectLineupButton.setTitle("Select Lineup", forState: .Normal)
            }
            
            if event.name != "" {
                eventNameTextField.textColor = blueColor
            }
            if event.location != "" {
                locationTextField.textColor = blueColor
            }
        }
    }
    
    // MARK: Navigation
    // Prepare for respective segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // If performing showExistingEvent, get destinationVC and set event to selectedEvent
        if (segue.identifier == "selectLineup") {
            // Grab a reference to PastDisplayVC
            let eventViewController = segue.destinationViewController as! SelectLineupViewController
            if addNew {
                event!.name = eventNameTextField.text!
                event!.location = locationTextField.text!
                event!.dateTime = datePicker.date
                eventViewController.event = event                               // set event in EventDisplayVC to selectedEvent
            }
            else {
//                print("Now here")
//                // Create editedEvent with all changes, & send editedEvent to SelectLineupVC
//                editedEvent = Event()
//                editedEvent!.name = eventNameTextField.text!
//                editedEvent!.location = locationTextField.text!
//                editedEvent!.dateTime = datePicker.date
//                editedEvent!.lineupList = event!.lineupList
//                eventViewController.event = editedEvent                               // set event in EventDisplayVC to selectedEvent
            }
        }
    }
    
    // MARK: UITextFieldDelegate
    // Sets first responder to next textfield when Next (Return) key hit
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == eventNameTextField) {                              // if current textfield is eventNameTextField
            locationTextField.returnKeyType = .Next                         // set locationTextField returnKeyType to Next
            locationTextField.becomeFirstResponder()                        // set first responder to locationTextField
        }
        if (textField == locationTextField) {
            locationTextField.returnKeyType = .Done                         // change Return to Next
            locationTextField.resignFirstResponder()
        }
        return false                                                        // otherwise, return false
    }

    // MARK: UITableViewDataSource
    // Set Lineup object to be displayed in each lineupTVC
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Get a reusable TVC object for LineupCell and add to lineupTV
        let cell = lineupTableView.dequeueReusableCellWithIdentifier("LineupCell") as! LineupTableViewCell
        let row = indexPath.row                                             // get row
        let lineup = editedLineupArray![row] as LineupNS                    // get Lineup object from editedLineupArray at row index
        cell.lineup = lineup                                                // set lineup prop for cell to lineup
        return cell                                                         // return cell
    }
    
    // Get the number of rows in lineupTV
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return editedLineupArray!.count ?? 0                                 // return total number of lineup in editedLineupArray or 0 if empty
    }
    
    // Delete Lineup object at specified row
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {                                        // if editingStyle is Delete
            editedLineupArray!.removeAtIndex(indexPath.row)                 // delete lineup
            lineupTableView.reloadData()                                          // reload lineupTV
        }
    }
    
    // MARK: UITableViewDelegate
    // Get selectedLineup when a TVC is selected and edit confirmed prop
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        selectedLineupNS = editedLineupArray![row]                          // set selectedLineup to Lineup at row index from editedLineupArray
        
        if selectedLineupNS!.confirmed {                                    // if selectedLineup is confirmed
            editedLineupArray![row].confirmed = false                       // set confirmed prop to false
        }
        else {                                                              // if selectedLineup is not confirmed
            editedLineupArray![row].confirmed = true
        }
        lineupTableView.reloadData()                                        // reload lineup TV
    }
    
    // MARK: UIGestureRecognizerDelegate
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if gestureRecognizer is UITapGestureRecognizer {
            let location = touch.locationInView(lineupTableView)
            return (lineupTableView.indexPathForRowAtPoint(location) == nil)
        }
        return true
    }
}
