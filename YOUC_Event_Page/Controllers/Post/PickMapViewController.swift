//
//  MapViewController.swift
//  YOUC_Event_Page
//
//  Created by Beverly Abadines on 3/4/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit

protocol PickMapViewControllerDelegate : class {
    func locationsPickedLocation(controller: PickMapViewController, latitude: NSNumber, longitude: NSNumber, addr : String)
}

class PickMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UISearchBarDelegate {
    weak var delegate : PickMapViewControllerDelegate!
    let local = "Irvine"
    var results: NSArray = []
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    //access areas
    let CLIENT_ID = "QA1L0Z0ZNA2QVEEDHFPQWK0I5F1DE3GPLSNW4BZEBGJXUCFL"
    let CLIENT_SECRET = "W2AOE1TYC4MHK5SZYOUGX0J3LVRALMPB4CXT3ZH21ZCPUMCU"

    
    //refresh
    let refreshController = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        refreshController.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        tableView.refreshControl = refreshController
    }
    //refresh
    @objc func onRefresh(_ refreshControl: UIRefreshControl){
        results = []
        self.tableView.reloadData()
        if (searchBar.text! != ""){
            fetchLocations(searchBar.text!)
        } else{
            fetchLocations(local)
        }
        refreshController.endRefreshing()
    }
    
    
    //dismiss
    @IBAction func onBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    //-------------------search bar stuff------------
    @objc func fetchLocations(_ query: String, near: String = "Irvine") {
        let baseUrlString = "https://api.foursquare.com/v2/venues/search?"
        let queryString = "client_id=\(CLIENT_ID)&client_secret=\(CLIENT_SECRET)&v=20141020&near=\(near),CA&query=\(query)"
        
        let url = URL(string: baseUrlString + queryString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
        let request = URLRequest(url: url)
        
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(with: request,
                                                         completionHandler: { (dataOrNil, response, error) in
                                                            if let data = dataOrNil {
                                                                if let responseDictionary = try! JSONSerialization.jsonObject(
                                                                    with: data, options:[]) as? NSDictionary {
                                                                    NSLog("response: \(responseDictionary)")
                                                                    self.results = responseDictionary.value(forKeyPath: "response.venues") as! NSArray
                                                                
                                                                    self.tableView.reloadData()
                                                                }
                                                            }
        });
        task.resume()
    }

    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = NSString(string: searchBar.text!).replacingCharacters(in: range, with: text)
        fetchLocations(newText)
        
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fetchLocations(searchBar.text!)
    }
}

extension PickMapViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell") as! LocationCell
        
        cell.location = results[(indexPath as NSIndexPath).row] as? NSDictionary
        
        return cell
    }
    
    
    // What to do when a cell is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var street = ""
        var city = ""
        var state = ""
        var postal = ""
        
        
        // This is the selected venue
        let venue = results[(indexPath as NSIndexPath).row] as! NSDictionary
        
        // Lat and lng of venue selected
        let lat = venue.value(forKeyPath: "location.lat") as! NSNumber
        let lng = venue.value(forKeyPath: "location.lng") as! NSNumber
        //var writtenAddr = venue.value(forKeyPath: "location.address") as! String
        if addrChecker(venue: venue, keyString: "location.address"){
            street  = venue.value(forKeyPath: "location.address") as! String
        }
        if addrChecker(venue: venue, keyString: "location.city"){
            city = venue.value(forKeyPath: "location.city") as! String
        }
        if addrChecker(venue: venue, keyString: "location.state"){
            state = venue.value(forKeyPath: "location.state") as! String
        }
        if addrChecker(venue: venue, keyString: "location.postalCode"){
            postal = venue.value(forKeyPath: "location.postalCode") as! String
        }
        let writtenAddr = street + " " + city + ", " + state + " " + postal
        // Set the latitude and longitude of the venue and send it to the protocol
        delegate.locationsPickedLocation(controller: self, latitude: lat, longitude: lng, addr : writtenAddr)
        // Return to the PhotoMapViewController with the lat and lng of venue
        navigationController?.popViewController(animated: true)
        
        let latString = "\(lat)"
        let lngString = "\(lng)"
        
        print(latString + " " + lngString)
    }
    //-------------------checks if venue val are not nil--------------------
    func addrChecker(venue: NSDictionary, keyString : String)-> Bool{
        if (venue.value(forKeyPath: keyString) as? String != nil &&
            venue.value(forKeyPath: keyString) as! String != "" ){
            return true
        } else{
            return false
        }
    }
}
