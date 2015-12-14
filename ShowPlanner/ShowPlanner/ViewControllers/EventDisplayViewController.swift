//
//  EventDisplayViewController.swift
//  Show Planner
//
//  Created by Leslie Kim on 12/13/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class EventDisplayViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var navItem: UINavigationItem!               // code connection for navigation item
    @IBOutlet weak var eventNameTextField: UITextField!         // code connection for event name textfield
    @IBOutlet weak var locationTextField: UITextField!          // code connection for location textfield
    @IBOutlet weak var datePicker: UIDatePicker!                // code connection for datePicker date
    @IBOutlet weak var selectLineupButton: UIButton!            // code connection for select lineup button
    @IBOutlet weak var lineupTableView: UITableView!            // code connection for lineupTV
    @IBOutlet weak var trashButton: UIBarButtonItem!            // code connection for trash button
    
    var event: Event? {                                         // optional Event var
        didSet {
            displayEvent(event)                                 // display event everytime changes are made
        }
    }
    var addNew: Bool = false                                    // Bool to indicate if we are adding new Event or not
    
    // Depending on segue identifier, perform an action
    @IBAction func backToEventDisplayVC(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            switch identifier {
            case "saveLineup":                                  // if saveLineup segue
                print("saveLineup")
            default:
                print("No one loves \(identifier)")             // print log message
            }
        }
    }
    
    // Set the view when loaded for the first time
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize UITapGestureRecognizer
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)                          // add tap gesture to view
    }
    
    // Set the view every time it appears
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true             // hide tab bar controller in this VC
        
        navItem.title = event!.name                             // use event's name as title
        setUpTextFieldDelegates()                               // set up textfield delegates
        displayEvent(event)                                     // display event
        
        if addNew {                                             // if adding new Contact
            trashButton.enabled = false                         // disable trash button
        }
    }
    
    // Set the view everytime it disappears
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false        // unhide tab bar controller when leaving this VC
    }
    
    // MARK: Custom functions
    // View will resign first responder status
    func dismissKeyboard() {
        view.endEditing(true)                               // dismiss keyboard
    }
    
    // Set up textfield delegates
    func setUpTextFieldDelegates() {
        eventNameTextField.returnKeyType = .Next            // change Return to Next
        eventNameTextField.delegate = self                  // set event name textfield delegate to self
        locationTextField.returnKeyType = .Next             // change Return to Next
        locationTextField.delegate = self                   // set location textfield delegate to self
    }
    
    // Display event info for optional Event object
    func displayEvent(event: Event?) {
        if let event = event, eventNameTextField = eventNameTextField, locationTextField = locationTextField, datePicker = datePicker, selectLineupButton = selectLineupButton, lineupTableView = lineupTableView {
            eventNameTextField.text = event.name            // set eventNameTextField text to event's location
            locationTextField.text = event.location         // set locationTextField text to event's email
            datePicker.date = event.dateTime                // set datePicker date to event's dateTime
            
            // TODO: edit lineup button text if lineup exists
            // TODO: display lineupTV
        }
    }
    
    // MARK: UITextFieldDelegate
    // Sets first responder to next textfield when Next (Return) key hit
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == eventNameTextField) {              // if current textfield is eventNameTextField
            locationTextField.returnKeyType = .Next         // set locationTextField returnKeyType to Next
            locationTextField.becomeFirstResponder()        // set first responder to locationTextField
        }
        return false                                        // otherwise, return false
    }

}
