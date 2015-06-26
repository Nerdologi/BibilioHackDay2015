//
//  Artwork.swift
//  BiblioHackDay2015
//
//  Created by Silvio Messi on 25/06/15.
//  Copyright (c) 2015 Nerdologi. All rights reserved.
//

import MapKit

public class Artwork: NSObject, MKAnnotation {
    public let title: String
    public let subtitle: String
    public let coordinate: CLLocationCoordinate2D
    
    public init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        super.init()
    }
}