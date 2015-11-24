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

class ContactDisplayViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var cellLabel: UITextField!
    
    var contact: Contact? {
        didSet {
            displayContact(contact)
        }
    }
    var edit: Bool = false
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        displayContact(self.contact)
        nameLabel.returnKeyType = .Next
        nameLabel.delegate = self
        emailLabel.returnKeyType = .Next
        emailLabel.delegate = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        saveContact()
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
    
    func saveContact() {
        if let contact = contact {
            do {
                let realm = try Realm()
                
                try realm.write {
                    if (contact.name != self.nameLabel.text || contact.email != self.emailLabel.text || contact.cell != self.cellLabel.text) {
                        contact.name = self.nameLabel.text!
                        contact.email = self.emailLabel.text!
                        contact.cell = self.cellLabel.text!
                    }
                }
            }
            catch {
                print("ERROR")
            }
        }
    }
    
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
