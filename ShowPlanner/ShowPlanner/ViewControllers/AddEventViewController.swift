//
//  AddEventViewController.swift
//  Show Planner
//
//  Created by Leslie Kim on 12/13/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {
    var event: Event?                                                       // optional contact var set in prepareForSegue
    var eventDisplay: EventDisplayViewController?                           // optional VC to access ContactDisplayVC
    
    // Set the view every time it appears
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true                         // hide tab bar controller in this VC
        
        // Get the first child VC and assign to eventDisplay to gain access to props in EventDisplayVC
        eventDisplay = self.childViewControllers[0] as? EventDisplayViewController
    }
    
    // Set the view every time it disappears
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false                        // unhide tab bar controller when leaving this VC
    }
    
    // MARK: - Navigation
    // Set contact to respective Event object depending on segue being performed
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // If performing showNewEvent, initialize Event object and pass object to EventDisplayVC
        if (segue.identifier == "showNewEvent") {
            event = Event()                                                 // initialize event
            // Grab a reference to ContactDisplayVC
            let eventViewController = segue.destinationViewController as! EventDisplayViewController
            eventViewController.event = event                               // set event in EventDisplayVC to initialized event
            eventViewController.addNew = true                               // set addNew in EventDisplayVC to true
        }
        // If performing saveNewEvent, initialize Event object and set props to corresponding textfield inputs
        // from EventDisplayVC
        if (segue.identifier == "saveNewEvent") {
            let eventViewController = eventDisplay!                         // grab a reference to EventDisplayVC
            event = Event()                                                 // initialize event
            event!.name = eventViewController.eventNameTextField.text!      // set name prop of event
            event!.location = eventViewController.locationTextField.text!   // set location prop of event
            event!.dateTime = eventViewController.datePicker.date           // set dateTime prop of event
            
            for lineup in (eventViewController.event?.lineupList)! {        // for each Lineup object in lineupList
                event!.lineupList.append(lineup)                            // append to event lineupList
            }
        }
    }

}
