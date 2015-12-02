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

class SelectLineupViewController: UIViewController {
    
    @IBOutlet weak var selectLineupTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.hidden = true
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
