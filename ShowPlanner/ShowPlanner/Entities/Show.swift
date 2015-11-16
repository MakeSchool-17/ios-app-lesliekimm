//
//  Show.swift
//  ShowPlanner
//
//  Created by Leslie Kim on 11/15/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import Foundation
import RealmSwift

class Show: Object {
    dynamic var name: String = ""
    dynamic var lineup: String = ""
    dynamic var location: String = ""
}