//
//  MapViewController.swift
//  YOUC_Event_Page
//
//  Created by Derek Chang on 3/5/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//


import UIKit
import MapKit
import Parse
import AlamofireImage

class MapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MKMapViewDelegate {

    //MapView outlet
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var searchTextField: UITextField!
    //USE NIL to tell the search controller that you want to use the same
    //view you're srearching to display the results
    //Could specify a different view to display the results
    
    @IBOutlet weak var mapButton: UIImageView!
    
    var eventImage: UIImage!
    var ImageArray: [UIImage] = []
    
    
    
    //holds the events
    var events = [PFObject]()
    var filteredEvents  = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.layer.cornerRadius = 4
        searchTextField.clipsToBounds = true

        //places mapview on UCI
        setInitialLocation()
        
        //DUMMY DATA---------------------
        //Test pin
        mapView.delegate = self
        
        //set button image
        mapButton.image = UIImage(named: "filter")
        
        //--------------------------------
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Events")
        query.includeKeys(["author", "description", "date", "eventName", "coverImage", "location"])
        query.limit = 30
        
        query.findObjectsInBackground { (events, error) in
            if events != nil{
                self.events = events!
                self.populateEvents()
                
            }
        }
        
    
        
        
    }
    
    func populateEvents(){
        
        var location: PFGeoPoint = PFGeoPoint()
        for event in self.events{
            
            location = event["location"] as? PFGeoPoint ?? PFGeoPoint.init(latitude: 33.648196, longitude: -117.848940)
            
            let latitude: CLLocationDegrees = location.latitude
            let longitude: CLLocationDegrees  = location.longitude
            
            let title = event["eventName"] as! String

//            if let image = event.value(forKey: "coverImage")! as? PFFileObject ?? UIImage(named: "ice_cream_man"){
//                image.getDataInBackground {
//                    (imageData, error) in
//                    if (error == nil){
//                        let loadedImage = UIImage(data: imageData ?? Data.init())
//                        self.ImageArray.append(loadedImage!)
//                    }
//                }
//            }
            
            addPin(lat: latitude , long: longitude, title: title)


        }
    }
    
    //hides navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = false

    }
    
    //Triggered when the filter/map button is pressed
    @IBAction func mapButtonPressed(_ sender: Any) {
        print("button pressed")
//        if mapButton.image == UIImage(named: "filter"){
//            print("filter pressed")
//        }
        
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
    
    
    
    func addPin(lat: CLLocationDegrees, long: CLLocationDegrees, title: String){
        
        let annotation = MKPointAnnotation()
        let locationCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        //describe the coordinates of the annotation
        annotation.coordinate = locationCoordinate
        //attributes of the pin
        annotation.title = title
        
        //add Annotation to Mapview
        mapView.addAnnotation(annotation)
        
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
//        print("event image: ", eventImage)
        
        imageView.image = eventImage
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
