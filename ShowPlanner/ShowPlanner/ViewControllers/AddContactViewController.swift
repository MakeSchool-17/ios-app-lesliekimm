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
    @IBOutlet weak var addContactContainer: UIView!
    
    var currentContact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
}
