//
//  ContactsViewController.swift
//  Show Planner
//
//  Created by Leslie Kim on 12/2/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit
import RealmSwift
import Contacts

class ContactsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ImportContactViewControllerDelegate {
    @IBOutlet weak var contactsTableView: UITableView!      // code connection to table view
    var contactsDataSource = ContactsDataSource()           // grab contacts data source
    var selectedContact: Contact?                           // grab reference to selected contact from contactTV
    var contacts = [CNContact]()                            // array of CNContact objects to hold CNContact objects
    
    // Depending on segue identifier, perform an action
    @IBAction func backToContactsVC(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {                          // grab reference to segue identifier
            switch identifier {
            case "saveNewContact":                                      // if saveNewContact segue
                // Grab reference to source VC
                let source = segue.sourceViewController as! AddContactViewController
                contactsDataSource.addContact(source.contact!)          // add contact
            case "saveExistingContact":                                 // if saveExistingContact segue
                // Grab reference to source VC
                let source = segue.sourceViewController as! ContactDisplayViewController
                let contact = source.contact                            // set contact to contact from ContactDisplayVC
                let editedContact = Contact()                           // initialize new Contact objbect
                
                // If nameTextField from ContactDisplayVC is not placeholder text, set editedContact name prop
                if source.nameTextField.text != "Full Name" {
                    editedContact.name = source.nameTextField.text!     // set to namteTextField text
                }
                else {
                    editedContact.name = ""                             // set to empty string
                }
                
                // If emailTextField from ContactDisplayVC is not placeholder text, set editedContact email prop
                if source.emailTextField.text != "Email" {
                    editedContact.email = source.emailTextField.text!   // set to emailTextField text
                }
                else {
                    editedContact.email = ""                            // set to empty string
                }
                
                // If cellTextField from ContactDisplayVC is not placeholder text, set editedContact cell prop
                if source.cellTextField.text != "Cell Phone" {
                    editedContact.cell = source.cellTextField.text!     // set to cellTextField text
                }
                else {
                    editedContact.cell = ""                             // set to empty string
                }
                
                // Save edits made to Contact object
                contactsDataSource.editContact(contact!, editedContact: editedContact)
            case "deleteExistingContact":                               // if deleteExistingContact segue
                // Grab reference to sourceVC
                let source = segue.sourceViewController as! ContactDisplayViewController
                contactsDataSource.deleteContact(source.contact!)       // delete contact
                source.contact = nil                                    // set contact in ContactDisplayVC to nil
            default:
                print("No one loves \(identifier)")
            }
            contactsTableView.reloadData()                              // reload contactsTV data
        }
    }
    
    // Set the view when loaded for the first time
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactsTableView.dataSource = self                 // declare dataSource for contactsTV
        contactsTableView.delegate = self                   // declare delegate for contactsTV
        contactsTableView.reloadData()                      // reload data
    }
    
    // Set the view every time it appears
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        contactsTableView.reloadData()                      // reload data
    }
    
    // MARK: Navigation
    // Prepare for respective segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // If performing showExistingContact, get destination VC and set contact to selectedContact
        if (segue.identifier == "showExistingContact") {
            // Grab a reference to ContactDisplayVC
            let contactViewController = segue.destinationViewController as! ContactDisplayViewController
            contactViewController.contact = selectedContact             // set contact in ContactDisplayVC to selectedContact
        }
        // If performing showImportVC, get destinationVC and set delegate
        if (segue.identifier == "showImportVC") {
            // Grab a reference to ImportVC
            let importViewController = segue.destinationViewController as! ImportViewController
            importViewController.delegate = self                        // set ImportVC delegate to self
        }
    }
    
    // MARK: UITableViewDataSource
    // Set Contact object to be displayed in teach ContactTableViewCell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Get a reusable TVC object for ContactCell and add to contactsTV
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactCell") as! ContactTableViewCell
        let row = indexPath.row                                         // get row
        let contact = contactsDataSource.contacts[row] as Contact       // get Contact object from contactsDS at row index
        cell.contact = contact                                          // set contact prop for cell to contact
        return cell                                                     // return cell
    }
    
    // Get the number of rows in contactsTV
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsDataSource.contacts?.count ?? 0      // return total number of contacts in contactsDS or 0 if empty
    }
    
    // Delete Contact object at specified row
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {                                                // if editingStyle is Delete
            let contact = contactsDataSource.contacts[indexPath.row] as Contact     // get Contact object at row index from contactsDS
            contactsDataSource.deleteContact(contact)                               // delete contact
            tableView.reloadData()                                                  // reload contactsTV
        }
    }
    
    // MARK: UITableViewDelegate
    // Set selectedContact when a TVC is selected
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedContact = contactsDataSource.contacts[indexPath.row]            // set selectedContact to Contact at row index from contactsDS
        self.performSegueWithIdentifier("showExistingContact", sender: self)    // perform showExistingContact segue
    }
    
    // MARK: ImportContactViewControllerDelegate
    // Add contacts to contactsDS
    func didFetchContacts(contactsToAppend: [Contact]) {
        for contact in contactsToAppend {               // for each Contact in contactsToAppend
            contactsDataSource.addContact(contact)      // add contact to contactsDS
        }
        
        contactsTableView.reloadData()                  // reload contactsTV data
    }
    
    // Add contacts as CNContact objects to contacts array
    func didFetchCNContacts(contacts: [CNContact]) {
        for contact in contacts {                       // for each CNContact in contacts
            self.contacts.append(contact)               // add to contacts
        }
    }
}
