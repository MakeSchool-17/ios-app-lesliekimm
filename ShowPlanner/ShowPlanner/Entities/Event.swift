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
    dynamic var name: String = ""
    dynamic var lineup: String = ""
    dynamic var location: String = ""
    dynamic var dateTime = NSDate()
    dynamic var confirmed: String = ""
//    dynamic var confirmed: Bool = false
}