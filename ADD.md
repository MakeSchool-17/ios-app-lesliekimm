#App Design Document
Author: Leslie Kim

##Objective
To provide an app that will help in organizing confirmed/unconfirmed
performers, speakers, musicians for events.

##Audience
Event planners

##Experience
The current method of scheduling a comedy show (small/one booker vs comedy
club) is that a booker emails/calls/texts comedians and booker usually uses
excel or some other software to save information. Sometimes this is simply
done in Notes app on iOS or equivalent app on other devices. Other times, it
may be done from memory or just jotted down on paper/notebook. This app would
allow the planner to import contacts from their cell phone, create/edit
events and select contacts for the event, send out confirmation requests, and
have the RSVPs be handled by text messages which updates the app.

##Technical
Realm for local storage
Twilio for texting framework

####External Services
???

####Screens
See /Wireframe/JPGs/8_AllVCs.jpg

####Views / View Controllers/ Classes

VIEW CONTROLLERS:
Tab Bar View Controller: 4 tabs
1) Upcoming: Displays all upcoming events in order from earliest scheduled to
   latest
2) History: List of all past events in order from the most recent to oldest
3) Contacts: Contact list of all contacts
4) Settings: Account info

UpcomingViewController (initial VC): VC w/ TableView of EventTableViewCells.
TVCs have 3 labels (name, lineup, location) left aligned and 3 labels right
aligned (date, time and confirmed label). Nav bar button to add events. The add
button will segues to AddEventVC which allows user to create new events. Click
on an existing event via it's EventTVC to edit an event which will segue to
EventDispalyVC. Left swipe delete will not be activated (can only be done while
editing event - should not be so easy to delete an event). EventTVCs will be red
until entire lineup is confirmed and the confirmed label is hidden. When all
confirmed, the cell will no longer be red and confirmed label will display "All
Confirmed".

AddEventViewController: Has a container view that embeds the EventDispalyVC.
Save nav bar button will save an event. Cancel nav bar button will cancel
creating an event.

EventDisplayViewController: VC to add/edit an event. Text field to insert name,
Date picker to select date and time, textfield to insert location, Edit Lineup
button to segue to EditLineupVC to edit lineup and table view to display
lineup of LineupTableViewCells. LineupTVC will display contact's name, whether
someone is a host (if your event needs a host), and whether or not someone is
confirmed. If a contact is not yet confirmed, cell is red and "x" in confirmed
location. Once contact is confirmed, "C" in confirmed location and cell is no
longer red. Bottom toolbar with trash icon will only appear when EventDisplayVC
is accessed through selected a EventTVC from UpcomingVC.

SelectLineupViewController: VC to edit lineup. Will have a search bar at the
top to conveniently search through contacts. Table view will contain two
sections. Top section will have LineupTableViewCells of contacts that are
already in the lineup. Bottom section will be contacts that are not currently
selected. Select the check mark to move a contact to top section, select Host
label to mark as host. Click "Send confirmation request" to send text message
only to contacts that were most recently added. (Need to figure out how to send
text to individuals that were already sent requests for those that may need a
reminder.)

HistoryViewController: Table view that shows all past events in order from most
recent to oldest. Nothing is editable here. Just for show

ContactsViewController: Table view of contacts that display name. Add nav bar
button will segue to AddContactVC to create a new contact. Click on existing
contact to edit existing contact. Contacts can be deleted via left swipe. import
nav bar button will allow user to import contacts from their Contacts app.
(Should be able to use Twilio to do this.)

AddContactViewController: Has a container view that embeds the ContactDisplayVC.
Save nav bar will save a new contact. Cancel nav bar button will cancel creating
a new contact.

ContactDisplayViewController: VC to add/edit new contact. Text field for name,
cell and email address. When accessed via touch from ContactsVC, toolbar appears
at bottom with trash icon to delete a contact.

AccountViewController: Contains user information. This can be expanded on after
MVP is done.

Contacts list of ComedianTVCs that lists just the name. Alphabet
scroll on right to jump to a letter. Add nav button will allow user to add a
comedian on the AddComedianVC. Selecting existing comedian will take you to
EditComedianVC. A one time import of contacts list will be available at the
beginning to import from cell phone contacts. Could add import nav button in
case bulk import needs to happen after initial import.

CLASSES:
Event class: Contains string for name, lineup, location, and confirmed. NSDate
             object for date and time.

Contact class: Contains string for name, email and cell.

Performer class: Contains string for name and bool for host and confirmed.

####Data Models
NA

##MVP Milestones
Milestone 1: Complete wireframe - DONE (continual updates in progress)
Milestone 2: Create UI in XCode - DONE (continual updates in progress)
Milestone 3: Implement Realm to store locally - DONE
Milestone 4: Implement import for ContactsVC
Milestone 5: Implement EditLineupVC - this includes UpcomingVC, AddEventVC and
             EditLineupVC - need to work on EditLineupVC, implement Selecting
             lineup

Post MVP Milestones
Milestone 6: Implement other VCs - History & Account VC
Milestone 7: Work on UI/UX
