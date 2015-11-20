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

class ContactDisplayViewController: UIViewController {
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var cellLabel: UITextField!
    
    var contact: Contact? {
        didSet {
            displayContact(contact)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayContact(contact)
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
}
