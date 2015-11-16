//
//  UpcomingViewController.swift
//  ShowPlanner
//
//  Created by Leslie Kim on 11/13/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class UpcomingViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func backToUpcomingVC(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            print("Identifier \(identifier)")
        }
    }
    
    var shows: [String] = ["The Kevin Nealon Show", "All Star Comedy", "Chocolate Sundaes"]
    var lineup: [String] = ["Kevin Nealon, Iliza Shlesinger, Bobby Lee, Aries Spears, CJ Sullivan, Chris D'Elia, Sarah Silverman", "Dom Irrera, Mike Marino, Tony Rock, Bob Saget, Godfrey, Kat Williams, Dane Cook, Tim Allen", "Alonzo Bodden, Tiffany Haddish, Aries Spears, Finesse Mitchell, Jerrod Carmichael, Mario Joyner"]
    var locations: [String] = ["The Laugh Factory", "The Comedy Store", "The Improv"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
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
        cell.showNameLabel.text = self.shows[indexPath.row]
        cell.lineupLabel.text = self.lineup[indexPath.row]
        cell.locationLabel.text = self.locations[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shows.count
    }
}