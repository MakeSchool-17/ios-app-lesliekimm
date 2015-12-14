//
//  ContactsDataSource.swift
//  Show Planner
//
//  Created by Leslie Kim on 12/2/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class ContactsDataSource: NSObject {
    static var sharedContactsDataSource = ContactsDataSource()                  // use static var to creaet singleton
    var contacts: Results<Contact>!                                             // declare contacts var
    
    // Access Realm and sort contacts by name
    override init(){
        super.init()
        
        do {
            let realm = try Realm()                                             // grab default Realm
            contacts = realm.objects(Contact).sorted("name", ascending: true)   // sort by name
        }
        catch {
            print("Error in init")                                              // print error message
        }
    }
    
    // Add a contact to contacts
    func addContact(contact: Contact) {
        do {
            let realm = try Realm()                                             // grab default Realm
            try realm.write() {                                                 // write to Realm
                realm.add(contact)                                              // add contact to Realm
            }
            contacts = realm.objects(Contact).sorted("name", ascending: true)   // sort by name
        }
        catch {
            print("Error in addContact")                                        // print error message
        }
    }
    
    // Edit a contact from contacts
    func editContact(contact: Contact, editedContact: Contact) {
        do {
            let realm = try Realm()                                             // grab default Realm
            
            try realm.write {                                                   // write to Realm
                if (contact.name != editedContact.name || contact.email != editedContact.email || contact.cell != editedContact.cell) {
                    contact.name = editedContact.name
                    contact.email = editedContact.email
                    contact.cell = editedContact.cell
                }
            }
            contacts = realm.objects(Contact).sorted("name", ascending: true)   // sort by name
        }
        catch {
            print("Error in editContact")                                       // print error message
        }
    }
    
    // Delete a contact from contacts
    func deleteContact(contact: Contact) {
        do {
            let realm = try Realm()                                             // grab default Realm
            try realm.write() {                                                 // write to Realm
                realm.delete(contact)                                           // delete event from Realm
            }
            contacts = realm.objects(Contact).sorted("name", ascending: true)   // sort by name
        }
        catch {
            print("Error in deleteContact")                                     // print error message
        }
    }
}