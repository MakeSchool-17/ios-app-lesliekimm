//
//  PastViewController.swift
//  ShowPlanner
//
//  Created by Leslie Kim on 11/13/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit
import RealmSwift

class PastViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var pastTableView: UITableView!              // code connection to PastShowsTV
    var dataSource = EventsDataSource()                         // reference to EventsDataSource
    var selectedEvent: Event?                                   // selected event
    var eventsToBeDisplayed: [Event]?                           // array of events to display on PastVC
    
    // Depending on segue identifier, perform an action
    @IBAction func backToPastVC(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {                  // grab reference to segue identifier
            switch identifier {
            case "savePastEvent":                               // if savePastEvent segue
                // Grab reference to sourceVC
                let source = segue.sourceViewController as! PastDisplayViewController
                let event = source.event                        // set event to event from PastDisplayVC
                // TODO: Rewrite this to do all saving logic in EventsDataSource
                if let event = event {
                    do {
                        let realm = try Realm()
                        
                        try realm.write {
                            if (event.notes != source.notesTextView.text && source.notesTextView.text != "Notes") {
                                event.notes = source.notesTextView.text
                            }
                            if (source.notesTextView.text == "Notes") {
                                event.notes = ""
                            }
                        }
                    }
                    catch {
                        print("ERROR")
                    }
                }
            default:
                print("No one loves \(identifier)")             // print log message
            }
            pastTableView.reloadData()                          // reload pastTV data
        }
    }
    
    // Set dataSource and delegate to self and reload data
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pastTableView.dataSource = self                         // declare dataSource for pastTV
        pastTableView.delegate = self                           // declare delegate for pastTV
        pastTableView.reloadData()                              // reload data
    }
    
    // Each time view appears, initialize eventsToBeDisplayed and populate array with events that have
    // already happened
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        eventsToBeDisplayed = [Event]()                         // initialize array
        let currentTime = NSDate()                              // get current time
        
        // For each event in EventsDataSource, compare to current time and if event has passed, insert
        // into the beginnig of the array so table view gets populated from most recent event to oldest
        for event in dataSource.events! {
            if event.dateTime.compare(currentTime) ==  NSComparisonResult.OrderedAscending {
                eventsToBeDisplayed?.insert(event, atIndex: 0)  // insert at the beginning of the array
            }
        }
        pastTableView.reloadData()                              // reload pastTV data
    }
    
    // MARK: Navigation
    // Prepare for respective segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // If performing showPastEvent, get destinationVC and set event to selectedEvent
        if (segue.identifier == "showPastEvent") {
            // Grab a reference to PastDisplayVC
            let eventViewController = segue.destinationViewController as! PastDisplayViewController
            eventViewController.event = selectedEvent           // set event in PastDisplayVC to selectedEvent
        }
    }
    
    // MARK: UITableViewDataSource
    // Set Event object to be displayed in each PastTVC
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Get a reusable TVC object for PastEventCell and add to pastTV
        let cell = pastTableView.dequeueReusableCellWithIdentifier("PastEventCell", forIndexPath: indexPath) as! PastTableViewCell
        let row = indexPath.row                                 // get row
        let event = (eventsToBeDisplayed?[row])! as Event       // get Event object from eventsToBeDisplayed at row index
        cell.event = event                                      // set event prop for cell to event
        return cell                                             // return cell
    }
    
    // Get the number of rows in pastTV
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsToBeDisplayed?.count ?? 0                  // return total number of events in eventsToBeDisplayed or 0 if empty
    }
    
    // MARK: UITableViewDelegate
    // Set selectedEvent when a TVC is selected
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedEvent = eventsToBeDisplayed?[indexPath.row]             // set selectedEvent to Event at row index from eventsToBeDsiplayed
        self.performSegueWithIdentifier("showPastEvent", sender: self)  // perform showPastEvent segue
    }
}
