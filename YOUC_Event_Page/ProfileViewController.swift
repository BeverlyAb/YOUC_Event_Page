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
        let user = PFUser.current()!
        profileUserNameLabel.text = user.username
        eventsCountLabel.text = "0"
        getEvents()
        
        
    }
    
    func getEvents() {
        let query = PFQuery(className: "User")
        query.includeKey("Event")
        query.includeKey("createdAt")
//        query.whereKey("Event_user", equalTo: PFUser.current()!)
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground { (going_events, error) in
            if going_events != nil {
                self.going_events = going_events!
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func onAddEventClicked(_ sender: Any) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return going_events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = going_events[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoingEventsTableViewCell") as! GoingEventsTableViewCell
        
        let user = event["author"] as! PFUser
        cell.eventAuthorLabel.text = user.username
        
        cell.eventSummaryLabel.text = event["summary"]
        
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
