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

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cellTextField: UITextField!
    
    @IBOutlet weak var navItem: UINavigationItem!
    
    var contact: Contact? {
        didSet {
            displayContact(contact)
        }
    }
    var edit: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize UITapGestureRecognizer
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)                      // add tap gesture to view
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true

        navItem.title = contact!.name
        cellTextField.keyboardType = UIKeyboardType.PhonePad    // set cellLabel to display phone number keyboard
        cellTextField.returnKeyType = UIReturnKeyType.Done      // set cellLabel return type
        setUpTextFieldDelegates()
        displayContact(self.contact)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
    
    // View will resign first responder status
    func dismissKeyboard() {
        view.endEditing(true)                               // dismiss keyboard
    }
    
    func setUpTextFieldDelegates() {
        nameTextField.returnKeyType = .Next
        nameTextField.delegate = self
        emailTextField.returnKeyType = .Next
        emailTextField.delegate = self
    }
    
    func displayContact(contact: Contact?) {
        if let contact = contact, nameTextField = nameTextField, emailTextField = emailTextField, cellTextField = cellTextField {
            nameTextField.text = contact.name
            emailTextField.text = contact.email
            cellTextField.text = contact.cell
            
            if contact.name.characters.count == 0 && contact.email.characters.count == 0 && contact.cell.characters.count == 0 {
                nameTextField.becomeFirstResponder()
            }
        }
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == nameTextField) {
            emailTextField.returnKeyType = .Done
            emailTextField.becomeFirstResponder()
        }
        else if (textField == emailTextField) {
            cellTextField.returnKeyType = .Done
            cellTextField.becomeFirstResponder()
        }
        return false
    }
}
