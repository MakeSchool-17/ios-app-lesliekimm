//
//  UpcomingViewController.swift
//  ShowPlanner
//
//  Created by Leslie Kim on 11/13/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit
import RealmSwift

class UpcomingViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func backToUpcomingVC(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            do {
                let realm = try Realm()
            
                switch identifier {
                case "saveAddEventSegue":
                    let source = segue.sourceViewController as! AddEventViewController
                    try realm.write() {
                        realm.add(source.currentEvent!)
                    }
                case "trashShowSegue":
                    try realm.write() {
                        realm.delete(self.selectedEvent!)
                    }
                    let source = segue.sourceViewController as! EventDisplayViewController
                    source.event = nil
                default:
                    print("No one loves \(identifier)")
                    
                }
                
                events = realm.objects(Event).sorted("location", ascending: true)
            }
            catch {
                print("handle error")
            }
        }
    }
    
    var events: Results<Event>! {
        didSet {
            tableView?.reloadData()
        }
    }
    var selectedEvent: Event?
    
//    var shows: [String] = ["The Kevin Nealon Show", "All Star Comedy", "Chocolate Sundaes"]
//    var lineup: [String] = ["Kevin Nealon, Iliza Shlesinger, Bobby Lee, Aries Spears, CJ Sullivan, Chris D'Elia, Sarah Silverman", "Dom Irrera, Mike Marino, Tony Rock, Bob Saget, Godfrey, Kat Williams, Dane Cook, Tim Allen", "Alonzo Bodden, Tiffany Haddish, Aries Spears, Finesse Mitchell, Jerrod Carmichael, Mario Joyner"]
//    var locations: [String] = ["The Laugh Factory", "The Comedy Store", "The Improv"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        do {
            let realm = try Realm()
            events = realm.objects(Event).sorted("location", ascending: true)
        }
        catch {
            print("ERROR")
        }
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

extension UpcomingViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UpcomingCell") as! EventTableViewCell
        let row = indexPath.row
        let event = events[row] as Event
        cell.event = event
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events?.count ?? 0
    }
}

extension UpcomingViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedEvent = events[indexPath.row]
        self.performSegueWithIdentifier("showExistingEventSegue", sender: self)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let event = events[indexPath.row] as Object
            
            do {
                let realm = try Realm()
                try realm.write() {
                    realm.delete(event)
                }
            events = realm.objects(Event).sorted("location", ascending: true)
            }
            catch {
                print("ERROR")
            }
        }
    }
}