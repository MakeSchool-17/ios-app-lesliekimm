//
//  ContactDataSource.swift
//  Show Planner
//
//  Created by Leslie Kim on 12/2/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

import Foundation
import RealmSwift

class ContactsDataSource: NSObject, UITableViewDataSource {
    static var sharedContactsDataSource = ContactsDataSource()
    var contacts: Results<Contact>!
    var currentContact: Contact?
    
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
    
    func addContact(segue: UIStoryboardSegue) {
        do {
            let realm = try Realm()
            let source = segue.sourceViewController as! AddContactViewController
            
            try realm.write() {
                realm.add(source.currentContact!)
            }
        }
        catch {
            print("Error in addContact")
        }
    }

    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactCell") as! ContactTableViewCell
        let row = indexPath.row
        let contact = contacts[row] as Contact
        cell.contact = contact
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts?.count ?? 0
    }
}