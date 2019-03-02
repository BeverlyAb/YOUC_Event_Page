# YOUC Event Page

## Developers
Derek Chang
Tejal Patel
Richard Absin
Hermain Hanif
Beverly Abadines Quon

## 1. User Stories (Required and Optional)

**Required Must-have Stories**

* Relies on user's (clubs/vendors/anyone) to post events
* Each post(sorted by school) will have tags that allow for organization
* Kinda like facebook where a user can say (going, interested)
* Sort based on event popularity/recent
* Maybe add mapkit!!
* Login
    * Guest mode
    * Persistent login
* Suggestions(based on user preferences - major, interests, location)
* Target Market: Clubs/events that aren't specifically heard on facebook
* For mall events that are cool, but not known by the majority
* Favorite events
* Separate user profiles and organization profiles

**Optional Nice-to-have Stories*
 * Other universities/colleges can use
 * Notifications
 * Share events with other users 
 * Share events with other organizations/collabs 
 * MeetUp app functionalities(meet up with group events)
 * Direct Messaging??
 After signing up for an event, you get an email that allows you to save the event to your calendar
 add google sign in
 
 
 

## 2. Screen Archetypes

 * First Screen = App Logo
 * Login 
     * (Request Access to FB & other user generated stuff)
     * Separate btwn User vs. Organization Admin vs. Guest
* Second Screen = Map with Interested Events 
 * User Profile page
     * (Separate kinds of users - ORGANIZATION or USER)
     * edit profile page(button)
     * add profile picture(static - top right, like instagram layout)
     * display past posts(scroll view)

## 3. Navigation

**Tab Navigation** (Tab to Screen)

 * Profile Tab
 * Organization Tab
 * Map Tab (with events)
 * CHANGE THIS IF YOU WANT(BELOW)
 * Swipe gestures!
     * Makes it more modern
     * acts like a back button
 * Map
     * includes searching for events
     * making events 
     * pins events, click to event details 
         * modally segues title, and summary of event
         * "see more" to modally segue to organization event page

TODO
* MAIN  | MAP | PROFILE 
OPTIONAL
* MAIN  | MAP | CHAT | PROFILE

**Flow Navigation** (Screen to Screen)

 * Login Screen 
   * guest mode 
   * otherwise sign up authorizes login/sign up
   * puts you to map events(MAP VIEW)
       * if no events, click add:
           * search button ( look for events )
           * update button ( add events )
               * if part of organization 
 * Main Screen(table view)
       * Holds events users are attending 
       * Indicator for events that are recommended
       * Recommended events based on interests
       * Gray out/ delete? events that have passed or user attended
       * Option to comment
