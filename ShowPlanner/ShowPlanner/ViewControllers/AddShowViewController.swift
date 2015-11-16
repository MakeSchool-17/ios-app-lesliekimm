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
        // Get the new view controller using segue.destinationViewController
        // Pass the selected object to the new view controller
        currentShow = Show()
        currentShow!.name = "All Star Comedy"
        currentShow!.lineup = "Dom Irrera, Mike Marino, Tony Rock, Bob Saget, Godfrey, Kat Williams, Dane Cook, Tim Allen"
        currentShow!.location = "The Comedy Store"
    }
}