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
    
    @IBAction func backToContactsVC(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            switch identifier {
            case "saveNewContact":
                let source = segue.sourceViewController as! AddContactViewController
                let contactToAdd = source.contactToAdd
                contactsDataSource.addContact(contactToAdd!)
            case "saveExistingContact":
                let source = segue.sourceViewController as! ContactDisplayViewController
                let contact = source.contact
                if let contact = contact {
                    do {
                        let realm = try Realm()
                        
                        try realm.write {
                            if (contact.name != source.nameTextField.text || contact.email != source.emailTextField.text || contact.cell != source.cellTextField.text) {
                                contact.name = source.nameTextField.text!
                                contact.email = source.emailTextField.text!
                                contact.cell = source.cellTextField.text!
                            }
                        }
                    }
                    catch {
                        print("Error in saveContact")
                    }
                }
            case "deleteExistingContact":
                let source = segue.sourceViewController as! ContactDisplayViewController
                contactsDataSource.deleteContact(selectedContact!)
                source.contact = nil
            default:
                print("No one loves \(identifier)")
            }
            contactsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactsTableView.dataSource = self                 // declare dataSource for contactsTV
        contactsTableView.delegate = self                   // declare delegate for contactsTV
        contactsTableView.reloadData()                      // reload data
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        contactsTableView.reloadData()                      // reload data
    }
    
    // MARK: Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "showExistingContact") {
            let contactViewController = segue.destinationViewController as! ContactDisplayViewController
            contactViewController.contact = selectedContact
        }
        if (segue.identifier == "showImportVC") {
            let importViewController = segue.destinationViewController as! ImportViewController
            importViewController.delegate = self
        }
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactCell") as! ContactTableViewCell
        let row = indexPath.row
        let contact = contactsDataSource.contacts[row] as Contact
        cell.contact = contact
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsDataSource.contacts?.count ?? 0
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let contact = contactsDataSource.contacts[indexPath.row] as Contact
            contactsDataSource.deleteContact(contact)
            tableView.reloadData()
        }
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedContact = contactsDataSource.contacts[indexPath.row]
        self.performSegueWithIdentifier("showExistingContact", sender: self)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // MARK: ImportContactViewControllerDelegate
    func didFetchContacts(contactsToAppend: [Contact]) {
        for contact in contactsToAppend {
            contactsDataSource.addContact(contact)
        }
        
        contactsTableView.reloadData()
    }
    
    func didFetchCNContacts(contacts: [CNContact]) {
        for contact in contacts {
            self.contacts.append(contact)
        }
    }
}
