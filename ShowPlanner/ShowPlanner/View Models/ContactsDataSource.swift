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
    static var sharedContactsDataSource = ContactsDataSource()
    var contacts: Results<Contact>!
    
    override init(){
        super.init()
        
        do {
            let realm = try Realm()
            contacts = realm.objects(Contact).sorted("name", ascending: true)
        }
        catch {
            print("Error in init")
        }
    }
    
    func addContact(contact: Contact) {
        do {
            let realm = try Realm()
            try realm.write() {
                realm.add(contact)
            }
            contacts = realm.objects(Contact).sorted("name", ascending: true)
        }
        catch {
            print("Error in addContact")
        }
    }
    
    func trashContact(contact: Contact) {
        do {
            let realm = try Realm()
            try realm.write() {
                realm.delete(contact)
            }
            contacts = realm.objects(Contact).sorted("name", ascending: true)
        }
        catch {
            print("Error in trashContact")
        }
    }
    
    func saveContact(contact: Contact) {
        print("in save")
        print(contact)
    }
}