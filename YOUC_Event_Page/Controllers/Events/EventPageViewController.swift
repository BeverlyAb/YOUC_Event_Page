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
    @IBOutlet weak var goingButton: YOUCGoingButton!
    @IBOutlet weak var interestedButton: UIButton!
    
    @IBOutlet weak var dataLabel: UILabel!
    // For keeping track of the button status.
    // Without these variables, a new event would be added each time a button is pressed
    var goingPressed = false
    var interestedPressed = false
    
    // Arrays to hold the events and the goingEvents
    //    var events = [PFObject]()
    var event: PFObject!
    var going_events: [PFObject] = []
    
    @IBOutlet weak var locationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
//        going_events.removeAll()
        let user = event["author"] as! PFUser
        
        self.eventDescriptionLabel.text = event["description"] as? String
        self.organizationNameLabel.text = event["organization_name"] as? String
        self.eventNameLabel.text = event["eventName"] as? String
        
//        self.dataLabel.text = event["date"] as? String
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "MM/dd/yyyy HH:mm"
        dateFormatterGet.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatterGet.locale = Locale(identifier: "en_US")
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy  hh:mm a"
        dateFormatterPrint.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatterPrint.locale = Locale(identifier: "en_US_POSIX")
        dateFormatterPrint.amSymbol = "AM"
        dateFormatterPrint.pmSymbol = "PM"
       
        
        if let date = dateFormatterGet.date(from: event["date"]! as! String){
            self.dataLabel.text = dateFormatterPrint.string(from: date)
        }else{
            self.dataLabel.text = event["date"] as? String
        }
        
        self.locationLabel.text = event["readable_addr"] as? String
        self.locationLabel.sizeToFit()
        
        if event["coverImage"] != nil{
            let imageFile = event["coverImage"] as! PFFileObject
            
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            
            self.eventImageView.af_setImage(withURL: url)
        }
        
        if user["user_image"] != nil{
            let imageFile = user["user_image"] as! PFFileObject
            
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            
            self.organizationImageView.makeRounded()
            self.organizationImageView.af_setImage(withURL: url)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        going_events.removeAll()

        let user = PFUser.current()!

        // Get the events
        if user["going_events"] != nil {
            going_events = user["going_events"] as! [PFObject]
        }
        
        // Check if our event is in going_events
        goingPressed = checkUserGoing()
        
        // Update the button accordingly
        goingButton.activateButton(bool: goingPressed)
    }
    
    
    @IBAction func swipeRight(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.2
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func onGoingPressed(_ sender: Any) {
        goingPressed = !goingPressed
        let user = PFUser.current()!
        
        if goingPressed {
            userIsGoing(user: user)
        }
        else {
            userIsNotGoing(user: user)
        }
    }
    
    @IBAction func onInterestedPressed(_ sender: Any) {
        interestedPressed = !interestedPressed
        
    }
    
    
    func userIsGoing(user: PFUser) {
        let user = PFUser.current()!
        user.add(event, forKey: "going_events");
        user.saveInBackground { (success, error) in
            if success {
                print("goingEvent saved")
            } else {
                print("Error saving event")
            }
        }
    }
    
    func userIsNotGoing(user: PFUser) {
        user.remove(event, forKey: "going_events");
        user.saveInBackground { (success, error) in
            if success {
                print("goingEvent removed")
            } else {
                print("Error removing event")
            }
        }
    }
    
    
    
    
    
    func checkUserGoing() -> Bool {
        for going_event in going_events {
            if event.objectId! == going_event.objectId {
                return true
            }
        }
        return false
    }
}
extension UIImageView {
    
    func makeRounded() {
        let radius = self.frame.height/2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
