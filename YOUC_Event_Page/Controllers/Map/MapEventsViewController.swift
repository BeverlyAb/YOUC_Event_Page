//
//  MapEventsViewController.swift
//  YOUC_Event_Page
//
//  Created by Derek Chang on 3/10/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit

class MapEventsViewController: UIViewController, UITableViewDataSource, UITextFieldDelegate {
    
    

    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    //Dummy data
    let data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
                "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
                "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
                "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
                "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]
    
    var filteredData: [String]!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        searchBar.delegate = self
        
        filteredData = data
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
    
    @IBAction func activeSearching(_ sender: Any) {
        
        filteredData = searchBar.text?.isEmpty ?? true ? data : data.filter { (item: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.range(of: searchBar.text ?? "", options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell") as! MapEventsCell
        
        cell.EventName.text = filteredData[indexPath.row]
        
        
        return cell
    }

}
