//
//  ProfileViewController.swift
//  YOUC_Event_Page
//
//  Created by Hermain Hanif on 3/5/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var going_events = [PFObject]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var eventsCountLabel: UILabel!
    @IBOutlet weak var profileUserNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        let user = PFUser.current()!
//        profileUserNameLabel.text = user.username
//        setImage()
        eventsCountLabel.text = String(going_events.count)
        getEvents()
        
        
        
    }
    
    func setImage() {
        let user = PFUser.current()!
        let profile = user["user_image"] as! PFFileObject
        let urlString = profile.url!
        let url = URL(string: urlString)!
        
        profileImageView.af_setImage(withURL: url)
    }
    
    func getEvents() {
        let query = PFQuery(className: "User")
        query.includeKey("events")
        query.includeKey("events.author")
//        query.includeKey("createdAt")
//        query.whereKey("Event_user", equalTo: PFUser.current()!)
        query.addDescendingOrder("createdAt")
//        if PFUser.current().events() != nil {
//            self.going_events = PFUser.current().events()
//              self.tableView.reloadData()
//        }
        
        
        
        
//        query.findObjectsInBackground { (going_events, error) in
//            if going_events != nil {
//                self.going_events = going_events!
//                self.tableView.reloadData()
//            }
//        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if going_events.count != 0 {
            return going_events.count
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoingEventsTableViewCell") as! GoingEventsTableViewCell
        
        if going_events.count != 0 {
            let event = going_events[indexPath.row]
            
            let user = event["author"] as! PFUser
            cell.eventAuthorLabel.text = user.username
            
    //        cell.eventSummaryLabel.text = event["description"]
            
    //        cell.dateLabel.text = event["date"]

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
