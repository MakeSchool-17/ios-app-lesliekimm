//
//  SelecteLineupTableViewCell.swift
//  Show Planner
//
//  Created by Leslie Kim on 12/2/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class SelecteLineupTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UIView!
    @IBOutlet weak var hostButton: UIButton!
    @IBOutlet weak var selectedButton: UIButton!
    
    @IBAction func pushHostButton(sender: AnyObject) {
    }
    @IBAction func pushCheckMark(sender: AnyObject) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
