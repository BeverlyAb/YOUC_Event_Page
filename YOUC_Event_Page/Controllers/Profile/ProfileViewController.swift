//
//  ProfileViewController.swift
//  YOUC_Event_Page
//
//  Created by Hermain Hanif on 3/11/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var eventsCountLabel: UILabel!
    @IBOutlet weak var profileUserNameLabel: UILabel!
    
    
    
    
    let user = PFUser.current()!
    var going_events: [PFObject] = []
    var going_events_info: [PFObject] = []
    
    //    @IBOutlet weak var tableView: UITableView!
    //    @IBOutlet weak var profileImageView: UIImageView!
    //    @IBOutlet weak var eventsCountLabel: UILabel!
    //    @IBOutlet weak var profileUserNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let user = PFUser.current()!
        profileUserNameLabel.text = user.username
        setImage()
        if user["going_events"] != nil {
            going_events = user["going_events"] as! [PFObject]
            print(going_events.count)
            getUserEvents()
        }
        eventsCountLabel.text = String(going_events.count)
    }
    
    @IBAction func unwindToProfile(_ sender: UIStoryboardSegue){}
    
    
    func setImage() {
        let user = PFUser.current()!
        if user["user_image"] != nil {
            let profile = user["user_image"] as! PFFileObject
            let urlString = profile.url!
            let url = URL(string: urlString)!
            
            profileImageView.af_setImage(withURL: url)
        }
    }
    
    
    func getUserEvents() {
        
        print("EVENTS")
        if going_events != [] {
            for event in going_events {
                print("eventID", event.objectId!)
                let query = PFQuery(className: "Events")
                query.whereKey("objectId", equalTo: event.objectId!)
                
                query.findObjectsInBackground { (event, error) in
                    if error != nil {
                        print(error!.localizedDescription)
                    } else {
                        let event = event![0]
                        self.going_events_info.append(event)
                        self.tableView.reloadData()
                    }
                    
                }
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if going_events_info.count != 0 {
            if section != going_events_info.count{
                return going_events_info.count
            }
            else{
                return 0;
            }
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoingEventsTableViewCell") as! GoingEventsTableViewCell
        
        if self.going_events_info.count != 0 {
            let event = self.going_events_info[indexPath.row]
            print(event)
            
            cell.eventAuthorLabel.text = event["eventName"] as? String
            
            cell.eventSummaryLabel.text = event["description"] as? String
            
            cell.dateLabel.text = event["date"] as? String
            
        }
        else {
            print( "in here" )
            cell.dateLabel.text = ""
            cell.eventAuthorLabel.text = ""
            cell.eventSummaryLabel.text = "Add events to go to!"
        }
        return cell
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
