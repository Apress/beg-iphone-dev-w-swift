//
//  Place.swift
//  WhereAmI
//
//  Created by Kim Topley on 7/3/14.
//  Copyright (c) 2014 Apress. All rights reserved.
//

import Foundation
import MapKit

class Place : NSObject, MKAnnotation {
    let title:String
    let subtitle:String
    var coordinate:CLLocationCoordinate2D
    
    init(title:String, subtitle:String, coordinate:CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
