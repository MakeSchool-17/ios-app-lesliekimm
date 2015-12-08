//
//  HistoryViewController.swift
//  ShowPlanner
//
//  Created by Leslie Kim on 11/13/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var historyTableView: UITableView!
    
    var dataSource = EventsDataSource()
    var selectedEvent: Event?
    var eventsToBeDisplayed: [Event]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.dataSource = self
        historyTableView.delegate = self
        historyTableView.reloadData()
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
        historyTableView.reloadData()
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HistoryCell") as! HistoryTableViewCell
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
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
}
