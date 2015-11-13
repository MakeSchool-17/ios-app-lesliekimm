#App Design Document
Author: Leslie Kim

##Objective
To provide a software that makes scheduling/booking comedy shows easier.
Eventually could expand into other industries/event booking.

##Audience
Comedy clubs and comedy show bookers

##Experience
The current method of scheduling a comedy show (small/one booker vs comedy
club) is that a booker emails/calls/texts comedians and booker usually uses
excel or some other software to save information. Sometimes this is simply
done in Notes app on iOS or equivalent app on other devices. Other times, it
may be done from memory or just jotted down on paper/notebook. This app would
load contacts from a booker's cell phone into the app (booker can one time
import only selected contacts, does not have to import all contacts) for a
contact list. Then booker creates shows and adds comedians to the event. Emails
are sent out to comedians with a link to a very simple web app where comedian
hits confirm or cancel. This updates the backend and event is updated in
booker's app.

##Technical
Flask backend customized server.
Simple web app for comedians to confirm spots.

####External Services
???

####Screens
See /Wireframe/AllVCs.jpg

####Views / View Controllers/ Classes

Tab Bar View Controller: 4 tabs
1) Upcoming: Displays all upcoming shows in order from earliest scheduled to
   latest
2) Past: List of all past shows in order from the most recent show to oldest
3) Comedians: Contact list of all comedians
4) Settings: Account info

UpcomingViewController (initial VC): VC w/ TableView of
ComedyShowTableViewCells. TableViewCells has 3 labels (name, comedians,
location) left aligned and 3 labels right aligned (date, time and All
Confirmed label that is displayed once lineup is set). Nav bar button to add 
shows. The add button will bring up AddShowVC that allows user to enter a name
for the show and edit the date and time. Any time a ComedyShowTVC is clicked,
EditLineupVC will popup. From EditLineupVC, show info and lineup can be edited.
Shows will not be able to be deleted with swipe left functionality. Show can
only be deleted once the specific show is selected from it's EditLineupVC.
Until shows are all confirmed, the right side of ComedyShowTVC will be red.

EditLineupVC: VC will display show info up top, lineup in the middle and two
buttons. Tapping the right arrow on any show info will bring up a EditShowVC
where all show info can be edited at once. Tapping on any date/time fields will
present a dropdown so user can edit date/time from the same screen. For the
lineup, user seelcts Edit Lineup button and it goes to SelectComediansVC. Once
lineup is selected, the PerformersTableViewCells will display the comedian's
name, autocreated time based on show start time, displays an H for host and C
if comedian is confirmed. Performance time can be edited by tapping the time.
If a comedian is not confirmed, PerformersTVC is red. PerformersTVC is drag and
droppable. Send confirmation request will send an email/text (haven't decided
yet) asking comedian to confirm via very simple web app or 'Type C to confirm'
text message. This updates the info on the app. Button only sends requests to
those who have not been sent requests. (THIS IS THE MAIN PART OF THE APP AND
NEEDS TO BE FLESHED OUT MORE. Still thinking of how to deal with changing times,
send out requests, replace comedians, etc.)

SelectComediansVC: Will look very much like ComediansVC (contact list). Search
bar at top and Table View with SelectComedianTVC. Each TVC has comedian name,
greyed out H and greyed out check mark. If H is selected, indicates a host.
When check mark selected, indicated that comedian should be added to lineup.
Can add/remove as many as needed at once. Add all button will update the lineup
with all checked off comedians. Right alphabet scroll available to jump to a
letter.

PastShowsVC: TableView that shows all PastComedyShowTVCs in order from most
recent to oldest. Nothing is editable here.

ComediansVC: Contacts list of ComedianTVCs that lists just the name. Alphabet
scroll on right to jump to a letter. Add nav button will allow user to add a
comedian on the AddComedianVC. Selecting existing comedian will take you to
EditComedianVC. A one time import of contacts list will be available at the
beginning to import from cell phone contacts. Could add import nav button in
case bulk import needs to happen after initial import.

AddComedianVC: Enter name, cell and email to add a comedian.

EditComedianVC: Name, cell and email are in each text field and editable by
selecting a text field.

SettingsVC: This VC needs to be fleshed out a bit more as well. Might just hold
info about user/booker. Name, cell and email.

Class Show: Show object has name, comedians, location, Date and Time properties.

Class Comedian: Comedian object has name, email and phone number properties.

####Data Models
Shows: Name (String), Date/Time (String)
Comedian: Name(String), Email (String), Phone number (String)

##MVP Milestones
Milestone 1: Complete wireframe
Milestone 2: Create UI in XCode
Milestone 3: Implement EditLineupVC - this includes UpcomingVC, AddShowVC,
             EditShowVC, SelectComediansVC as well.
Milestone 4: Implement Realm to store locally (not necessarily an app that
             needs to store data on server yet.)
Milestone 5: Implement other VCs

MVP: Show organizer with data stored locally.
