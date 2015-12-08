//
//  PastViewController.swift
//  ShowPlanner
//
//  Created by Leslie Kim on 11/13/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class PastViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var pastTableView: UITableView!
    
    var dataSource = EventsDataSource()
    var selectedEvent: Event?
    var eventsToBeDisplayed: [Event]?
    
    @IBAction func backToPastVC(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            switch identifier {
            case "savePastEvent":
//                print("here")
//                let source = segue.sourceViewController as! EventDisplayViewController
//                let event = source.event
//                if let event = event {
//                    do {
//                        let realm = try Realm()
//                        
//                        try realm.write {
//                            if (event.name != source.nameTextField.text || event.dateTime != source.datePicker.date || event.location != source.locationTextField.text) {
//                                event.name = source.nameTextField.text!
//                                event.dateTime = source.datePicker.date
//                                event.location = source.locationTextField.text!
//                                var lineupText = ""
//                                for x in source.stringLineup {
//                                    lineupText = lineupText + x + " "
//                                }
//                                event.lineup = lineupText
//                            }
//                        }
//                    }
//                    catch {
//                        print("ERROR")
//                    }
//                }
                print("here")
            default:
                print("No one loves \(identifier)")
            }
            pastTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pastTableView.dataSource = self
        pastTableView.delegate = self
        pastTableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        eventsToBeDisplayed = [Event]()
        let currentTime = NSDate()
        for event in dataSource.events {
            if event.dateTime.compare(currentTime) ==  NSComparisonResult.OrderedAscending {
                eventsToBeDisplayed?.insert(event, atIndex: 0)
            }
        }
        pastTableView.reloadData()
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PastEventCell") as! PastTableViewCell
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
        selectedEvent = eventsToBeDisplayed![indexPath.row]
        self.performSegueWithIdentifier("showPastEvent", sender: self)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
}
