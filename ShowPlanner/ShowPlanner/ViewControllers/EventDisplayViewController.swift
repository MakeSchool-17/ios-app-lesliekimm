//
//  EventDisplayViewController.swift
//  Show Planner
//
//  Created by Leslie Kim on 11/22/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class EventDisplayViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var lineupTableView: UITableView!

    @IBAction func backToEventDisplayVC(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            switch identifier {
            case "saveLineup":
                print("Save lineup")
                let source = segue.sourceViewController as! SelectLineupViewController
                lineup.append(source.selectedContact!)
            default:
                print("No one loves \(identifier)")
            }
        }
    }

    var event: Event? {
        didSet {
            displayEvent(event)
        }
    }
    var lineup = [Contact]() {
        didSet {
            lineupTableView?.reloadData()
        }
    }
    var selectedLineup: Lineup?
    var stringLineup: [String] = []
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true
        
        navItem.title = event!.name
        lineupTableView.dataSource = self
        displayEvent(event)
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
//        saveEvent()
    }
    
    func displayEvent(event: Event?) {
        if let event = event, nameTextField = nameTextField, datePicker = datePicker, locationTextField = locationTextField {
            nameTextField.text = event.name
            datePicker.date = event.dateTime
            locationTextField.text = event.location
        }
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LineupCell", forIndexPath: indexPath) as! LineupTableViewCell
        let row = indexPath.row
        let contact = lineup[row] as Contact
        cell.contact = contact

        
        stringLineup.insert(cell.lineupNameLabel.text!, atIndex: indexPath.row)

        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lineup.count ?? 0
    }
}
