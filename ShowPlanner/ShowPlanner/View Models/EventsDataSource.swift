//
//  EventsDataSource.swift
//  Show Planner
//
//  Created by Leslie Kim on 12/3/15.
//  Copyright © 2015 Leslie Kim. All rights reserved.
//

import Foundation
import RealmSwift

class EventsDataSource: NSObject {
    static var sharedEventsDatsSource = EventsDataSource()
    var events: Results<Event>!
    
    override init() {
        super.init()
        
        do {
            let realm = try Realm()
            events = realm.objects(Event).sorted("dateTime", ascending: false)
        }
        catch {
            print("Error in events init")
        }
    }
    
    func addEvent(event: Event) {
        do {
            let realm = try Realm()
            try realm.write() {
                realm.add(event)
            }
            events = realm.objects(Event).sorted("dateTime", ascending: false)
        }
        catch {
            print("Error in addEvent")
        }
    }
    
    func trashEvent(event: Event) {
        do {
            let realm = try Realm()
            try realm.write() {
                realm.delete(event)
            }
            events = realm.objects(Event).sorted("dateTime", ascending: false)
        }
        catch {
            print("Error in trashEvent")
        }
    }
}