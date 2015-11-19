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
                case "addAddShowSegue":
                    let source = segue.sourceViewController as! AddShowViewController
                    try realm.write() {
                        realm.add(source.currentShow!)
                    }
                case "trashShowSegue":
                    try realm.write() {
                        realm.delete(self.selectedShow!)
                    }
                    let source = segue.sourceViewController as! ShowDisplayViewController
                    source.show = nil
                default:
                    print("No one loves \(identifier)")
                    
                }
                
                shows = realm.objects(Show).sorted("location", ascending: true)
            }
            catch {
                print("handle error")
            }
        }
    }
    
    var shows: Results<Show>! {
        didSet {
            tableView?.reloadData()
        }
    }
    var selectedShow: Show?
    
//    var shows: [String] = ["The Kevin Nealon Show", "All Star Comedy", "Chocolate Sundaes"]
//    var lineup: [String] = ["Kevin Nealon, Iliza Shlesinger, Bobby Lee, Aries Spears, CJ Sullivan, Chris D'Elia, Sarah Silverman", "Dom Irrera, Mike Marino, Tony Rock, Bob Saget, Godfrey, Kat Williams, Dane Cook, Tim Allen", "Alonzo Bodden, Tiffany Haddish, Aries Spears, Finesse Mitchell, Jerrod Carmichael, Mario Joyner"]
//    var locations: [String] = ["The Laugh Factory", "The Comedy Store", "The Improv"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        do {
            let realm = try Realm()
            shows = realm.objects(Show).sorted("location", ascending: true)
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
        let cell = tableView.dequeueReusableCellWithIdentifier("UpcomingCell") as! ShowTableViewCell
        let row = indexPath.row
        let show = shows[row] as Show
        cell.show = show
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows?.count ?? 0
    }
}

extension UpcomingViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedShow = shows[indexPath.row]
        self.performSegueWithIdentifier("showExistingShowSegue", sender: self)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let show = shows[indexPath.row] as Object
            
            do {
                let realm = try Realm()
                try realm.write() {
                    realm.delete(show)
                }
            shows = realm.objects(Show).sorted("location", ascending: true)
            }
            catch {
                print("ERROR")
            }
        }
    }
}