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
    @IBOutlet weak var tableView: UITableView!
    
    var events: Results<Event>! {
        didSet {
            tableView?.reloadData()
        }
    }
    var selectedEvent: Event?
    
    @IBAction func backToUpcomingVC(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            do {
                let realm = try Realm()
                
                switch identifier {
                case "saveAddEvent":
                    let source = segue.sourceViewController as! AddEventViewController
                    try realm.write() {
                        realm.add(source.currentEvent!)
                    }
                case "deleteEvent":
                    try realm.write() {
                        realm.delete(self.selectedEvent!)
                    }
                    let source = segue.sourceViewController as! EventDisplayViewController
                    source.event = nil
                default:
                    print("No one loves \(identifier)")
                }
                
                events = realm.objects(Event).sorted("dateTime", ascending: true)
            }
            catch {
                print("Error in backToUpcomingVC")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        do {
            let realm = try Realm()
            events = realm.objects(Event).sorted("dateTime", ascending: true)
        }
        catch {
            print("Error in Upcoming viewDidLoad")
        }
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
        let event = events[row] as Event
        cell.event = event
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events?.count ?? 0
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedEvent = events[indexPath.row]
        self.performSegueWithIdentifier("showExistingEvent", sender: self)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let event = events[indexPath.row] as Object
            
            do {
                let realm = try Realm()
                try realm.write() {
                    realm.delete(event)
                }
                events = realm.objects(Event).sorted("dateTime", ascending: true)
            }
            catch {
                print("Error in commitEditingStyle")
            }
        }
    }
}
