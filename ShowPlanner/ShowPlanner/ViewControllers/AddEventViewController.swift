//
//  AddEventViewController.swift
//  ShowPlanner
//
//  Created by Leslie Kim on 11/19/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {
    var currentEvent: Event?
    
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
        currentEvent = Event()
        currentEvent!.name = "All Star Comedy"
        currentEvent!.lineup = "Dom Irrera, Mike Marino, Tony Rock, Bob Saget, Godfrey, Kat Williams, Dane Cook, Tim Allen"
        currentEvent!.location = "The Comedy Store"
    }}
