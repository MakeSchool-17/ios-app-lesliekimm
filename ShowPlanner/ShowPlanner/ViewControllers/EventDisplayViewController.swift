//
//  EventDisplayViewController.swift
//  ShowPlanner
//
//  Created by Leslie Kim on 11/19/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class EventDisplayViewController: UIViewController {
    @IBOutlet weak var eventNameLabel: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var locationLabel: UITextField!
    @IBOutlet weak var lineupTableView: UITableView!

    var event: Event? {
        didSet {
            displayEvent(event)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        displayEvent(event)
    }
    
    // MARK: Business Logic
    func displayEvent(event: Event?) {
        if let event = event, eventNameLabel = eventNameLabel, datePicker = datePicker, locationLabel = locationLabel, lineupTableView = lineupTableView {
            eventNameLabel.text = event.name
//            datePicker.date = event.dateTime
            locationLabel.text = event.location
//            lineupTableView.dataSource = self
//            lineupTableView.delegate = self
        }
    }
    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        <#code#>
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
//        <#code#>
//    }
//    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        <#code#>
//    }
//    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        <#code#>
//    }
    
//    @IBOutlet weak var eventNameLabel: UITextField!
//    @IBOutlet weak var datePicker: UIDatePicker!
//    @IBOutlet weak var locationLabel: UITextField!
//    @IBOutlet weak var lineupTableView: UITableView!
//    
//    @IBAction func datePickerAction(sender: UIDatePicker) {
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
//        var strDate = dateFormatter.stringFromDate(datePicker.date)
//        self.selectedDate = strDate
//    }
//    
//    var event: Event? {
//        didSet {
//            displayEvent(event)
//        }
//    }
//    var selectedDate: String?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        lineupTableView.dataSource = self
//        lineupTableView.delegate = self
//        
//        displayEvent(event)
//    }
//    
//    override func viewWillDisappear(animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        saveEvent()
//    }
//    
//    func displayEvent(event: Event?) {
//        if let event = event, eventNameLabel = eventNameLabel, datePicker = datePicker, locationLabel = locationLabel {
//            eventNameLabel.text = event.name
//            locationLabel.text = event.location
////            selectedDate = event.date
//        }
//    }
//    
//    func saveEvent() {
//        if let event = event {
//            do {
//                let realm = try Realm()
//                
//                try realm.write {
//                    if (event.name != self.eventNameLabel || event.location != self.locationLabel) {
//                        event.name = self.eventNameLabel.text!
//                        event.location = self.locationLabel.text!
////                        event.date = self.selectedDate!
//                    }
//                }
//            }
//            catch {
//                print("Error in saveEvent()")
//            }
//        }
//    }
//    
//    // MARK: UITableViewDataSource
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("LineupCell") as! LineupTableViewCell
//        print("Display cell")
//        return cell
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//    
//    // MARK: UITableViewDelegate
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        print("Select row")
//    }
//    
//    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }
//    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        print("Editing style")
//    }
}
