//
//  AccountViewController.swift
//  ShowPlanner
//
//  Created by Leslie Kim on 11/13/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit
import RealmSwift

class AccountViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cellTextField: UITextField!
    
    var userAccount: Account?
    
    @IBAction func saveAccountInfo(sender: UIBarButtonItem) {

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        userAccount = Account()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if let userAccount = userAccount {
            do {
                let realm = try Realm()
                
                try realm.write {
                    if (userAccount.name != self.nameTextField.text || userAccount.email != self.emailTextField.text || userAccount.cell != self.cellTextField.text) {
                        userAccount.name = self.nameTextField.text!
                        userAccount.email = self.emailTextField.text!
                        userAccount.cell = self.cellTextField.text!
                    }
                }
            }
            catch {
                print("ERROR")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayAccount(account: Account?) {
        if let userAccount = userAccount, nameTextField = nameTextField, emailTextField = emailTextField, cellTextField = cellTextField {
            nameTextField.text = userAccount.name
            emailTextField.text = userAccount.email
            cellTextField.text = userAccount.cell
        }
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
