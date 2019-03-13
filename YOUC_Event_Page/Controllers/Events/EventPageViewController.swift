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
    var goingEvents = [PFObject]()
    var latestEvent: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Query to get the events
        let query = PFQuery(className: "Events")
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackground { (events, error) in
            if events != nil {
                self.events = events!
                
                // ***** CURRENTLY SELF.EVENTS[0] since I don't have the event selected.
                // Need to pass in the data from Derek's section
                let event = self.events[0]
                
                self.eventDescriptionLabel.text = event["description"] as? String
                self.organizationNameLabel.text = event["author"] as? String
                self.eventNameLabel.text = event["eventName"] as? String
                
            }
        }
        
        
        
    }
    
    
    @IBAction func onGoingPressed(_ sender: Any) {
        goingPressed = !goingPressed
        
        
        if goingPressed {
            // Push the event onto Parse
            let event = events[0]
            
            let goingEvents = PFObject(className: "goingEvents")
            goingEvents["event"] = event
            
            event.add(goingEvents, forKey: "goingEvents")
            event.saveInBackground { (success, error) in
                if success {
                    print("goingEvent saved")
                } else {
                    print("Error saving comment")
                }
            }
        }
        
        else {
            // Remove the event to avoid duplicates
            let query = PFQuery(className: "goingEvents")
            query.limit = 20
            
            query.findObjectsInBackground { (goingEvents, error) in
                if goingEvents != nil {
                    self.goingEvents = goingEvents!
                    
                    let goingEvent = self.goingEvents[0]
                    
                    goingEvent.deleteInBackground()
                }
            }
        }
    }
    
    @IBAction func onInterestedPressed(_ sender: Any) {
        //print("INTERESTED BUTTON PRESSED")
        interestedPressed = !interestedPressed
        
    }
    
}
