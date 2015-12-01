//
//  ImportViewController.swift
//  Show Planner
//
//  Created by Leslie Kim on 11/30/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit
import Contacts

protocol ImportContactViewControllerDelegate {
    func didFetchContacts(contactsToAppend: [Contact])
}

class ImportViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var searchTextField: UITextField!
    
    var delegate: ImportContactViewControllerDelegate!
    var contactsToAppend = [Contact]()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                        newContact.name = contact.givenName
                        newContact.cell = contact.phoneNumbers[0].label
                        newContact.email = contact.emailAddresses[0].label
                        self.contactsToAppend.append(newContact)
                    }
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.delegate.didFetchContacts(self.contactsToAppend)
                        self.navigationController?.popViewControllerAnimated(true)
                    })
                }
            }
        }
        return true
    }
}
