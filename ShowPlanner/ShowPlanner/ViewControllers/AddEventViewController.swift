//
//  AddEventViewController.swift
//  Show Planner
//
//  Created by Leslie Kim on 11/22/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {
    var currentEvent: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        }
        
//        currentEvent = Event()
//        currentEvent!.name = "KN Show"
//        currentEvent!.lineup = "Kevin Nealon, Iliza Shlesinger, Moshe Kasher, Jerrod Carmichael, Bill Burr, Sarah Silverman, Bobby Lee"
//        currentEvent!.location = "The Laugh Factory"
//        currentEvent!.dateTime = NSDate()
//        currentEvent!.confirmed = "Not Confirmed"
    }
}
