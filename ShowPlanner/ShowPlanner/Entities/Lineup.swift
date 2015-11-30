//
//  Lineup.swift
//  Show Planner
//
//  Created by Leslie Kim on 11/23/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import Foundation
import RealmSwift

class Lineup: Object {
    dynamic var name: String = ""
    dynamic var host: Bool = false
    dynamic var confirmed: Bool = false
}