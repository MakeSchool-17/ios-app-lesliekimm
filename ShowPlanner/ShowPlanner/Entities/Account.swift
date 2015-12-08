//
//  Account.swift
//  Show Planner
//
//  Created by Leslie Kim on 12/7/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import Foundation
import RealmSwift

class Account: Object {
    dynamic var name: String = ""
    dynamic var email: String = ""
    dynamic var cell: String = ""
}