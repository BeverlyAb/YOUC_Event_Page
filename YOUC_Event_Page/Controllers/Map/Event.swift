//
//  Event.swift
//  YOUC_Event_Page
//
//  Created by Derek Chang on 3/13/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit
import MapKit
import Foundation
import Parse

class Event: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    

    let eventName: String?
    let eventImage: UIImage?
    
    
    init(eventName: String, eventImage: UIImage, coordinate: CLLocationCoordinate2D)  {
        self.eventName = eventName
        self.eventImage = eventImage
        self.coordinate = coordinate
        
        super.init()
    }
    
//    init?(event: [PFFileObject]){
    
//        self.eventName =
        
//    }
    
    
}
