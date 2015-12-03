//
//  ContactDisplayViewController.swift
//  ShowPlanner
//
//  Created by Leslie Kim on 11/19/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import Contacts

class ContactDisplayViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var cellLabel: UITextField!
    @IBOutlet weak var navItem: UINavigationItem!
    
    var contact: Contact? {
        didSet {
            displayContact(contact)
        }
    }
    var edit: Bool = false
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navItem.title = contact!.name
        
        displayContact(self.contact)
        
        nameLabel.returnKeyType = .Next
        nameLabel.delegate = self
        emailLabel.returnKeyType = .Next
        emailLabel.delegate = self
        
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.hidden = false
    }
    
    func displayContact(contact: Contact?) {
        if let contact = contact, nameLabel = nameLabel, emailLabel = emailLabel, cellLabel = cellLabel {
            nameLabel.text = contact.name
            emailLabel.text = contact.email
            cellLabel.text = contact.cell
            
            if contact.name.characters.count == 0 && contact.email.characters.count == 0 && contact.cell.characters.count == 0 {
                nameLabel.becomeFirstResponder()
            }
        }
    }
    
//    // MARK: Navigation
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        if (segue.identifier == "saveContactChanges") {
//            let contactViewController = segue.destinationViewController as! ContactDisplayViewController
//            contactViewController.contact = selectedContact
//        }
//        if (segue.identifier == "importSegue") {
//            let importViewController = segue.destinationViewController as! ImportViewController
//            importViewController.delegate = self
//        }
//    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == nameLabel) {  //1
            emailLabel.returnKeyType = .Done
            emailLabel.becomeFirstResponder()
        }
        else if (textField == emailLabel) {
            cellLabel.returnKeyType = .Done
            cellLabel.becomeFirstResponder()
        }
        return false
    }
}
