//
//  EventDisplayViewController.swift
//  Show Planner
//
//  Created by Leslie Kim on 12/13/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class EventDisplayViewController: UIViewController {
    @IBAction func backToEventDisplayVC(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            switch identifier {
            case "saveLineup":
                print("saveLineup")
            default:
                print("No one loves \(identifier)")
            }
        }
    }
}
