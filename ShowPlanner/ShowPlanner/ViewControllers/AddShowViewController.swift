//
//  AddShowViewController.swift
//  ShowPlanner
//
//  Created by Leslie Kim on 11/15/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class AddShowViewController: UIViewController {
    var currentShow: Show?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}



//override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//    // Get the new view controller using segue.destinationViewController.
//    // Pass the selected object to the new view controller.
//    
//    currentNote = Note()
//    currentNote!.title   = "Super Simple New Note"
//    currentNote!.content = "Yet More Content"
//}