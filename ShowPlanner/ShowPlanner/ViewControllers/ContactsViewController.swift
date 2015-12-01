//
//  ContactsViewController.swift
//  ShowPlanner
//
//  Created by Leslie Kim on 11/19/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

// SOURCES: 1) Import contacts using Contacts framework
//             http://www.appcoda.com/ios-contacts-framework/

import UIKit
import RealmSwift
import Contacts

class ContactsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ImportContactViewControllerDelegate {
    @IBOutlet weak var contactsTableView: UITableView!
    
    var contacts = [CNContact]()
    var selectedContact: CNContact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsTableView.dataSource = self
        contactsTableView.delegate = self
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "importSegue" {
                let importViewController = segue.destinationViewController as! ImportViewController
                importViewController.delegate = self
            }
        }
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Here")
        selectedContact = contacts[indexPath.row]
        self.performSegueWithIdentifier("showExistingContactSegue", sender: self)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            let contact = contacts[indexPath.row] as Object
//    
//            do {
//                let realm = try Realm()
//                try realm.write() {
//                    realm.delete(contact)
//                }
//                contacts = realm.objects(Contact).sorted("name", ascending: true)
//            }
//            catch {
//                print("ERROR")
//            }
//        }
//    }

    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactCell") as! ContactTableViewCell
        let currentContact = contacts[indexPath.row]
        
        cell.contactNameLabel.text = "\(currentContact.givenName) \(currentContact.familyName)"
        
        var emailAddress: String!
        for emailAddresses in currentContact.emailAddresses {
            if emailAddresses.label == CNLabelHome {
                emailAddress = emailAddresses.value as! String
                break
            }
        }
        
        var cellNumber: String!
        for phoneNumbers in currentContact.phoneNumbers {
            if phoneNumbers.label == CNLabelHome {
                cellNumber = phoneNumbers.value as! String
                break
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    // MARK: ImportContactViewControllerDelegate
    func didFetchContacts(contacts: [CNContact]) {
        for contact in contacts {
            self.contacts.append(contact)
        }
        
        contactsTableView?.reloadData()
    }
    
//    var contacts: Results<Contact>! {
//        didSet {
//            contactsTableView?.reloadData()
//        }
//    }
//    var selectedContact: Contact?
//    
//    @IBAction func backtoContactsVC(segue: UIStoryboardSegue) {
//        if let identifier = segue.identifier {
//            do {
//                let realm = try Realm()
//                
//                switch identifier {
//                case "contactSaveSegue":
//                    let source = segue.sourceViewController as! AddContactViewController
//                    try realm.write() {
//                        realm.add(source.currentContact!)
//                    }
//                case "trashContactSegue":   // not needed for case where adding new contact - causes error FIX
//                    try realm.write() {
//                        realm.delete(self.selectedContact!)
//                    }
//                    let source = segue.sourceViewController as! ContactDisplayViewController
//                    source.contact = nil
//                default:
//                    print("No one loves \(identifier)")
//                }
//                
//                contacts = realm.objects(Contact).sorted("name", ascending: true)
//            }
//            catch {
//                print("Error in backToContactsVC")
//            }
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        contactsTableView.dataSource = self
//        contactsTableView.delegate = self
//    }
//    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        do {
//            let realm = try Realm()
//            contacts = realm.objects(Contact).sorted("name", ascending: true)
//        }
//        catch {
//            print("Error in Contacts viewDidLoad")
//        }
//    }
//    
//    // MARK: Navigation
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        if (segue.identifier == "showExistingContactSegue") {
//            let contactViewController = segue.destinationViewController as! ContactDisplayViewController
//            contactViewController.contact = selectedContact
//        }
//    }
//    
//    // MARK: UITableViewDataSource
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("ContactCell") as! ContactTableViewCell
//        let row = indexPath.row
//        let contact = contacts[row] as Contact
//        cell.contact = contact
//        return cell
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return contacts?.count ?? 0
//    }
//    
//    // MARK: UITableViewDelegate
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        selectedContact = contacts[indexPath.row]
//        self.performSegueWithIdentifier("showExistingContactSegue", sender: self)
//    }
//    
//    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }
//    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            let contact = contacts[indexPath.row] as Object
//            
//            do {
//                let realm = try Realm()
//                try realm.write() {
//                    realm.delete(contact)
//                }
//                contacts = realm.objects(Contact).sorted("name", ascending: true)
//            }
//            catch {
//                print("ERROR")
//            }
//        }
//    }

}
