//
//  ImportViewController.swift
//  Show Planner
//
//  Created by Leslie Kim on 11/30/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

protocol ImportContactViewControllerDelegate {
    func didFetchContacts(contactsToAppend: [Contact])
    func didFetchCNContacts(contacts: [CNContact])
}

class ImportViewController: UIViewController, CNContactPickerDelegate {
    var delegate: ImportContactViewControllerDelegate!
    var contacts = [CNContact]()
    var contactsToAppend = [Contact]()
    
    @IBAction func showContacts(sender: UIButton) {
        AppDelegate.getAppDelegate().requestForAccess { (accessGranted) -> Void in
            if accessGranted {
                let contactPickerViewController = CNContactPickerViewController()
                contactPickerViewController.delegate = self
                self.presentViewController(contactPickerViewController, animated: true, completion: nil)
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
    
    // MARK: CNContactPickerDelegate
    func contactPicker(picker: CNContactPickerViewController, didSelectContacts contacts: [CNContact]) {
        var pickedContacts = [Contact]()
        
        for contact in contacts {
            let pickedContact = Contact()
            if contact.givenName != "" && contact.familyName != "" {
                pickedContact.name = "\(contact.givenName) \(contact.familyName)"
            }
            else if contact.givenName != "" {
                pickedContact.name = "\(contact.givenName)"
            }
            else {
                pickedContact.name = "\(contact.familyName)"
            }
        
            if !contact.phoneNumbers.isEmpty {
                pickedContact.cell = (contact.phoneNumbers[0].value as! CNPhoneNumber).stringValue
            }
            if !contact.emailAddresses.isEmpty {
                pickedContact.email = contact.emailAddresses[0].value as! String
            }
            pickedContacts.append(pickedContact)
        }
        
        delegate.didFetchCNContacts(contacts)
        delegate.didFetchContacts(pickedContacts)
        navigationController?.popViewControllerAnimated(true)
    }
}
