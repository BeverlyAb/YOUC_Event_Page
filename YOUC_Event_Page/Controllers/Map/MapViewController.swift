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

class MapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MKMapViewDelegate, CLLocationManagerDelegate {

    //MapView outlet
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var searchTextField: UITextField!
    //USE NIL to tell the search controller that you want to use the same
    //view you're srearching to display the results
    //Could specify a different view to display the results
    
    @IBOutlet weak var mapButton: UIImageView!
    
    
    
    
    //holds the events
    var events = [PFObject]()
    var filteredEvents  = [PFObject]()
    var selectedEvent: PFObject!
    
    var locationManager: CLLocationManager!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        searchTextField.layer.cornerRadius = 4
        searchTextField.clipsToBounds = true

        
        mapView.delegate = self
        
        //set button image
        mapButton.image = UIImage(named: "filter")
        
        //places mapview on UCI
        setInitialLocation()
        
//        //current location stuff
//        locationManager = CLLocationManager()
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//        locationManager.delegate = self as CLLocationManagerDelegate;
//
//        // user activated automatic authorization info mode
//        let status = CLLocationManager.authorizationStatus()
//        if status == .notDetermined || status == .denied || status == .authorizedWhenInUse {
//            // present an alert indicating location authorization required
//            // and offer to take the user to Settings for the app via
//            // UIApplication -openUrl: and UIApplicationOpenSettingsURLString
//            locationManager.requestAlwaysAuthorization()
//            locationManager.requestWhenInUseAuthorization()
//        }
//        locationManager.startUpdatingLocation()
//        locationManager.startUpdatingHeading()
        
        self.mapView.showsUserLocation = true
        
    }
    
    
    
    //hides navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
        self.getEvents()
        
    }
    
    func populateEvents(){
        
        var location: PFGeoPoint = PFGeoPoint()
        for event in self.events{
            
            location = event["location"] as? PFGeoPoint ?? PFGeoPoint.init(latitude: 33.648196, longitude: -117.848940)
            
            let latitude: CLLocationDegrees = location.latitude
            let longitude: CLLocationDegrees  = location.longitude
            
            let title = event["eventName"] as! String

            addPin(lat: latitude , long: longitude, title: title)


        }
    }
    
    func getEvents(){
        let query = PFQuery(className: "Events")
        query.includeKeys(["author", "description", "date", "eventName", "coverImage", "location"])
        query.limit = 30
        
        query.findObjectsInBackground { (events, error) in
            if events != nil{
                self.events = events!
                self.filteredEvents = self.events
                self.populateEvents()
                self.setInitialLocation()
            }
        }
    }
    
    
    
    
    //Triggered when the filter/map button is pressed
    @IBAction func mapButtonPressed(_ sender: Any) {
        print("button pressed")
//        if mapButton.image == UIImage(named: "filter"){
//            print("filter pressed")
//        }
        
    }
    

    @IBAction func beginSearching(_ sender: Any) {
//        performSegue(withIdentifier: "beginSearch", sender: nil)
        self.searchTextField.endEditing(true)
        print("beginning search")
    }
    
    //Getting and setting the intial location
    //used when starting up the app
    func setInitialLocation(){
        
        //Coordinates of UCI
        let mapCenter = CLLocationCoordinate2D(latitude: 33.646235, longitude: -117.842725)
        //Set the scale of the mapView
        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
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
        
//        print("???")
        let reuseID = "annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID)
        //add content to the view
        if (annotationView == nil){
            //if there is nothing on the view, then create the view
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            //when you tap on it, it tells you a pop-up
            annotationView!.canShowCallout = true
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            for event in self.filteredEvents{
                //find the event the given annotation is referring to
                if (annotation.title == event["eventName"] as? String){
                    //avoid error if there is no image attatched to the event
                    if event["coverImage"] != nil{
                        
                        //get image file + convert to workable image
                        let imageFile = event["coverImage"] as! PFFileObject
                        
                        let urlString = imageFile.url!
                        let url = URL(string: urlString)!
                        
                        imageView.af_setImage(withURL: url)
                        imageView.makeRounded()
                        
                        //If the object passed all the conditions, add the picture
                        if imageView.image != UIImage(named: "image_placeholder"){
                            annotationView!.leftCalloutAccessoryView = imageView
                        }
                        
                    }
                }
            }
        }
        //ADD button to the annotation view
        let btn = UIButton(type: .detailDisclosure)
        annotationView!.rightCalloutAccessoryView = btn
        return annotationView
        
    }

    //Function called when the user taps the info button on annotation view
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
       
        let selectedAnnotation = view.annotation
        
        for event in self.filteredEvents{
            
            if event["eventName"] as? String == selectedAnnotation?.title{
                
                //update the selected event to use in the prepare function
                selectedEvent = event
                performSegue(withIdentifier: "events", sender: nil)
            }
        }
    }
    

    
    
    //PREPARES FOR SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if selectedEvent != nil{
            let event = selectedEvent
            
            //Pass the selected movie to the details movies controller
            let eventsPage = segue.destination as! EventPageViewController
            
            //There is a variable in the class that we want to send stuff to that we define here
            eventsPage.event = event
            selectedEvent = nil
        }
        
        
    }
    

    
}
