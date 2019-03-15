//
//  EventPageViewController.swift
//  YOUCEvent
//
//  Created by Richard Absin on 3/8/19.
//  Copyright © 2019 richard.absin24@outlook.com. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class EventPageViewController: UIViewController {
    
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var organizationImageView: UIImageView!
    @IBOutlet weak var organizationNameLabel: UILabel!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var goingButton: UIButton!
    @IBOutlet weak var interestedButton: UIButton!
    
    // For keeping track of the button status.
    // Without these variables, a new event would be added each time a button is pressed
    var goingPressed = false
    var interestedPressed = false
    
    // Arrays to hold the events and the goingEvents
    var events = [PFObject]()
    var event: PFObject!
    var goingEvents = [PFObject]()
    var latestEvent: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        //        self.eventDescriptionLabel.text = event["description"] as? String
        //        self.organizationNameLabel.text = event["author"] as? String
        //        self.eventNameLabel.text = event["eventName"] as? String
        
        
        
        // Query to get the events
        let query = PFQuery(className: "Events")
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackground { (events, error) in
            if events != nil {
                self.events = events!
                
                // ***** CURRENTLY SELF.EVENTS[0] since I don't have the event selected.
                // Need to pass in the data from Derek's section
                let event = self.events[1]
                
                self.eventDescriptionLabel.text = event["description"] as? String
                self.organizationNameLabel.text = event["author"] as? String
                self.eventNameLabel.text = event["eventName"] as? String
                
            }
        }
        
        
        
    }
    
    
    @IBAction func swipeRight(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onGoingPressed(_ sender: Any) {
        goingPressed = !goingPressed
        let user = PFUser.current()!
        let event = events[2]
        
        
        if goingPressed {
            //            let user = PFUser.current()!
            
            //            user[
            //            // Push the event onto Parse
            //            let event = events[1]
            user.add(event, forKey: "going_events");
            //
            //            let goingEvents = PFObject(className: "goingEvents")
            //            goingEvents["event"] = event
            //
            //            event.add(goingEvents, forKey: "goingEvents")
            user.saveInBackground { (success, error) in
                if success {
                    print("goingEvent saved")
                } else {
                    print("Error saving event")
                }
            }
        }
            //
        else {
            user.remove(event, forKey: "going_events")
            //            // Remove the event to avoid duplicates
            //            let query = PFQuery(className: "goingEvents")
            //            query.limit = 20
            
            user.saveInBackground { (success, error) in
                if success {
                    print("goingEvent removed")
                } else {
                    print("Error removing event")
                }
            }
            //
            //            query.findObjectsInBackground { (goingEvents, error) in
            //                if goingEvents != nil {
            //                    self.goingEvents = goingEvents!
            //
            //                    let goingEvent = self.goingEvents[0]
            //
            //                    goingEvent.deleteInBackground()
            //                }
            //            }
        }
    }
    
    @IBAction func onInterestedPressed(_ sender: Any) {
        //print("INTERESTED BUTTON PRESSED")
        interestedPressed = !interestedPressed
        
    }
    
}
