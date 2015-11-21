//
//  EventDisplayViewController.swift
//  ShowPlanner
//
//  Created by Leslie Kim on 11/19/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit
import RealmSwift

class EventDisplayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var eventNameLabel: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var locationLabel: UITextField!
    @IBOutlet weak var lineupTableView: UITableView!
    
    var event: Event? {
        didSet {
            displayEvent(event)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineupTableView.dataSource = self
        lineupTableView.delegate = self
    }
    
    func displayEvent(event: Event?) {
        if let event = event, eventNameLabel = eventNameLabel, datePicker = datePicker, locationLabel = locationLabel, lineupTableView = lineupTableView {
            eventNameLabel.text = event.name
            locationLabel.text = event.location
        }
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LineupCell") as! LineupTableViewCell
        print("Display cell")
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Select row")
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        print("Editing style")
    }
}
