//
//  SelectLineupViewController.swift
//  Show Planner
//
//  Created by Leslie Kim on 12/13/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class SelectLineupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var selectLineupTableView: UITableView!                  // code connection to selectLineupTV
    
    var contactsDataSource = ContactsDataSource()                           // grab contactsDS
    var contactsToSelectFrom: [LineupNS]?                                   // optional LineupNS Array
    var selectedLineup: LineupNS?                                           // grab reference to selected LineupNS from selectLineupTV
    var lineupNSArray: [LineupNS]?                                          // optional LineupNS Array of LineupNS objects for each time you select
    var event: Event?                                                       // optional event to hold event info from EventDisplayVC

    // Set the view when loaded for the first time
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectLineupTableView.dataSource = self                             // declare dataSource for selectLineupTV
        selectLineupTableView.delegate = self                               // declare delegate for selectLineupTV
        selectLineupTableView.reloadData()                                  // reload data
        
        contactsToSelectFrom = [LineupNS]()                                 // initialize contactsToSelectFrom
        
        // Iterate through ContactsDS and add to contactsToSelectFrom as LineupNS objects
        for contact in contactsDataSource.contacts {
            let lineupSelection = LineupNS()                                // initialize LineupNS object
            lineupSelection.name = contact.name                             // set lineupSelection name to contact name
            contactsToSelectFrom?.append(lineupSelection)                   // append to contactsToSelectFrom
        }
        
        lineupNSArray = [LineupNS]()                                        // initialize lineupNSArray
    }
    
    // Set the view every time it appears
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.hidden = true                         // hide tab bar controller in this VC
        
        selectLineupTableView.reloadData()                                  // reload selectLineupTV data
    }
    
    // MARK: Navigation
    // Prepare for respective segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // If performing saveLineup, get destinationVC and set lineupToAdd to lineup
        if (segue.identifier == "saveLineup") {
            // Grab a reference to ContactDisplayVC
            let eventDisplayViewController = segue.destinationViewController as! EventDisplayViewController
            
            // Iterate through contactsToSelectFrom and add selected LineupNS objects to lineupNSArray
            for lineupNS in contactsToSelectFrom! {
                if lineupNS.selected {                                      // if lineupNS is selected
                    lineupNSArray!.append(lineupNS)                         // add lineupNS to lineupNSArray
                }
            }
            
            eventDisplayViewController.lineupNSToAddArray = lineupNSArray   // set eventDisplayVC lineupNSToAddArray to lineupNSArray
        }
    }
    
    // MARK: UITableViewDataSource
    // Set Contact object to be displayed in each SelectLineupTVC
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Get a reusable TVC object for SelectLineupCell and add to selectLineupTV
        let cell = selectLineupTableView.dequeueReusableCellWithIdentifier("SelectLineupCell") as! SelectLineupTableViewCell
        let row = indexPath.row                                             // get row
        let lineupNS = contactsToSelectFrom![row] as LineupNS               // get LineupNS object from contactsToSelectFrom at row index
        cell.lineupNS = lineupNS                                            // set lineupNS prop for cell to lineupNS
        return cell                                                         // return cell
    }
    
    // Get the number of rows in selectLineupTV
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsDataSource.contacts.count ?? 0                       // return total number of contacts in contactsDataSource or 0 if empty
    }
    
    // MARK: UITableViewDelegate
    // Create Lineup object with the selectedContact name
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedLineup = contactsToSelectFrom![indexPath.row]               // set selectedLineup to Lineup object from contactsToSelectFrom at row
        
        if selectedLineup!.selected {                                       // if selectedLineup is selected
            contactsToSelectFrom![indexPath.row].selected = false           // set LineupNS object selected prop at row to false
        }
        else {                                                              // if selected lineup is not selected
            contactsToSelectFrom![indexPath.row].selected = true            // set LineupNS object selected prop at row to true
        }
        
        selectLineupTableView.reloadData()                                  // reload selectLineupTV data
    }
}
