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
    
    static var sharedContactsDataSource = ContactsDataSource();
    override init(){
        super.init()
    }
    
    var sharedContactsDataSource: Results<Contact>! {
        didSet {
            //            self.sharedContactsDataSource.reloadData()
        }
    }
    var selectedContact: Contact?
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactCell") as! ContactTableViewCell
        let row = indexPath.row
        let contact = sharedContactsDataSource[row] as Contact
        cell.contact = contact
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sharedContactsDataSource?.count ?? 0
    }
}