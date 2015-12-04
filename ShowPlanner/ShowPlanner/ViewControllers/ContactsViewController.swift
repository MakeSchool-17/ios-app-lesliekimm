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
    @IBOutlet weak var contactsTableView: UITableView!
    
    var dataSource = ContactsDataSource()
    var selectedContact: Contact?
    var contacts = [CNContact]()
    
    @IBAction func backToContactsVC(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            switch identifier {
            case "contactSaveSegue":
                let source = segue.sourceViewController as! AddContactViewController
                let contactToAdd = source.contactToAdd
                dataSource.addContact(contactToAdd!)
            case "trashContactSegue":
                let source = segue.sourceViewController as! ContactDisplayViewController
                dataSource.trashContact(selectedContact!)
                source.contact = nil
            case "saveContact":
                let source = segue.sourceViewController as! ContactDisplayViewController
                let contact = source.contact
                if let contact = contact {
                    do {
                        let realm = try Realm()
                        
                        try realm.write {
                            if (contact.name != source.nameLabel.text || contact.email != source.emailLabel.text || contact.cell != source.cellLabel.text) {
                                contact.name = source.nameLabel.text!
                                contact.email = source.emailLabel.text!
                                contact.cell = source.cellLabel.text!
                            }
                        }
                    }
                    catch {
                        print("Error in saveContact")
                    }
                }
                dataSource.saveContact(source.contact!)
            default:
                print("No one loves \(identifier)")
            }
            contactsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsTableView.dataSource = self
        contactsTableView.delegate = self
        contactsTableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        contactsTableView.reloadData()
    }
    
    // MARK: Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "showExistingContactSegue") {
            let contactViewController = segue.destinationViewController as! ContactDisplayViewController
            contactViewController.contact = selectedContact
        }
        if (segue.identifier == "importSegue") {
            let importViewController = segue.destinationViewController as! ImportViewController
            importViewController.delegate = self
        }
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactCell") as! ContactTableViewCell
        let row = indexPath.row
        let contact = dataSource.contacts[row] as Contact
        cell.contact = contact
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.contacts?.count ?? 0
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let contact = dataSource.contacts[indexPath.row] as Contact
            dataSource.trashContact(contact)
            tableView.reloadData()
        }
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedContact = dataSource.contacts[indexPath.row]
        self.performSegueWithIdentifier("showExistingContactSegue", sender: self)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // MARK: ImportContactViewControllerDelegate
    func didFetchContacts(contactsToAppend: [Contact]) {
        for contact in contactsToAppend {
            dataSource.addContact(contact)
        }
        
        contactsTableView.reloadData()
    }
    
    func didFetchCNContacts(contacts: [CNContact]) {
        for contact in contacts {
            self.contacts.append(contact)
        }
        
//        tblContacts.reloadData()
    }
}
