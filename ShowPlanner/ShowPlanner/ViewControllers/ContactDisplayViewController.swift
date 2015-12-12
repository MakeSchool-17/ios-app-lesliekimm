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
    @IBOutlet weak var nameTextField: UITextField!          // code connection for name text field
    @IBOutlet weak var emailTextField: UITextField!         // code connection for email text field
    @IBOutlet weak var cellTextField: UITextField!          // code connection for cell text field
    @IBOutlet weak var navItem: UINavigationItem!           // code connection for navigation item
    @IBOutlet weak var trashButton: UIBarButtonItem!
    @IBOutlet weak var toolbarBottomSpace: NSLayoutConstraint!
    
    var contact: Contact? {                                 // optional Contact var
        didSet {
            displayContact(contact)                         // display contact everytime changes are made
        }
    }
    var addNew: Bool = false
    
    // Set the view when loaded for the first time
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize UITapGestureRecognizer
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)                          // add tap gesture to view
    }
    
    // Set the view every time it appears
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true             // hide tab bar controller in this VC

        navItem.title = contact!.name                           // use contact's name as title
        cellTextField.keyboardType = UIKeyboardType.PhonePad    // set cellTextField to display phone number keyboard
        cellTextField.returnKeyType = UIReturnKeyType.Done      // set cellTextField return type
        
        setUpTextFieldDelegates()                               // set up text field delegates
        displayContact(self.contact)                            // display contact
        
        if addNew {
            trashButton.enabled = false
        }
    }
    
    // Set the view everytime it disappears
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false        // unhide tab bar controller when leaving this VC
    }
    
    // MARK: Custom functions
    // View will resign first responder status
    func dismissKeyboard() {
        view.endEditing(true)                               // dismiss keyboard
    }
    
    // Set up text field delegates
    func setUpTextFieldDelegates() {
        nameTextField.returnKeyType = .Next                 // change Return to Next
        nameTextField.delegate = self                       // set name textfield delegate to self
        emailTextField.returnKeyType = .Next                // change Return to Next
        emailTextField.delegate = self                      // set email textfield delegate to self
    }
    
    // Display contact info for optional Contact object
    func displayContact(contact: Contact?) {
        if let contact = contact, nameTextField = nameTextField, emailTextField = emailTextField, cellTextField = cellTextField {
            nameTextField.text = contact.name               // set nameTextField text to contact's name
            emailTextField.text = contact.email             // set emailTextField text to contat'c email
            cellTextField.text = contact.cell               // set cellTextField text to contact's cell
            
            // If there is no text displayed, set nameTextField to first responder
            if contact.name.characters.count == 0 && contact.email.characters.count == 0 && contact.cell.characters.count == 0 {
                nameTextField.becomeFirstResponder()        // set nameTextField to first responder
            }
        }
    }
    
    // MARK: UITextFieldDelegate
    // Sets first responder to next textfield when Next (Return) key hit
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == nameTextField) {                   // if current textfield is nameTextField
            emailTextField.returnKeyType = .Next            // set emailTextField returnKeyType to Next
            emailTextField.becomeFirstResponder()           // set first responder to emailTextField
        }
        else if (textField == emailTextField) {             // if current textfield is emailTextField
            cellTextField.returnKeyType = .Done             // set cellTextField returnKeyType to Done
            cellTextField.becomeFirstResponder()            // set first responder to cellTextField
        }
        return false                                        // otherwise, return false
    }
}
