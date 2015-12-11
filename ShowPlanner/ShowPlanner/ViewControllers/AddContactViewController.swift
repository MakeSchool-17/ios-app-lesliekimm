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
    var contactToAdd: Contact?                          // optional contactToAdd var (used in ContactsVC)
    var currentContact: Contact?                        // optional currentContact var (used in showNewContact
    var contactDisplay: ContactDisplayViewController?   // optional VC to access ContactDisplayVC
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true     // hide tab bar controller in this VC
        
        // Get the first child VC and assign to contactDisplay to gain access to props in ContactDisplayVC
        self.contactDisplay = self.childViewControllers[0] as? ContactDisplayViewController
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false    // unhide tab bar controller when leaving this VC
    }

    // MARK: - Navigation
    // Set currentContact if displaying ContactDisplayVC for new Contact object
    // Set contactToAdd if saving new Contact object
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // If performing showNewContact, create new Contact object and pass object to ContactDisplayVC
        if (segue.identifier == "showNewContact") {
            currentContact = Contact()                          // initialize currentContact
            // Grab a reference to ContactDisplayVC
            let contactViewController = segue.destinationViewController as! ContactDisplayViewController
            contactViewController.contact = currentContact      // set contact in ContactDisplayVC to currentContact
            contactViewController.addNew = true
        }
        // If performing saveNewContact, create new Contact object and set contact props to text field inputs in
        // ContactDisplayVC
        if (segue.identifier == "saveNewContact") {
            let contactViewController = self.contactDisplay!    // grab a reference to ContactDisplayVC
            contactToAdd = Contact()                            // initialize contactToAdd
            contactToAdd!.name = contactViewController.nameTextField.text!      // set name prop of contactToAdd
            contactToAdd!.email = contactViewController.emailTextField.text!    // set email prop of contactToAdd
            contactToAdd!.cell = contactViewController.cellTextField.text!      // set cell prop of contactToAdd
        }
    }
}
