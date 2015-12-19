//
//  UpcomingViewController.swift
//  Show Planner
//
//  Created by Leslie Kim on 12/13/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class UpcomingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var upcomingTableView: UITableView!                      // code connection to upcomingTV
    var eventsDataSource = EventsDataSource()                               // reference to EventsDataSource
    var selectedEvent: Event?                                               // selected event
    var eventsToBeDisplayed: [Event]?                                       // array of events to display on upcomingTV
    
    // Depending on segue identifier, perform an action
    @IBAction func backToUpcomingVC(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            switch identifier {
            case "saveNewEvent":                                            // if saveNewEvent segue
                // Grab reference to sourceVC
                let source = segue.sourceViewController as! AddEventViewController
                eventsDataSource.addEvent(source.event!, lineupToUse: source.lineupToUse!)  // add event
            case "saveExistingEvent":                                       // if saveExistingEvent segue
                // Grab reference to sourceVC
                let source = segue.sourceViewController as! EventDisplayViewController
                let event = source.event                                    // set event to contact from EventDisplayVC
                let editedEvent = Event()                                   // initialize new Event objbect
                
                // If eventNameTextField from EventDisplayVC is not placeholder text, set editedEvent name prop
                if source.eventNameTextField.text != "Event Name" {
                    editedEvent.name = source.eventNameTextField.text!      // set to nameTextField text
                }
                else {
                    editedEvent.name = ""                                   // set to empty string
                }
                
                // If locationTextField from EventDisplayVC is not placeholder text, set editedEvent location prop
                if source.locationTextField.text != "Location" {
                    editedEvent.location = source.locationTextField.text!   // set to locationTextField text
                }
                else {
                    editedEvent.location = ""                               // set to empty string
                }
                
                editedEvent.dateTime = source.datePicker.date               // set dateTime
                
                let lineupToUse = source.editedLineupArray!                 // set lineupToUse
                
                // Save edits made to Event object
                eventsDataSource.editEvent(event!, editedEvent: editedEvent, lineupToUse: lineupToUse)
            case "deleteExistingEvent":
                // Grab reference to sourceVC
                let source = segue.sourceViewController as! EventDisplayViewController
                eventsDataSource.deleteEvent(source.event!)                 // delete event
                source.event = nil                                          // set event in EventDisplayVC to nil
            default:
                print("No one loves \(identifier)")
            }
            upcomingTableView.reloadData()
        }
    }
    
    // Set dataSource and delegate to self and reload data
    override func viewDidLoad() {
        super.viewDidLoad()
        
        upcomingTableView.dataSource = self                                 // declare dataSource for upcomingTV
        upcomingTableView.delegate = self                                   // declare delegate for upcomingTV
        upcomingTableView.reloadData()                                      // reload data
    }
    
    // Each time view appears, initialize eventsToBeDisplayed and populate array with events that have
    // yet to happened
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        eventsToBeDisplayed = [Event]()                                     // initialize array
        let currentTime = NSDate()                                          // get current time
        
        // For each event in eventsDS, compare to current time and if event has not passed, append into
        // the array so table view gets populated from most recent event to latest
        for event in eventsDataSource.events! {
            if event.dateTime.compare(currentTime) ==  NSComparisonResult.OrderedDescending {
                eventsToBeDisplayed?.append(event)                          // append to end of array
            }
        }
        upcomingTableView.reloadData()                                      // reload upcomingTV data
    }
    
    // MARK: Navigation
    // Prepare for respective segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // If performing showExistingEvent, get destinationVC and set event to selectedEvent
        if (segue.identifier == "showExistingEvent") {
            // Grab a reference to PastDisplayVC
            let eventViewController = segue.destinationViewController as! EventDisplayViewController
            eventViewController.event = selectedEvent                       // set event in EventDisplayVC to selectedEvent
            var selectedEventEditedLineupArray = Array<LineupNS>()
            for lineup in selectedEvent!.lineupList {
                let lineupNS = LineupNS()
                lineupNS.name = lineup.name
                lineupNS.confirmed = lineup.confirmed
                selectedEventEditedLineupArray.append(lineupNS)
            }
            eventViewController.editedLineupArray = selectedEventEditedLineupArray         // initialize editedLineupArray in EventDisplayVC
        }
    }
    
    // MARK: UITableViewDataSource
    // Set Event object to be displayed in each UpcomingVC
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Get a reusable TVC object for UpcomingEventCell and add to upcomingTV
        let cell = upcomingTableView.dequeueReusableCellWithIdentifier("UpcomingEventCell", forIndexPath: indexPath) as! UpcomingTableViewCell
        let row = indexPath.row                                             // get row
        let event = (eventsToBeDisplayed?[row])! as Event                   // get Event object from eventsToBeDisplayed at row index
        cell.event = event                                                  // set event prop for cell to event
        return cell                                                         // return cell
    }
    
    // Get the number of rows in upcomingTV
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsToBeDisplayed?.count ?? 0                              // return total number of events in eventsToBeDisplayed or 0 if empty
    }
    
//    // Delete Event object at specified row
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {                                        // if editingStyle is Delete
//            let event = (eventsToBeDisplayed?[indexPath.row])! as Event     // get Event object at row index from eventsToBeDisplayed
//            dataSource.deleteEvent(event)                                   // delete event
//            tableView.reloadData()                                          // reload eventTV
//        }
//    }
    
    // MARK: UITableViewDelegate
    // Set selectedEvent when a TVC is selected
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedEvent = eventsToBeDisplayed?[indexPath.row]                 // set selectedEvent to Event at row index from eventsToBeDsiplayed
        self.performSegueWithIdentifier("showExistingEvent", sender: self)  // perform showExistingEvent segue
    }
}