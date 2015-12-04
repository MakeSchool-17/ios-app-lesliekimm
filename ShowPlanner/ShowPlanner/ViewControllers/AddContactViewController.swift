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
    var contactToAdd: Contact?
    var currentContact: Contact?
    var contactDisplay: ContactDisplayViewController?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true
        self.contactDisplay = self.childViewControllers[0] as? ContactDisplayViewController
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController
        // Pass the selected object to the new view controller
        
        if (segue.identifier == "showNewContact") {
            /// create a new Contact and hold onto it, to be able to save it later
            currentContact = Contact()
            let contactViewController = segue.destinationViewController as! ContactDisplayViewController
            contactViewController.contact = currentContact
        }
        if (segue.identifier == "contactSaveSegue") {
            contactToAdd = Contact()
            contactToAdd!.name = self.contactDisplay!.nameLabel.text!
            contactToAdd!.email = self.contactDisplay!.emailLabel.text!
            contactToAdd!.cell = self.contactDisplay!.cellLabel.text!
        }
    }
}
