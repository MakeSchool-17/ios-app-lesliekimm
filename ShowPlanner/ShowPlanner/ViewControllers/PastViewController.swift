//
//  PastViewController.swift
//  ShowPlanner
//
//  Created by Leslie Kim on 11/13/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class PastViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var pastTableView: UITableView!              // code connection to PastShows TV
    var dataSource = EventsDataSource()                         // reference to EventsDataSource
    var selectedEvent: Event?                                   // selected event
    var eventsToBeDisplayed: [Event]?                           // array of events to display on PastVC
    
    // Set dataSource and delegate to self, reload data and don't allow cells to be selected
    override func viewDidLoad() {
        super.viewDidLoad()
        pastTableView.dataSource = self
        pastTableView.delegate = self
        pastTableView.reloadData()
        pastTableView.allowsSelection = false
    }
    
    // Each time view appears, initialize eventsToBeDisplayed and populate array with events that have
    // already happened
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        eventsToBeDisplayed = [Event]()                         // initialize array
        let currentTime = NSDate()                              // get current time
        
        // For each event in EventsDataSource, compare to current time and if event has passed, insert
        // into the beginnig of the array so table view gets populated from most recent event to oldest
        for event in dataSource.events {
            if event.dateTime.compare(currentTime) ==  NSComparisonResult.OrderedAscending {
                eventsToBeDisplayed?.insert(event, atIndex: 0)
            }
        }
        pastTableView.reloadData()                              // reload data
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Get each cell of pastTableView and populate with events in eventsToBeDisplayed array
        let cell = tableView.dequeueReusableCellWithIdentifier("PastEventCell") as! PastTableViewCell
        let event = (eventsToBeDisplayed?[indexPath.row])! as Event
        cell.event = event
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsToBeDisplayed?.count ?? 0                  // TV rows equals eventsToBeDisplayed count
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedEvent = eventsToBeDisplayed![indexPath.row]             // set selectedEvent
        self.performSegueWithIdentifier("showPastEvent", sender: self)  // show PastNotesVC for selectedEvent
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true                                             // rows can be edited
    }
}
