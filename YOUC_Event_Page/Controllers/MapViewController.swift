//
//  MapViewController.swift
//  YOUC_Event_Page
//
//  Created by Beverly Abadines on 3/4/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MKMapViewDelegate, UISearchBarDelegate {
   var results: NSArray = []
    @IBOutlet weak var mapView: MKMapView!
    //access areas
    let CLIENT_ID = "QA1L0Z0ZNA2QVEEDHFPQWK0I5F1DE3GPLSNW4BZEBGJXUCFL"
    let CLIENT_SECRET = "W2AOE1TYC4MHK5SZYOUGX0J3LVRALMPB4CXT3ZH21ZCPUMCU"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInitialLocation()
        mapView.delegate = self
    }
    

    /* ------ TODO: Set initial location after launching app */
    func setInitialLocation(){
        //needs coords and span (zoom)
        //coord
        let mapCentered = CLLocationCoordinate2D(latitude: 33.66946, longitude: -117.82311)
        
        //1 degree = 69 miles in map (span)
        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        //var to create map
        let region = MKCoordinateRegion(center: mapCentered, span: mapSpan)
        
        mapView.setRegion(region, animated: false)
        
    }
    
    //dismiss
    @IBAction func onBackButton(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
    //send location values back
    @IBAction func onSaveButton(_ sender: Any) {
    }
    
    //-------------------search bar stuff------------
    func fetchLocations(_ query: String, near: String = "San Francisco") {
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
                                                                    //self.tableView.reloadData()
                                                                    
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
