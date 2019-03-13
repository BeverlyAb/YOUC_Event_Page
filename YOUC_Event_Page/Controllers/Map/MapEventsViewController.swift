//
//  MapEventsViewController.swift
//  YOUC_Event_Page
//
//  Created by Derek Chang on 3/10/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class MapEventsViewController: UIViewController, UITableViewDataSource, UITextFieldDelegate {
    
    

    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    //Dummy data
//    let data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
//                "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
//                "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
//                "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
//                "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]
    
//    var filteredData: [String]!
    
    var events = [PFObject]()
    var filteredEvents: [PFObject]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        searchBar.delegate = self
        
        //Populate filered Events
        let query = PFQuery(className: "Events")
        query.includeKeys(["author", "description", "date", "eventName", "coverImage", "location"])
        query.limit = 30
        
        query.findObjectsInBackground { (events, error) in
            if events != nil{
                self.events = events!
                self.filteredEvents = events
                print(self.filteredEvents)
                self.tableView.reloadData()
            }
        }
        
        
        
        
        //makes the user ready to edit the text field
        self.searchBar.becomeFirstResponder()
        
        
        // Do any additional setup after loading the view.
    }
    
    //hides navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    
    //pressed back button
    @IBAction func goBack(_ sender: Any) {
//        performSegue(withIdentifier: "goBack", sender: nil)
        dismiss(animated: true, completion: nil) 
        
    }
    
    //USER IS TYPING
    @IBAction func activeSearching(_ sender: Any) {
        
        filteredEvents = searchBar.text?.isEmpty ?? true ? events : events.filter { (item: PFObject) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return (item["eventName"] as! String).range(of: searchBar.text ?? "", options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredEvents?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell") as! MapEventsCell
        
        let event = filteredEvents[indexPath.row]
        
        cell.EventName.text = event["eventName"] as? String
        
        
        if event["coverImage"] != nil{
            let imageFile = event["coverImage"] as! PFFileObject
            
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            
            
            
            cell.EventImage.af_setImage(withURL: url)
        }
    
        
        
        return cell
    }

    
    //PREPARES FOR SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let event = events[indexPath.row]
        
        //Pass the selected movie to the details movies controller
        let eventsPage = segue.destination as! EventPageViewController
        
        //There is a variable in the class that we want to send stuff to that we define here
        eventsPage.event = event
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
