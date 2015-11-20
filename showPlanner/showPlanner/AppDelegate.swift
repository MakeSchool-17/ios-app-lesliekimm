//
//  AppDelegate.swift
//  ShowPlanner
//
//  Created by Leslie Kim on 11/13/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

// SOURCES: 1) Import contacts using Contacts framework
//             http://www.appcoda.com/ios-contacts-framework/

import UIKit
import Contacts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var contactStore = CNContactStore()                     // initialize ContactStore for ContactsVC
    var contactListToSelectFromStore = CNContactStore()     // initialize ContactStore to be used to select Contacts from

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    class func getAppDelegate() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    func showMessage(message: String) {
        // create an alert controller for ContactsViewController
        let alertController = UIAlertController(title: "Contacts", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        // create action for OK button
        let dismissAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
        }
        
        alertController.addAction(dismissAction)            // add action for OK buton to alert controller
        
        // get stack of view controllers
        let pushedViewControllers = (self.window?.rootViewController as! UINavigationController).viewControllers
        // get view controller at top of stack
        let presentedViewController = pushedViewControllers[pushedViewControllers.count - 1]
        
        // present alert controller in top view controller
        presentedViewController.presentViewController(alertController, animated: true, completion: nil)
    }
}
