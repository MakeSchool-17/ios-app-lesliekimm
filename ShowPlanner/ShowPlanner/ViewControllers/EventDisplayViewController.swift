//
//  EventDisplayViewController.swift
//  Show Planner
//
//  Created by Leslie Kim on 12/13/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit
import RealmSwift

class EventDisplayViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var navItem: UINavigationItem!                           // code connection for navigation item
    @IBOutlet weak var eventNameTextField: UITextField!                     // code connection for event name textfield
    @IBOutlet weak var locationTextField: UITextField!                      // code connection for location textfield
    @IBOutlet weak var datePicker: UIDatePicker!                            // code connection for datePicker date
    @IBOutlet weak var selectLineupButton: UIButton!                        // code connection for select lineup button
    @IBOutlet weak var lineupTableView: UITableView!                        // code connection for lineupTV
    @IBOutlet weak var trashButton: UIBarButtonItem!                        // code connection for trash button
    
    var event: Event? {                                                     // optional Event var
        didSet {
            displayEvent(event)                                             // display event everytime changes are made
        }
    }
    var selectedLineup: Lineup?                                             // optional Lineup var used to change whether lineup is confirmed or not
    var lineupToAdd: Lineup?                                                // optional Lineup var used to add Lineup objects to event LineupList
    var addNew: Bool = false                                                // Bool to indicate if we are adding new Event or not
    
    // Depending on segue identifier, perform an action
    @IBAction func backToEventDisplayVC(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            switch identifier {
            case "saveLineup":                                              // if saveLineup segue
                let source = segue.sourceViewController as! SelectLineupViewController
                event!.lineupList.append(lineupToAdd!)                      // add lineupToAdd to event lineupList
                source.lineup = nil                                         // set lineup in SelectLineupVC to nil
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
    }
    
    // Set the view every time it appears
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true                         // hide tab bar controller in this VC
        
        navItem.title = event!.name                                         // use event name as title
        setUpTextFieldDelegates()                                           // set up textfield delegates
        displayEvent(event)                                                 // display event
        
        if addNew {                                                         // if adding new Contact
            trashButton.enabled = false                                     // disable trash button
        }
    }
    
    // Set the view everytime it disappears
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false                        // unhide tab bar controller when leaving this VC
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
        locationTextField.returnKeyType = .Next                             // change Return to Next
        locationTextField.delegate = self                                   // set location textfield delegate to self
    }
    
    // Display event info for optional Event object
    func displayEvent(event: Event?) {
        // TODO: edit selectLineupButton, lineupTableView
        if let event = event, eventNameTextField = eventNameTextField, locationTextField = locationTextField, datePicker = datePicker {
            eventNameTextField.text = event.name                            // set eventNameTextField text to event name
            locationTextField.text = event.location                         // set locationTextField text to event location
            datePicker.date = event.dateTime                                // set datePicker date to event dateTime
            
            // TODO: edit lineup button text if lineup exists
            // TODO: display lineupTV
        }
    }
    
    // MARK: Navigation
    // Prepare for respective segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // If performing showExistingEvent, get destinationVC and set event to selectedEvent
        if (segue.identifier == "selectLineup") {
            // Grab a reference to PastDisplayVC
            let eventViewController = segue.destinationViewController as! SelectLineupViewController
            
            event!.name = eventNameTextField.text!
            event!.location = locationTextField.text!
            event!.dateTime = datePicker.date
            
            eventViewController.event = event                               // set event in EventDisplayVC to selectedEvent
        }
    }
    
    // MARK: UITextFieldDelegate
    // Sets first responder to next textfield when Next (Return) key hit
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == eventNameTextField) {                              // if current textfield is eventNameTextField
            locationTextField.returnKeyType = .Next                         // set locationTextField returnKeyType to Next
            locationTextField.becomeFirstResponder()                        // set first responder to locationTextField
        }
        return false                                                        // otherwise, return false
    }

    // MARK: UITableViewDataSource
    // Set Lineup object to be displayed in each lineupTVC
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Get a reusable TVC object for LineupCell and add to lineupTV
        let cell = tableView.dequeueReusableCellWithIdentifier("LineupCell") as! LineupTableViewCell
        let row = indexPath.row                                             // get row
        let lineup = (event?.lineupList[row])! as Lineup                    // get Lineup object from lineupList at row index
        cell.lineup = lineup                                                // set lineup prop for cell to lineup
        return cell                                                         // return cell
    }
    
    // Get the number of rows in lineupTV
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return event?.lineupList.count ?? 0                                 // return total number of lineup in lineupList or 0 if empty
    }
    
//    // Delete Lineup object at specified row
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {                                        // if editingStyle is Delete
//            let lineup = (event?.lineupList[indexPath.row])! as Lineup      // get Lineup object at row index from lineupList
//            event?.lineupList.delete(lineup)                                // delete lineup
//            tableView.reloadData()                                          // reload lineupTV
//        }
//    }
    
    // MARK: UITableViewDelegate
    // Get selectedLineup when a TVC is selected and edit confirmed prop
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedLineup = event?.lineupList[indexPath.row]                   // set selectedLineup to Lineup at row index from lineupList
        
        if selectedLineup!.confirmed {                                      // if selectedLineup is confirmed
            selectedLineup!.confirmed = false                               // set confirmed prop to false
        }
        else {                                                              // if selectedLineup is not confirmed
            selectedLineup!.confirmed = true                                // set confirmed prop to true
        }
    }
}
