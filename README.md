# YOUC

## Developers
* **Derek Chang**
   - Map view
   - Involves creating a map that shows all the events
   - Ability to filter events on the events coming soon
   <a href="https://imgur.com/E7lJxcl"><img src="https://i.imgur.com/I56qT2S.gif" /></a>
* **Tejal Patel**
   - Login View
   <img src='https://github.com/BeverlyAb/YOUC_Event_Page/blob/profilePage/Login.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
* **Richard Absin**
   - Making the Event Page
   - Here, users can see more information about an event
   - They also have the option of marking "GOING" or "INTERESTED" on the event
   <img src='https://github.com/BeverlyAb/YOUC_Event_Page/blob/master/EventsViewController.gif' width ='' alt='Video Walkthrough' />
* **Hermain Hanif**
   - Making the Profile Page:
   <img src='http://g.recordit.co/aCpGnOYwFr.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
* **Beverly Abadines Quon**
   - Creating Events (Post Page):
   -  <img src='https://i.imgur.com/b8Vpxqq.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

### App Description
YOUC Event Page connects UCI students to events happening all over campus!

### App Idea Evaluation
- Mobile: This app can be used anywhere and lets students organize all the cool events happening near them. 
It integrates features such as maps, camera, location, and event summaries using tableviews.
- Story: It helps students be more aware of events happening nearby and help track which events catches their eye! Clubs and other organizations would love have to this.
- Market: For now it is targeted to UCI students, but it can be expanded to other universities, businesses, and admins.
   Yes, it provides the huge value of connecting everyone. 
- Habit: Whenever students are free and want to attend events based on their interest, they can use our app! Users can create events too! 
- Scope: It is challenging and the work is split up into at least 5 different goals, yet it all has to integrate  together. 
Yes, even without the optional goals, YOUC Event Page is still meritable app. Our team sees the vision for this app. 

## 1. User Stories (Required and Optional)

**Required Must-have Stories**

1) Login and Logout
   + Persistent login
2) Users can view events nearby 
   + Displays events via pins on Map
   + Can Search events using search bar and tableview
   + Can Swipe to go back
3) Users can see a detailed view of Events
   + Displays cover image, name of event, time, place and summary
   + Users can select if they are "Going" to an Event or are "Interested"
4) Users can access their profile
   + Users can modify their personal information using settings or seek help via contacts
   + Users see their basic information (name, profile image, # of events going to)
   +  Displays the list of events the user wants to go to
5) Users can create their own events
   + Fills in the information 
   + Can select location with tableview (uses AFNetworking and foursquare api for location info.)
   + Can select cover image
   

**Optional Nice-to-have Stories**
 * Other universities/colleges can use
 * Notifications
 * if user wants to see and edit the event they just posted
 * Share events with other users 
 * Share events with other organizations/collabs 
 * MeetUp app functionalities(meet up with group events)
 * Direct Messaging??
 * After signing up for an event, you get an email that allows you to save the event to your calendar
 add google sign in
 * Each post(sorted by school) will have tags that allow for organization
 * Favorite events
 * Separate user profiles and organization profiles
 * Extended Login features
 * Users can share videos of their club
 * For mall events that are cool, but not known by the majority
 * Sort based on event popularity/recent
 
 
## 2. Screen Archetypes

 * Launch Screen = Logo
 * Login Page (Story #1)
 * Map Page (Story #2)
 * Event Page(Story #3)
 * User Profile Page (Story #4)
 * Post Page (Story #5)
 * Settings Page (Story #3)

## 3. Navigation

**Tab Navigation** (Tab to Screen)
* Tabs:
  * Map
    * includes searching for events
    * pins events, click to event details 
      * modally segues title, and summary of event
      * "see more" to modally segue to organization event page    
   * Profile Tab
      * has profile image, name and events user is going to
      * Includes button for "Settings"
   * Post Tab
      + Ask for event information
         + Includes table view for searching locations
         + Resets values after submit

**Flow Navigation** (Screen to Screen)
* Screens:
  * Launch Screen
  * Login Screen
    * Sign in or Create (respectively) 
    * If already signed in, then there is persistent login
    * Leads to 3 tabs mentioned above  
  * Map Tab
    * map with events as pins
      * pins lead to Event Page (can add events)
    * search bar leads to tableview of events near Area
  * Profile Tab
    * Displays Events user is going to 
    * Includes Settings
  * Settings 
    * Updates user info
    * Includes Logout
    * Leads to "Contact Us" 
  * Post Tab
    * Create Event
      * Leads to Tableview of Location
      * Image Picker for updating cover album
      * Stays on page after submit
       
### Wireframes
![App Draft](ScreenTransitions.jpeg)

### App Pitch Presentation
https://docs.google.com/presentation/d/1yzsn-Yyz0DSc1R-ORoaFYQVD9UbwtR0EuMSXdHHQ-SA/edit?usp=sharing

