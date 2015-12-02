//
//  ContactsV2ViewController.swift
//  Show Planner
//
//  Created by Leslie Kim on 12/2/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class ContactsV2ViewController: UIViewController {
    @IBOutlet weak var contactsTableView: UITableView!
    
    var dataSource = ContactsDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        contactsTableView.dataSource = dataSource
        contactsTableView.reloadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
