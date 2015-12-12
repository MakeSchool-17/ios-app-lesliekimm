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
    @IBOutlet weak var pastTableView: UITableView!              // code connection to PastShows TV
    var dataSource = EventsDataSource()                         // reference to EventsDataSource
    var selectedEvent: Event?                                   // selected event
    var eventsToBeDisplayed: [Event]?                           // array of events to display on PastVC
    
    @IBAction func backToPastVC(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            switch identifier {
            case "savePastEvent":
                let source = segue.sourceViewController as! PastDisplayViewController
                let event = source.event
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
                print("No one loves \(identifier)")
            }
            pastTableView.reloadData()
        }
    }
    
    // Set dataSource and delegate to self, reload data and don't allow cells to be selected
    override func viewDidLoad() {
        super.viewDidLoad()
        pastTableView.dataSource = self
        pastTableView.delegate = self
        pastTableView.reloadData()
//        pastTableView.allowsSelection = false
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
                eventsToBeDisplayed?.insert(event, atIndex: 0)
            }
        }
        pastTableView.reloadData()                              // reload data
    }
    
    // MARK: Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "showPastEvent") {
            let eventViewController = segue.destinationViewController as! PastDisplayViewController
            eventViewController.event = selectedEvent
        }
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = pastTableView.dequeueReusableCellWithIdentifier("PastEventCell", forIndexPath: indexPath) as! PastTableViewCell
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
        self.performSegueWithIdentifier("showPastEvent", sender: self)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
}
