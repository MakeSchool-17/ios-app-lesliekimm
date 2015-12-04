//
//  Contact.swift
//  ShowPlanner
//
//  Created by Leslie Kim on 11/19/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import Foundation
import RealmSwift

class Contact: Object {
    dynamic var name: String = ""
    dynamic var email: String = ""
    dynamic var cell: String = ""
}