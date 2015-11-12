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

####Screens

####Views / View Controllers/ Classes

Tab Bar View Controller

MyShowsViewController (initial VC): VC w/ TableView of ComedyShowTableViewCells.
TableViewCells has 3 labels (name, comedians, location) left aligned and 3
labels right aligned (date, time and All Confirmed label that is displayed once
lineup is set). Nav bar button to add shows. The add button will bring up a
modal that allows user to enter a name for the show and edit the date and time.

ShowDetailsViewController: When a ComedyShowTableViewCell is selected on
MyShowsViewController, ShowDetailsVC will appear. It contains info on the show
and a TableView to add/update the lineup. There will be a right arrow expand
button for each show info detail to edit via a modal which will bring up a
similar modal to adding a show. The LineUpTableViewCells will be draggable to
rearrange lineup with a label for the comedian's name on the left. On the right
there will be two buttons. If H button is selected, this is the host. If C is
selected, the comedian has confirmed his/her spot. Unconfirmed comedians TVCs
will have a red bg that clears once confirmed. In the middle, start time will be
auto-generated for each comedian which can be edited by touching the time, at
which point the TVC expands to allow for editing of time.

Class Show: Show object has name, comedians, location, Date and Time properties.
Class gets/sets all properties.

Class Comedian: Comedian object has name, email and phone number properties.
Class gets/sets all properties

####Data Models
Shows: Name (String), Date/Time (String)
Comedian: Name(String), Email (String), Phone number (String)

##MVP Milestones
