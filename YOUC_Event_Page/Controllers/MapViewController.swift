//
//  MapViewController.swift
//  YOUC_Event_Page
//
//  Created by Beverly Abadines on 3/4/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
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
    
    @IBAction func onBackButton(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSaveButton(_ sender: Any) {
    }
    
}
