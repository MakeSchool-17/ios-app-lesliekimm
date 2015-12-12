//
//  PastDisplayViewController.swift
//  Show Planner
//
//  Created by Leslie Kim on 12/12/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import UIKit

class PastDisplayViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var dateTimeTextField: UITextField!
    @IBOutlet weak var lineupTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!

    static var dateFormatter: NSDateFormatter = {
        var formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        return formatter
    }()
    
    static var timeFormatter: NSDateFormatter = {
        var formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        return formatter
    }()
    
    var event: Event? {
        didSet {
            displayEvent(event)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        notesTextView.delegate = self
        notesTextView.text = "Notes"
        notesTextView.textColor = UIColor.lightGrayColor()
        
        // Initialize UITapGestureRecognizer
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)                          // add tap gesture to view
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true
        
        navItem.title = event!.name
        displayEvent(event)
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
    
    // View will resign first responder status
    func dismissKeyboard() {
        view.endEditing(true)                               // dismiss keyboard
    }
    
    func displayEvent(event: Event?) {
        if let event = event, nameTextField = nameTextField, locationTextField = locationTextField, dateTimeTextField = dateTimeTextField, lineupTextField = lineupTextField, notesTextView = notesTextView {
            nameTextField.text = event.name
            locationTextField.text = event.location
            
            let date = PastDisplayViewController.dateFormatter.stringFromDate(event.dateTime)
            let time = PastDisplayViewController.timeFormatter.stringFromDate(event.dateTime)
            dateTimeTextField.text = date + " " + time
            
            notesTextView.text = event.notes
            if event.notes != "" {
                notesTextView.textColor = UIColor.blackColor()
            }
            else {
                notesTextView.text = "Notes"
                notesTextView.textColor = UIColor.lightGrayColor()
            }
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
    
    // MARK: UITextViewDelegate
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Notes"
            textView.textColor = UIColor.lightGrayColor()
        }
    }
}
