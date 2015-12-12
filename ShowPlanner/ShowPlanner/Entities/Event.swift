//
//  Event.swift
//  ShowPlanner
//
//  Created by Leslie Kim on 11/19/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import Foundation
import RealmSwift

class Event: Object {
    dynamic var name: String = ""                   // name string
    dynamic var lineup: String = ""                 // lineup string
    dynamic var lineupArray: Lineup?
//    dynamic var lineupArray: RLMArray<String>?             // store lineups on Realm
    dynamic var location: String = ""               // location string
    dynamic var dateTime = NSDate()                 // date object
    dynamic var confirmed: Bool = false             // indicates if all lineup is confirmed
    dynamic var notes: String = ""                  // notes string to make notes on past events (not currently implemented)
}