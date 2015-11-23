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
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var lineupTableView: UITableView!

    var event: Event? {
        didSet {
            displayEvent(event)
        }
    }
    var lineup: Results<Performer>! {
        didSet {
            lineupTableView?.reloadData()
        }
    }
    var selectedPerformer: Performer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineupTableView.dataSource = self
        
        let myPerformer = Performer()
        myPerformer.name = "bill burr"
        myPerformer.host = false
        myPerformer.confirmed = false
        
        do {
            let realm = try Realm()
            try realm.write() {
                realm.add(myPerformer)
            }
            // 1
            lineup = realm.objects(Performer)
        } catch {
            print("handle error")
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        displayEvent(event)
    }

//    override func viewWillDisappear(animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        saveEvent()
//    }
    
    func displayEvent(event: Event?) {
        if let event = event, nameTextField = nameTextField, datePicker = datePicker, locationTextField = locationTextField {
            nameTextField.text = event.name
            datePicker.date = event.dateTime
            locationTextField.text = event.location
        }
    }
    
    func saveEvent() {
        if let event = event {
            do {
                let realm = try Realm()
                
                try realm.write {
                    if (event.name != self.nameTextField.text || event.dateTime != self.datePicker.date || event.location != self.locationTextField.text) {
                        event.name = self.nameTextField.text!
                        event.dateTime = self.datePicker.date
                        event.location = self.locationTextField.text!
                        event.lineup = "Kevin Nealon, Iliza Shlesinger, Moshe Kasher, Jerrod Carmichael, Bill Burr, Sarah Silverman"
                        event.confirmed = "Not confirmed"
                    }
                }
            }
            catch {
                print("ERROR")
            }
        }
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LineupCell", forIndexPath: indexPath) as! LineupTableViewCell
//        cell.lineupNameLabel.text = "aries spears"
//        cell.hostLabel.text = ""
//        cell.confirmedLabel.text = "x"
        let row = indexPath.row
        let performer = lineup[row] as Performer
        cell.performer = performer
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lineup?.count ?? 0
    }
}
