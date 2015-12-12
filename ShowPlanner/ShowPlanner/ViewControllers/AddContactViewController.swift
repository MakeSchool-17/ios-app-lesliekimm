//
//  AddContactViewController.swift
//  ShowPlanner
//
//  Created by Leslie Kim on 11/19/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit
import Contacts

class AddContactViewController: UIViewController {
    var contact: Contact?                               // optional contact var set in prepareForSegue
    var contactDisplay: ContactDisplayViewController?   // optional VC to access ContactDisplayVC
    
    // Set the view every time it appears
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true     // hide tab bar controller in this VC
        
        // Get the first child VC and assign to contactDisplay to gain access to props in ContactDisplayVC
        contactDisplay = self.childViewControllers[0] as? ContactDisplayViewController
    }
    
    // Set the view every time it disappears
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false    // unhide tab bar controller when leaving this VC
    }

    // MARK: - Navigation
    // Set contact to respective Contact object depending on segue being performed
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // If performing showNewContact, initialize Contact object and pass object to ContactDisplayVC
        if (segue.identifier == "showNewContact") {
            contact = Contact()                          // initialize contact
            // Grab a reference to ContactDisplayVC
            let contactViewController = segue.destinationViewController as! ContactDisplayViewController
            contactViewController.contact = contact      // set contact in ContactDisplayVC to initialized contact
            contactViewController.addNew = true          // set addNew in ContactDisplayVC to trueP
        }
        // If performing saveNewContact, initialize Contact object and set props to corresponding TextField inputs
        // from ContactDisplayVC
        if (segue.identifier == "saveNewContact") {
            let contactViewController = contactDisplay!                     // grab a reference to ContactDisplayVC
            contact = Contact()                                             // initialize contact
            contact!.name = contactViewController.nameTextField.text!       // set name prop of contactToAdd
            contact!.email = contactViewController.emailTextField.text!     // set email prop of contactToAdd
            contact!.cell = contactViewController.cellTextField.text!       // set cell prop of contactToAdd
        }
    }
}
