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
    static var sharedEventsDatsSource = EventsDataSource()      // use static var to create singleton
    var events: Results<Event>!                                 // declare events var
    
    // Access Realm and sort events by date and time
    override init() {
        super.init()
        
        do {
            let realm = try Realm()                                             // grab default Realm
            events = realm.objects(Event).sorted("dateTime", ascending: true)   // sort by date and time
        }
        catch {
            print("Error in events init")                                       // print error message
        }
    }
    
    // Add an event to events
    func addEvent(event: Event) {
        do {
            let realm = try Realm()                                             // grab default Realm
            try realm.write() {                                                 // write to Realm
                realm.add(event)                                                // add event to Realm
            }
            events = realm.objects(Event).sorted("dateTime", ascending: true)   // sort by date and time
        }
        catch {
            print("Error in addEvent")                                          // print error message
        }
    }
    
    // Edit an event from events
    func editEvent(event: Event, editedEvent: Event) {
        do {
            let realm = try Realm()                                             // grab default Realm
            
            // TODO: edit for lineup
            try realm.write {                                                   // write to Realm
                if (event.name != editedEvent.name || event.location != editedEvent.location || event.dateTime != editedEvent.dateTime) {
                    event.name = editedEvent.name                               // set event name
                    event.location = editedEvent.location                       // set event location
                    event.dateTime = editedEvent.dateTime                       // set event date and time
                }
            }
            events = realm.objects(Event).sorted("dateTime", ascending: true)   // sort by date and time
        }
        catch {
            print("Error in editEvent")
        }
    }
    
    // Delete an event from events
    func deleteEvent(event: Event) {
        do {
            let realm = try Realm()                                             // grab default Realm
            try realm.write() {                                                 // write to Realm
                realm.delete(event)                                             // delete event from Realm
            }
            events = realm.objects(Event).sorted("dateTime", ascending: true)   // sort by date and time
        }
        catch {
            print("Error in trashEvent")                                        // print error message
        }
    }
}