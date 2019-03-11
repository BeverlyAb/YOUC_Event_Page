//
//  MapViewController.swift
//  YOUC_Event_Page
//
//  Created by Derek Chang on 3/5/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//


import UIKit
import MapKit
import AlamofireImage

class MapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MKMapViewDelegate {

    //MapView outlet
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var searchTextField: UITextField!
    //USE NIL to tell the search controller that you want to use the same
    //view you're srearching to display the results
    //Could specify a different view to display the results
    
    @IBOutlet weak var mapButton: UIImageView!
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    //holds the events
    var events = [String]()
    var filteredEvents  = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.layer.cornerRadius = 4
        searchTextField.clipsToBounds = true

        //places mapview on UCI
        setInitialLocation()
        
        
        //Test pin
        addPin(lat: 33.640495, long: -117.844296)
        mapView.delegate = self
        
        //set button image
        mapButton.image = UIImage(named: "filter")
        
        //dummy data
        events = [
        "Event 1",
        "Event 2",
        "Event 3"
        ]
        
        
        // Setup the Search Controller
        
        //allows the class to be informed as text changes within the UISearchbar
        searchController.searchResultsUpdater = self
        //Set to false because you dont want the view to be obscured
        searchController.obscuresBackgroundDuringPresentation = false
        //Add title to the search bar
        searchController.searchBar.placeholder = "Search Events"
        //Make interface builder compatable with UIsearchController
        navigationItem.searchController = searchController
        //makes sure the search bar disappears if the user goes to another view controller
        definesPresentationContext = true

    }
    
    //Triggered when the filter/map button is pressed
    @IBAction func mapButtonPressed(_ sender: Any) {
        print("button pressed")
        if mapButton.image == UIImage(named: "filter"){
            print("filter pressed")
        }
        
    }
    

    @IBAction func beginSearching(_ sender: Any) {
        performSegue(withIdentifier: "beginSearch", sender: nil)
        
        self.searchTextField.endEditing(true)
        
        print("beginning search")
    }
    
    //Getting and setting the intial location
    //used when starting up the app
    func setInitialLocation(){
        
        //Coordinates of UCI
        let mapCenter = CLLocationCoordinate2D(latitude: 33.640495, longitude: -117.844296)
        
        //Set the scale of the mapView
        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        
        //Creating the map object
        let region = MKCoordinateRegion(center: mapCenter, span: mapSpan)
        
        mapView.setRegion(region, animated: false)
        
    }
    
    
    
    func addPin(lat: CLLocationDegrees, long: CLLocationDegrees){
        
        let annotation = MKPointAnnotation()
        
        let locationCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        //describe the coordinates of the annotation
        annotation.coordinate = locationCoordinate
        
        //attributes of the pin
        annotation.title = "Test"
        
        //add Annotation to Mapview
        mapView.addAnnotation(annotation)
    }
    
    
    //Search bar stuff below
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    //custom pins
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseID = "annotation"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID)
        
        //add content to the view
        if (annotationView == nil){
            //if there is nothing on the view, then create the view
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            //when you tap on it, it tells you a pop-up
            annotationView!.canShowCallout = true
            annotationView!.leftCalloutAccessoryView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        }
        
        
        //insert the picture into the annotationview
        let imageView = annotationView?.leftCalloutAccessoryView as! UIImageView
        
        //TODO - put in image of the post
        imageView.image = UIImage.init()
        
        return annotationView
        
        
        
        
    }

    
    
//    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
//        filteredEvents = events.filter({( candy : Candy) -> Bool in
//            return candy.name.lowercased().contains(searchText.lowercased())
//        })
//
//        tableView.reloadData()
//    }

    

    
}

//Allows MapViewcontroller to respond to the search bar
extension MapViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
    }
}