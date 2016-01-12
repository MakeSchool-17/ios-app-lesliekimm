//
//  AccountViewController.swift
//  ShowPlanner
//
//  Created by Leslie Kim on 11/13/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

// Sources:
// 1) Dismiss keyboard with UITapGestureRecognizer: http://stackoverflow.com/questions/24126678/close-ios-keyboard-by-touching-anywhere-using-swift

import UIKit
import RealmSwift

class AccountViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var nameTextField: UITextField!                      // code connection to name textfield
    @IBOutlet weak var emailTextField: UITextField!                     // code connection to email textfield
    @IBOutlet weak var cellTextField: UITextField!                      // code connection to cell textfield
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var changesSavedLabel: UILabel!                      // code connection to changes saved label
    
    let blueColor = UIColor(red: 0x25, green: 0x3b, blue: 0x4b)         // app icon blue color var
    let greenColor = UIColor(red: 0x00, green: 0xa3, blue: 0x88)
    
    var userAccount: Account?                                           // declare userAccount var
    
    // Save account info
    @IBAction func saveAccountInfo(sender: UIBarButtonItem) {
        if let userAccount = userAccount {
            do {
                let realm = try Realm()                                 // grab default Realm
                try realm.write {                                       // write to Realm
                    // if any textfield text properties have been changed, update on Realm
                    if (userAccount.name != self.nameTextField.text || userAccount.email != self.emailTextField.text || userAccount.cell != self.cellTextField.text) {
                        userAccount.name = self.nameTextField.text!     // set name to nameTextField
                        userAccount.email = self.emailTextField.text!   // set email to emailTextField
                        userAccount.cell = self.cellTextField.text!     // set cell to cellTextField
                    }
                }
            }
            catch {
                print("Error in saveAccountInfo")                       // print error message
            }
        }
        dismissKeyboard()                                               // dismiss keyboard when save button hit
        changesSavedLabel.text = "Changes Saved!"                       // set changesSaved label to indicate save has completed
        changesSavedLabel.textColor = greenColor
    }

    // Set the view when loaded for the first time
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize UITapGestureRecognizer
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)                                  // add tap gesture to view
    }
    
    // Set the view every time it appears
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        setUpTextFieldDelegates()                                       // set up textfield delegates
        setUpCellTextField()                                            // set up cellTextField
        changesSavedLabel.text = ""                                     // set changesSavedLabel to empty string
        
        do {
            let realm = try Realm()                                     // grab default Realm
            let accounts = realm.objects(Account)                       // grab reference to accounts stored in Realm
            if accounts.count > 0 {                                     // if there is an Account object stored
                userAccount = realm.objects(Account)[0]                 // assign first Account to userAccount
                displayAccount(userAccount)
            }
            else {                                                      // if no Account objects
                userAccount = Account()                                 // initialize new Account object
                try realm.write() {                                     // write to Realm
                    realm.add(self.userAccount!)                        // add userAccount to Realm
                }
            }
        }
        catch {
            print("Error in viewWillAppear")                            // print error message
        }
        
        nameLabel.textColor = blueColor
        emailLabel.textColor = blueColor
        cellLabel.textColor = blueColor
    }
    
    // MARK: Custom functions
    // View will resign first responder status
    func dismissKeyboard() {
        view.endEditing(true)                                           // dismiss keyboard
    }
    
    // Set up text field delegates
    func setUpTextFieldDelegates() {
        nameTextField.returnKeyType = .Next                             // change Return to Next
        nameTextField.delegate = self                                   // set name textfield delegate to self
        emailTextField.returnKeyType = .Next                            // change Return to Next
        emailTextField.delegate = self                                  // set email textfield delegate to self
    }
    
    // Set up cellTextField keyboard type
    func setUpCellTextField() {
        cellTextField.keyboardType = UIKeyboardType.PhonePad            // set cellTextField to display phone number keyboard
        cellTextField.returnKeyType = UIReturnKeyType.Done              // set cellTextField return type
    }
    
    // Display account information
    func displayAccount(account: Account?) {
        if let account = account, nameTextField = nameTextField, emailTextField = emailTextField, cellTextField = cellTextField {
            nameTextField.text = account.name                           // set nameTextField text to name
            emailTextField.text = account.email                         // set emailTextField text to email
            cellTextField.text = account.cell                           // set cellTextField text to cell
            
            // If there is no text displayed, set nameTextField to first responder
            if account.name.characters.count == 0 && account.email.characters.count == 0 && account.cell.characters.count == 0 {
                nameTextField.becomeFirstResponder()                    // set nameTextField to first responder
            }
            
            if account.name != "" {
                nameTextField.textColor = blueColor
            }
            if account.email != "" {
                emailTextField.textColor = blueColor
            }
            if account.cell != "" {
                cellTextField.textColor = blueColor
            }
        }
    }
    
    // MARK: UITextFieldDelegate
    // Sets first responder to next textfield when Next (Return) key hit
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == nameTextField) {                               // if current textfield is nameTextField
            emailTextField.returnKeyType = .Next                        // set emailTextField returnKeyType to Next
            emailTextField.becomeFirstResponder()                       // set first responder to emailTextField
        }
        else if (textField == emailTextField) {                         // if current textfield is emailTextField
            cellTextField.returnKeyType = .Done                         // set cellTextField returnKeyType to Done
            cellTextField.becomeFirstResponder()                        // set first responder to cellTextField
        }
        return false                                                    // otherwise, return false
    }
}
