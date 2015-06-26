//
//  MuseumMapViewController.swift
//  BiblioHackDay2015
//
//  Created by Luca Perico on 26/06/15.
//  Copyright (c) 2015 Nerdologi. All rights reserved.
//

import WatchKit
import UIKit
import MapKit
import MuseumsKit

class MuseumMapViewController: WKInterfaceController {

	@IBOutlet weak var museumMap: WKInterfaceMap!
	let regionRadius: CLLocationDistance = 500
	var artworks = [Artwork]()
	
	override func willActivate() {
		// This method is called when watch view controller is about to be visible to user
		super.willActivate()
		//MILANO
		var points: [CLLocationCoordinate2D] = []
		let center = CLLocation(latitude: 45.4642700, longitude:9.1895100)
		points = self.loadInitialData()
		for point in points {
			museumMap.addAnnotation(point, withPinColor: .Red)
		}
		centerMapOnLocation(center)
	}
	
	override func didDeactivate() {
		// This method is called when watch view controller is no longer visible
		super.didDeactivate()
	}
	
	override func awakeWithContext(context: AnyObject?) {
		super.awakeWithContext(context)

	}
	
	func loadInitialData() -> [CLLocationCoordinate2D]{
		let fileName = NSBundle.mainBundle().pathForResource("MuseiJSON", ofType: "json");
		var readError : NSError?
		var data: NSData = NSData(contentsOfFile: fileName!, options:nil ,error: &readError)!
		var datastring = NSString(data: data, encoding: NSUTF8StringEncoding)
		var json: NSObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSObject
		let d = json.valueForKey("d") as! NSDictionary
		let results = d.valueForKey("results") as! NSArray
		var points: [CLLocationCoordinate2D] = []
		for museum in  results{
			let lat : CLLocationDegrees = museum.valueForKey("Cglatitude_1370772947")!.doubleValue
			let lng : CLLocationDegrees = museum.valueForKey("Cglongitude_1371311400")!.doubleValue
			let point = CLLocationCoordinate2D(latitude: lat, longitude: lng)
			points.append(point)
		}
		
		return points
	}
	
	func centerMapOnLocation(location: CLLocation) {
		let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
			regionRadius * 20.0, regionRadius * 20.0)

		self.museumMap?.setRegion(coordinateRegion)
	}
}