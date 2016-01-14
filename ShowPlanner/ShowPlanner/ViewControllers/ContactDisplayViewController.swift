//
//  ContactDisplayViewController.swift
//  ShowPlanner
//
//  Created by Leslie Kim on 11/19/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//
// SOURCES:
// 1) Dismiss keyboard with UITapGestureRecognizer: http://stackoverflow.com/questions/24126678/close-ios-keyboard-by-touching-anywhere-using-swift

import Foundation
import UIKit

class ContactDisplayViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var navItem: UINavigationItem!                   // code connection for navigation item
    @IBOutlet weak var nameTextField: UITextField!                  // code connection for name textfield
    @IBOutlet weak var emailTextField: UITextField!                 // code connection for email textfield
    @IBOutlet weak var cellTextField: UITextField!                  // code connection for cell textfield
    @IBOutlet weak var trashButton: UIBarButtonItem!                // code connection for trash button
    
    @IBOutlet weak var nameLabel: UILabel!                          // code connection for name label
    @IBOutlet weak var emailLabel: UILabel!                         // code connection for email label
    @IBOutlet weak var cellLabel: UILabel!                          // code connection for cell label
    let blueColor = UIColor(red: 0x25, green: 0x3b, blue: 0x4b)     // app icon blue color var
    let greenColor = UIColor(red: 0x00, green: 0xa3, blue: 0x88)    // app icon blue color var
    var contact: Contact? {                                         // optional Contact var
        didSet {
            displayContact(contact)                                 // display contact everytime changes are made
        }
    }
    var addNew: Bool = false                                        // Bool to inidicate if we are adding new Contact or not
    
    // Set the view when loaded for the first time
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize UITapGestureRecognizer
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)                              // add tap gesture to view
    }
    
    // Set the view every time it appears
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true                 // hide tab bar controller in this VC

        navItem.title = contact!.name                               // use contact name as title
        cellTextField.keyboardType = UIKeyboardType.PhonePad        // set cellTextField to display phone number keyboard
        
        setUpTextFieldDelegates()                                   // set up textfield delegates
        displayContact(contact)                                     // display contact
        
        if addNew {                                                 // if adding new Contact
            trashButton.enabled = false                             // disable trash button
        }
        
        nameLabel.textColor = blueColor                             // set nameLabel textColor to app icon blue
        emailLabel.textColor = blueColor                            // set emailLabel textColor to app icon blue
        cellLabel.textColor = blueColor                             // set cellLabel textColor to app icon blue
        trashButton.tintColor = greenColor                          // set trashButton textColor to app icon green
    }
    
    // Set the view everytime it disappears
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false                // unhide tab bar controller when leaving this VC
    }
    
    // MARK: Custom functions
    // View will resign first responder status
    func dismissKeyboard() {
        view.endEditing(true)                                       // dismiss keyboard
    }
    
    // Set up textfield delegates
    func setUpTextFieldDelegates() {
        nameTextField.returnKeyType = .Next                         // change Return to Next
        nameTextField.delegate = self                               // set name textfield delegate to self
        emailTextField.returnKeyType = .Next                        // change Return to Next
        emailTextField.delegate = self                              // set email textfield delegate to self
    }
    
    // Display contact info for optional Contact object
    func displayContact(contact: Contact?) {
        if let contact = contact, nameTextField = nameTextField, emailTextField = emailTextField, cellTextField = cellTextField {
            nameTextField.text = contact.name                       // set nameTextField text to contact name
            emailTextField.text = contact.email                     // set emailTextField text to contat email
            cellTextField.text = contact.cell                       // set cellTextField text to contact cell
            
            // If there is no text displayed, set nameTextField to first responder
            if contact.name.characters.count == 0 && contact.email.characters.count == 0 && contact.cell.characters.count == 0 {
                nameTextField.becomeFirstResponder()                // set nameTextField to first responder
            }
            
            if contact.name != "" {                                 // if contact has a name
                nameTextField.textColor = blueColor                 // set nameTextField textColor to app icon blue
            }
            if contact.email != "" {                                // if contact has an email
                emailTextField.textColor = blueColor                // set emailTextField textColor to app icon blue
            }
            if contact.cell != "" {                                 // if contact has a cell
                cellTextField.textColor = blueColor                 // set cellTextField textColor to app icon blue
            }
        }
    }
    
    // MARK: UITextFieldDelegate
    // Sets first responder to next textfield when Next (Return) key hit
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == nameTextField) {                           // if current textfield is nameTextField
            emailTextField.becomeFirstResponder()                   // set first responder to emailTextField
        }
        else if (textField == emailTextField) {                     // if current textfield is emailTextField
            cellTextField.becomeFirstResponder()                    // set first responder to cellTextField
        }
        return false                                                // otherwise, return false
    }
}
