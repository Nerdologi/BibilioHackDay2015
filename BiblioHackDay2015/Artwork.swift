//
//  Artwork.swift
//  BiblioHackDay2015
//
//  Created by Silvio Messi on 25/06/15.
//  Copyright (c) 2015 Nerdologi. All rights reserved.
//

import MapKit

class Artwork: NSObject, MKAnnotation {
    let title: String
    let subtitle: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        super.init()
    }
}