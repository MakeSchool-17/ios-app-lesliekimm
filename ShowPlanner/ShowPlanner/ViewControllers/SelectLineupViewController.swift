//
//  SelectLineupViewController.swift
//  Show Planner
//
//  Created by Leslie Kim on 12/13/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class SelectLineupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var selectLineupTableView: UITableView!
    var contactsDataSource = ContactsDataSource()                       // grab contactsDS
    var contactsToSelectFrom: [LineupSelection]?
    var selectedContact: LineupSelection?                                       // grab reference to selected contact from selectLineupTV
    var lineupNS: LineupNS?                                             // optional lineup var to convert selectedContact to Lineup object
    var lineupNSArray: [LineupNS]?
    var event: Event?

    // Set the view when loaded for the first time
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectLineupTableView.dataSource = self                         // declare dataSource for selectLineupTV
        selectLineupTableView.delegate = self                           // declare delegate for selectLineupTV
        selectLineupTableView.reloadData()                              // reload data
        
        lineupNSArray = [LineupNS]()
        
        contactsToSelectFrom = [LineupSelection]()
        for contact in contactsDataSource.contacts {
            var lineupSelection = LineupSelection()
            lineupSelection.name = contact.name
            
            contactsToSelectFrom?.append(lineupSelection)
        }
    }
    
    // Set the view every time it appears
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.hidden = true                     // hide tab bar controller in this VC
        
        selectLineupTableView.reloadData()                              // reload data
        
//        contactsToSelectFrom?.removeAll()
//        contactsToSelectFrom = [LineupSelection]()
//        for contact in contactsDataSource.contacts {
//            var lineupSelection = LineupSelection()
//            lineupSelection.name = contact.name
//            
//            contactsToSelectFrom?.append(lineupSelection)
//        }
    }
    
    // MARK: Navigation
    // Prepare for respective segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // If performing saveLineup, get destinationVC and set lineupToAdd to lineup
        if (segue.identifier == "saveLineup") {
            // Grab a reference to ContactDisplayVC
            let eventDisplayViewController = segue.destinationViewController as! EventDisplayViewController
//            eventDisplayViewController.lineupNSToAdd = lineupNS         // set lineup in EventDisplayVC to lineup
            eventDisplayViewController.lineupNSToAddArray = lineupNSArray
        }
    }
    
    // MARK: UITableViewDataSource
    // Set Contact object to be displayed in each SelectLineupTVC
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Get a reusable TVC object for SelectLineupCell and add to selectLineupTV
        let cell = selectLineupTableView.dequeueReusableCellWithIdentifier("SelectLineupCell") as! SelectLineupTableViewCell
        let row = indexPath.row                                         // get row
        let contact = contactsToSelectFrom![row] as LineupSelection     // get Contact object from contactsDS at row index
        cell.lineupSelection = contact                                          // set contact prop for cell to contact
        return cell                                                     // return cell
    }
    
    // Get the number of rows in selectLineupTV
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsDataSource.contacts?.count ?? 0                  // return total number of contacts in contactsDS or 0 if empty
    }
    
    // MARK: UITableViewDelegate
    // Create Lineup object with the selectedContact name
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedContact = contactsToSelectFrom![indexPath.row]          // set selectedContact to Contact object from contactsDS at row index
        if selectedContact!.selected {
            contactsToSelectFrom![indexPath.row].selected = false
        }
        else {
            contactsToSelectFrom![indexPath.row].selected = true
        }
        
        selectLineupTableView.reloadData()
        
        lineupNS = LineupNS()                                           // initialize Lineup object
        lineupNS!.name = (selectedContact?.name)!                       // set lineup name prop
        
        lineupNSArray?.append(lineupNS!)
        
//        self.performSegueWithIdentifier("saveLineup", sender: self)     // perform saveLineup segue
    }
}
