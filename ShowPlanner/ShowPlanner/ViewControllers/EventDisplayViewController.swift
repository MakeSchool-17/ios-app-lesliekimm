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

class EventDisplayViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var locationTextField: UITextField!
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

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        saveEvent()
    }
    
    func displayEvent(event: Event?) {
        if let event = event, nameTextField = nameTextField, locationTextField = locationTextField {
            nameTextField.text = event.name
            locationTextField.text = event.location
        }
    }
    
    func saveEvent() {
        if let event = event {
            do {
                let realm = try Realm()
                
                try realm.write {
                    if (event.name != self.nameTextField.text || event.location != self.locationTextField.text) {
                        event.name = self.nameTextField.text!
                        event.location = self.locationTextField.text!
                        event.lineup = "Kevin Nealon, Iliza Shlesinger, Moshe Kasher, Jerrod Carmichael, Bill Burr, Sarah Silverman"
                    }
                }
            }
            catch {
                print("ERROR")
            }
        }
    }
}
