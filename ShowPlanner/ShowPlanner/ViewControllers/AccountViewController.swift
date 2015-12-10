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
    @IBOutlet weak var nameTextField: UITextField!          // code connection to name textfield
    @IBOutlet weak var emailTextField: UITextField!         // code connection to email textfield
    @IBOutlet weak var cellTextField: UITextField!          // code connection to cell textfield
    var userAccount: Account?                               // declare userAccount var
    
    // Save account info
    @IBAction func saveAccountInfo(sender: UIBarButtonItem) {
        if let userAccount = userAccount {
            do {
                let realm = try Realm()                                 // grab default Realm
                try realm.write {                                       // write to Realm
                    print(self.nameTextField.text!)
                    // if any textfield text properties have been changed, update on Realm
                    if (userAccount.name != self.nameTextField.text || userAccount.email != self.emailTextField.text || userAccount.cell != self.cellTextField.text) {
                        print("HERE")
                        userAccount.name = self.nameTextField.text!     // set name to nameTextField
                        userAccount.email = self.emailTextField.text!   // set email to emailTextField
                        userAccount.cell = self.cellTextField.text!     // set cell to cellTextField
                    }
                }
            }
            catch {
                print("Error in saveAccountInfo")
            }
        }
        dismissKeyboard()                                       // dismiss keyboard when save button hit
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize UITapGestureRecognizer
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)                          // add tap gesture to view
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        setUpTextFieldDelegates()                               // set up textfield delegates
        cellTextField.keyboardType = UIKeyboardType.PhonePad    // set cellTextField to display phone number keyboard
        cellTextField.returnKeyType = UIReturnKeyType.Done      // set cellTextField return type
        
        do {
            let realm = try Realm()                             // grab default Realm
            let accounts = realm.objects(Account)               // grab reference to accounts stored in Realm
            if accounts.count > 0 {                             // if there is an Account object stored
                userAccount = realm.objects(Account)[0]         // assign first Account to userAccount
                displayAccount(userAccount)
            }
            else {                                              // if no Account objects
                userAccount = Account()                         // initialize new Account object
                try realm.write() {                             // write to Realm
                    realm.add(self.userAccount!)                // add userAccount to Realm
                }
            }
        }
        catch {
            print("Error in viewWillAppear")                // print error message
        }
    }
    
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
    
    // Display account information
    func displayAccount(account: Account?) {
        if let account = account, nameTextField = nameTextField, emailTextField = emailTextField, cellTextField = cellTextField {
            nameTextField.text = account.name               // set nameTextField text to name
            emailTextField.text = account.email             // set emailTextField text to email
            cellTextField.text = account.cell               // set cellTextField text to cell
            
            // If there is no text displayed, set nameTextField to first responder
            if account.name.characters.count == 0 && account.email.characters.count == 0 && account.cell.characters.count == 0 {
                nameTextField.becomeFirstResponder()        // set nameTextField to first responder
            }
        }
    }
    
    // MARK: UITextFieldDelegate
    // Sets first responder to next textfield when Next (Return) key hit
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == nameTextField) {                   // if current textfield is nameTextField
            emailTextField.returnKeyType = .Done            // set emailTextField returnKeyType to DOne
            emailTextField.becomeFirstResponder()           // set first responder to emailTextField
        }
        else if (textField == emailTextField) {             // if current textfield is emailTextField
            cellTextField.returnKeyType = .Done             // set cellTextField returnKeyType to DOne
            cellTextField.becomeFirstResponder()            // set first responder to cellTextField
        }
        return false                                        // otherwise, return false
    }
}
