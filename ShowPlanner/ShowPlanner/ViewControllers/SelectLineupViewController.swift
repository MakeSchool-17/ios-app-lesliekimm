//
//  SelectLineupViewController.swift
//  Show Planner
//
//  Created by Leslie Kim on 11/23/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

// SOURCES:
// 1) check mark artwork: https://commons.wikimedia.org/wiki/File:Check_mark_23x20_02.svg

import UIKit

class SelectLineupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var selectLineupTableView: UITableView!
    
    var dataSource = ContactsDataSource()
    var selectedContact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectLineupTableView.dataSource = self
        selectLineupTableView.delegate = self
        selectLineupTableView.reloadData()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        self.tabBarController?.tabBar.hidden = true
        selectLineupTableView.reloadData()
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SelectLineupCell") as! SelectLineupTableViewCell
        let row = indexPath.row
        let contact = dataSource.contacts[row] as Contact
        cell.contact = contact
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.contacts?.count ?? 0
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedContact = dataSource.contacts[indexPath.row]
        print("didSelectRowAtIndexPath in SelectLineup")
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
//            let contact = dataSource.contacts[indexPath.row] as NSObject
            
            //            do {
            //                let realm = try Realm()
            //                try realm.write() {
            //                    realm.delete(contact)
            //                }
            //                contacts = realm.objects(Contact).sorted("name", ascending: true)
            //            }
            //            catch {
            //                print("ERROR")
            //            }
        }
    }

}
