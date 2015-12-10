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
        cellLabel.keyboardType = UIKeyboardType.PhonePad    // set cellLabel to display phone number keyboard
        cellLabel.returnKeyType = UIReturnKeyType.Done      // set cellLabel return type
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
        nameLabel.returnKeyType = .Next
        nameLabel.delegate = self
        emailLabel.returnKeyType = .Next
        emailLabel.delegate = self
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
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == nameLabel) {
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
