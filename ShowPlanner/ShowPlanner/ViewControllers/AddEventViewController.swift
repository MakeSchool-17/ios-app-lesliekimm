//
//  AddEventViewController.swift
//  Show Planner
//
//  Created by Leslie Kim on 11/22/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {
    var eventToAdd: Event?
    var currentEvent: Event?
    var eventDisplay: EventDisplayViewController?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true
        self.eventDisplay = self.childViewControllers[0] as? EventDisplayViewController
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
    
    // MARK: Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "showNewEvent") {
            currentEvent = Event()
            let eventViewController = segue.destinationViewController as! EventDisplayViewController
            eventViewController.event = currentEvent
            eventViewController.addNew = true
        }
        if (segue.identifier == "addNewEvent") {
            eventToAdd = Event()
            eventToAdd!.name = self.eventDisplay!.nameTextField.text!
            eventToAdd!.location = self.eventDisplay!.locationTextField.text!
            var lineupText = ""
            for x in self.eventDisplay!.stringLineup {
                lineupText = lineupText + x + " "
            }
            eventToAdd!.lineup = lineupText
            eventToAdd!.dateTime = self.eventDisplay!.datePicker.date
        }
    }
}
