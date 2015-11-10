#App Design Document
Author: Leslie Kim

##Objective
To provide a software that makes scheduling/booking comedy shows easier.
Eventually could expand into other industries/event booking.

##Audience
Comedy clubs and comedy show bookers

##Experience
The current method of scheduling a show at larger, established clubs, is to have
comedians send in their availabilities for the upcoming week, manually enter in
all comedian avails into an excel sheet (usually), and then create a schedule
in excel based off the updated avails sheet. After the schedule is created, an
email goes out to each comedian to confirm a show and the schedule is then
updated with a confirm status or a replacement is found. This app would allow
bookers to send out an email to all comedians with a link to where they can
select which shows they are available for, which would update a list for bookers
to select from. Bookers can then select from the list or manually enter in a
comedian, the app would send a confirmation email and once confirmed, the app
would be updated or booker would be notified to select a replacement.

##Technical
Flask backend customized server.
Simple web app for comedians to select avails.

####External Services

####Screens

####Views / View Controllers/ Classes

Class Show: Create Show object that sets a name, date and time for a show,
has an array of Comedians and will send out emails to Comedians to send in
avails.

Class Comedian: Creates Comedian object that sets name, email and phone number.

####Data Models
Shows: Name (String), Date/Time (String)
Comedian: Name(String), Email (String), Phone number (String)

##MVP Milestones
