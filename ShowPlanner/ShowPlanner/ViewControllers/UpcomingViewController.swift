//
//  UpcomingViewController.swift
//  Show Planner
//
//  Created by Leslie Kim on 12/13/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class UpcomingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var upcomingTableView: UITableView!              // code connection to UpcomingTV
    var dataSource = EventsDataSource()                         // reference to EventsDataSource
    var selectedEvent: Event?                                   // selected event
    var eventsToBeDisplayed: [Event]?                           // array of events to display on UpcomingVC
    
    @IBAction func backToUpcomingVC(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            switch identifier {
            case "savePastEvent":
                print("saveNewEvent")
            case "saveExistingEvent":
                print("saveExistingEvent")
            case "deleteExistingEvent":
                print("deleteExistingEvent")
            default:
                print("No one loves \(identifier)")
            }
            upcomingTableView.reloadData()
        }
    }
    
    // Set dataSource and delegate to self and reload data
    override func viewDidLoad() {
        super.viewDidLoad()
        
        upcomingTableView.dataSource = self                     // declare dataSource for upcomingTV
        upcomingTableView.delegate = self                       // declare delegate for upcomingTV
        upcomingTableView.reloadData()                          // reload data
    }
    
    // Each time view appears, initialize eventsToBeDisplayed and populate array with events that have
    // not yet happened
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        eventsToBeDisplayed = [Event]()                         // initialize array
        let currentTime = NSDate()                              // get current time
        
        // For each event in EventsDataSource, compare to current time and if event has not passed,
        // insert into the array so table view gets populated from most recent event to latest
        for event in dataSource.events! {
            if event.dateTime.compare(currentTime) ==  NSComparisonResult.OrderedDescending {
                eventsToBeDisplayed?.append(event)
            }
        }
        upcomingTableView.reloadData()                              // reload data
    }
    
    // MARK: Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showExistingEvent") {
//            let eventViewController = segue.destinationViewController as! EventDisplayViewController
//            eventViewController.event = selectedEvent
        }
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = upcomingTableView.dequeueReusableCellWithIdentifier("UpcomingEventCell", forIndexPath: indexPath) as! UpcomingTableViewCell
        let row = indexPath.row
        let event = (eventsToBeDisplayed?[row])! as Event
        cell.event = event
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsToBeDisplayed?.count ?? 0
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedEvent = eventsToBeDisplayed?[indexPath.row]
//        self.performSegueWithIdentifier("showExistingEvent", sender: self)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
}
