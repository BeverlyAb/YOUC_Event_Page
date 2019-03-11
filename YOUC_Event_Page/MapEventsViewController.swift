//
//  MapEventsViewController.swift
//  YOUC_Event_Page
//
//  Created by Derek Chang on 3/10/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit

class MapEventsViewController: UIViewController, UITableViewDataSource {
    
    

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        

        // Do any additional setup after loading the view.
    }
    
    //pressed back button
    @IBAction func goBack(_ sender: Any) {
        performSegue(withIdentifier: "goBack", sender: nil)
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell") as! MapEventsCell
        
        return cell
    }

}
