//
//  SelectedLineup.swift
//  Show Planner
//
//  Created by Leslie Kim on 12/7/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import Foundation
import RealmSwift

class SelectedLineupDataSource: NSObject {
    static var sharedSelectedLineupDataSource = SelectedLineupDataSource()
    var lineup: Results<Lineup>!
    
    override init() {
        super.init()
        
        do {
            let realm = try Realm()
            lineup = realm.objects(Lineup)
        }
        catch {
            print("Error in lineup init")
        }
    }
    
    func addSelectedLineup(selectedLineup: Lineup) {
        do {
            let realm = try Realm()
            try realm.write() {
                realm.add(selectedLineup)
            }
            lineup = realm.objects(Lineup)
        }
        catch {
            print("Error in addSelectedLineup")
        }
    }
    
    func removeSelectedLineup(deselectedLineup: Lineup) {
        do {
            let realm = try Realm()
            try realm.write() {
                realm.delete(deselectedLineup)
            }
            lineup = realm.objects(Lineup)
        }
        catch {
            print("Error in removeSelectedLineup")
        }
    }
}