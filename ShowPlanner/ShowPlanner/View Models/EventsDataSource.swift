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
    static var sharedEventsDatsSource = EventsDataSource()                      // use static var to create singleton
    var events: Results<Event>!                                                 // declare events var
    
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
    func addEvent(event: Event, lineupToUse: Array<LineupNS>) {
        do {
            let realm = try Realm()                                             // grab default Realm
            
            let lineupList = List<Lineup>()                                     // initialize Realm lineupList
            var confirmed = true                                                // var to keep track of if event is confirmed
            
            // iterate through lineupToUse and create Lineup Realm objects to append to lineupList
            for lineupNS in lineupToUse {
                let lineup = Lineup()                                           // initialize a Lineup Realm object
                lineup.name = lineupNS.name                                     // set lineup name to lineupNS name
                lineup.confirmed = lineupNS.confirmed                           // set lineup confirmed to lineupNS confirmed
                lineupList.append(lineup)                                       // append to lineupList
            }
            
            // check to see if all lineup is confirmed
            for lineupNS in lineupToUse {
                if !lineupNS.confirmed {                                        // if lineupNS is not confirmed
                    confirmed = false                                           // event is not confirmed
                    break                                                       // break if there is even one non confirmation
                }                                                               // if all confirmed, event will remained confirmed
            }
            
            // if there was no initial lineup, event is unconfirmed
            if lineupToUse.count == 0 {                                         // if lineupToUse is empty
                confirmed = false                                               // event is not confirmed
            }
            
            event.confirmed = confirmed                                         // set event confirmed to confirmed
            
            event.lineupList = lineupList                                       // set lineupList of event to lineupList
            
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
    func editEvent(event: Event, editedEvent: Event, lineupToUse: Array<LineupNS>) {
        do {
            let realm = try Realm()                                             // grab default Realm
            
            try realm.write {                                                   // write to Realm
                if (event.name != editedEvent.name || event.location != editedEvent.location || event.dateTime != editedEvent.dateTime) {
                    event.name = editedEvent.name                               // set event name
                    event.location = editedEvent.location                       // set event location
                    event.dateTime = editedEvent.dateTime                       // set event date and time
                }
                
                var confirmed = true                                            // var to keep track of if event is confirmed
                
                event.lineupList.removeAll()                                    // clear any lineup objects
                
                // iterate through lineupToUse and create Lineup Realm objects to append to lineupList
                for lineupNS in lineupToUse {
                    let lineup = Lineup()                                       // initialize a Lineup object
                    lineup.name = lineupNS.name                                 // set lineup name to lineupNS name
                    lineup.confirmed = lineupNS.confirmed                       // set lineup confirmed to lineupNS confirmed
                    event.lineupList.append(lineup)                             // append to lineupList
                }
                
                // check to see if all lineup is confirmed
                for lineupNS in lineupToUse {
                    if !lineupNS.confirmed {                                    // if lineupNS is not confirmed
                        confirmed = false                                       // event is not confirmed
                        break                                                   // break if there is even one non confirmation
                    }                                                           // if all confirmed, event will remained confirmed
                }
                
                // if there was no lineup, event is unconfirmed
                if lineupToUse.count == 0 {                                     // if lineupToUse is empty
                    confirmed = false                                           // event is not confirmed
                }
                
                event.confirmed = confirmed                                     // set event confirmed to confirmed
            }
            events = realm.objects(Event).sorted("dateTime", ascending: true)   // sort by date and time
        }
        catch {
            print("Error in editEvent")                                         // print error message
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