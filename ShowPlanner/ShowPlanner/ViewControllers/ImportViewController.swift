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

class ImportViewController: UIViewController, UITextFieldDelegate, CNContactPickerDelegate {
    @IBOutlet weak var searchTextField: UITextField!
    
    var delegate: ImportContactViewControllerDelegate!
    var contactsToAppend = [Contact]()
    
    @IBAction func showContacts(sender: UIButton) {
        let contactPickerViewController = CNContactPickerViewController()
        contactPickerViewController.delegate = self
        presentViewController(contactPickerViewController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.hidden = false
    }
    
    func performDoneItemTap() {
        AppDelegate.getAppDelegate().requestForAccess { (accessGranted) -> Void in
            if accessGranted {
                var contacts = [CNContact]()
                
                let keys = [CNContactFormatter.descriptorForRequiredKeysForStyle(CNContactFormatterStyle.FullName), CNContactEmailAddressesKey, CNContactPhoneNumbersKey]
               
                do {
                    let contactStore = AppDelegate.getAppDelegate().contactStore
                    try contactStore.enumerateContactsWithFetchRequest(CNContactFetchRequest(keysToFetch: keys)) { (contact, pointer) -> Void in
                        
//                        if contact.birthday != nil && contact.birthday!.month == self.currentlySelectedMonthIndex {
                            contacts.append(contact)
//                        }
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.delegate.didFetchCNContacts(contacts)
                        self.navigationController?.popViewControllerAnimated(true)
                    })
                }
                catch let error as NSError {
                    print(error.description, separator: "", terminator: "\n")
                }
            }
        }
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        AppDelegate.getAppDelegate().requestForAccess { (accessGranted) -> Void in
            if accessGranted {
                let predicate = CNContact.predicateForContactsMatchingName(self.searchTextField.text!)
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactEmailAddressesKey, CNContactPhoneNumbersKey]
                var contacts = [CNContact]()
                var message: String!
                
                let contactsStore = AppDelegate.getAppDelegate().contactStore
                do {
                    contacts = try contactsStore.unifiedContactsMatchingPredicate(predicate, keysToFetch: keys)
                    
                    if contacts.count == 0 {
                        message = "No contacts found matching search criteria."
                    }
                }
                catch {
                    message = "Unable to fetch contacts."
                }
                
                if message != nil {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        AppDelegate.getAppDelegate().showMessage(message)
                    })
                }
                else {
                    for contact in contacts {
                        let newContact = Contact()
                        
                        if contact.givenName != "" && contact.familyName != "" {
                            newContact.name = "\(contact.givenName) \(contact.familyName)"
                        }
                        else if contact.givenName != "" {
                            newContact.name = "\(contact.givenName)"
                        }
                        else {
                            newContact.name = "\(contact.familyName)"
                        }
                        
                        if !contact.phoneNumbers.isEmpty {
                            newContact.cell = (contact.phoneNumbers[0].value as! CNPhoneNumber).stringValue
                        }
                        if !contact.emailAddresses.isEmpty {
                            newContact.email = contact.emailAddresses[0].value as! String
                        }
            
                        self.contactsToAppend.append(newContact)
                    }
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.delegate.didFetchContacts(self.contactsToAppend)
                        self.delegate.didFetchCNContacts(contacts)
                        self.navigationController?.popViewControllerAnimated(true)
                    })
                }
            }
        }
        return true
    }
    
    // MARK: CNContactPickerDelegate
    func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
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
        
        delegate.didFetchCNContacts([contact])
        delegate.didFetchContacts([pickedContact])
        navigationController?.popViewControllerAnimated(true)
    }
    
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
