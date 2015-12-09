//
//  EventDisplayViewController.swift
//  Show Planner
//
//  Created by Leslie Kim on 11/22/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//
// SOURCES:
// 1) Dismiss keyboard with UITapGestureRecognizer: http://stackoverflow.com/questions/24126678/close-ios-keyboard-by-touching-anywhere-using-swift

import Foundation
import UIKit
import RealmSwift

class EventDisplayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var lineupTableView: UITableView!

    @IBAction func backToEventDisplayVC(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            switch identifier {
            case "saveLineup":
                let source = segue.sourceViewController as! SelectLineupViewController
                do {
                    let realm = try Realm()
                    try realm.write() {
                        realm.add(source.selectedLineup!)
                    }
                }
                catch {
                    print("Error in saveLineup")
                }
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
    var lineupArray: Results<Lineup>! {
        didSet {
            lineupTableView?.reloadData()
        }
    }
    var selectedLineup: Lineup?
    var stringLineup: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize UITapGestureRecognizer
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)                      // add tap gesture to view
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true
        
        navItem.title = event!.name
        lineupTableView.dataSource = self
        lineupTableView.delegate = self
        displayEvent(event)
        
        do {
            let realm = try Realm()
            lineupArray = realm.objects(Lineup)
        }
        catch {
            print("Error in events init")                                       // print error message
        }
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
//        saveEvent()
    }
    
    // View will resign first responder status
    func dismissKeyboard() {
        view.endEditing(true)                               // dismiss keyboard
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
        let lineup = lineupArray[row] as Lineup
        cell.lineup = lineup

        
        stringLineup.insert(cell.lineupNameLabel.text!, atIndex: indexPath.row)

        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lineupArray?.count ?? 0
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let lineup = lineupArray[indexPath.row]
            do {
                let realm = try Realm()
                try realm.write() {
                    realm.delete(lineup)
                }
            }
            catch {
                print("Error in commitEditingStyle EventDisplayVC")
            }
            tableView.reloadData()
        }
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedLineup = lineupArray[indexPath.row]
        selectedLineup!.confirmed = true
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
}
