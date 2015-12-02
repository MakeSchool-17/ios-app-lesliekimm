//
//  ContactsV2ViewController.swift
//  Show Planner
//
//  Created by Leslie Kim on 12/2/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class ContactsV2ViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var contactsTableView: UITableView!
    
    var dataSource = ContactsDataSource()
    var selectedContact: Contact?
    
    @IBAction func backToContactsVC(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            switch identifier {
            case "contactSaveSegue":
                print("save")
            case "trashContactSegue":
                print("trash")
            default:
                print("No one loves \(identifier)")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contactsTableView.dataSource = dataSource
        contactsTableView.delegate = self
        contactsTableView.reloadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "showExistingContactSegue") {
            let contactViewController = segue.destinationViewController as! ContactDisplayViewController
            contactViewController.contact = selectedContact
        }
//        if (segue.identifier == "importSegue") {
//            let importViewController = segue.destinationViewController as! ImportViewController
//            importViewController.delegate = self
//        }
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedContact = dataSource.contacts[indexPath.row]
        self.performSegueWithIdentifier("showExistingContactSegue", sender: self)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let contact = dataSource.contacts[indexPath.row] as NSObject
            
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
