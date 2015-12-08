//
//  UpcomingViewController.swift
//  Show Planner
//
//  Created by Leslie Kim on 11/22/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit
import RealmSwift

class UpcomingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!          // code connection to Upcoming TV
    var dataSource = EventsDataSource()
    var selectedEvent: Event?
    var eventsToBeDisplayed: [Event]?
    
    @IBAction func backToUpcomingVC(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
                switch identifier {
                case "saveAddEvent":
                    let source = segue.sourceViewController as! AddEventViewController
                    let eventToAdd = source.eventToAdd
                    dataSource.addEvent(eventToAdd!)
                case "deleteEvent":
                    let source = segue.sourceViewController as! EventDisplayViewController
                    dataSource.trashEvent(selectedEvent!)
                    source.event = nil
                case "saveEvent":
                    print("here")
                    let source = segue.sourceViewController as! EventDisplayViewController
                    let event = source.event
                    if let event = event {
                            do {
                                let realm = try Realm()
                                
                                try realm.write {
                                    if (event.name != source.nameTextField.text || event.dateTime != source.datePicker.date || event.location != source.locationTextField.text) {
                                        event.name = source.nameTextField.text!
                                        event.dateTime = source.datePicker.date
                                        event.location = source.locationTextField.text!
                                        var lineupText = ""
                                        for x in source.stringLineup {
                                            lineupText = lineupText + x + " "
                                        }
                                        event.lineup = lineupText
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
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillDisappear(animated)
        eventsToBeDisplayed = [Event]()
        let currentTime = NSDate()
        for event in dataSource.events {
            if event.dateTime.compare(currentTime) ==  NSComparisonResult.OrderedDescending {
                eventsToBeDisplayed?.append(event)
            }
        }
        tableView.reloadData()
    }

    // MARK: Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "showExistingEvent") {
            let eventNoteController = segue.destinationViewController as! EventDisplayViewController
            eventNoteController.event = selectedEvent
        }
    }

    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath) as! EventTableViewCell
        let row = indexPath.row
        let event = (eventsToBeDisplayed?[row])! as Event
        cell.event = event
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsToBeDisplayed?.count ?? 0
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let event = (eventsToBeDisplayed?[indexPath.row])! as Event
            dataSource.trashEvent(event)
            tableView.reloadData()
        }
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedEvent = eventsToBeDisplayed?[indexPath.row]
        self.performSegueWithIdentifier("showExistingEvent", sender: self)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
}
