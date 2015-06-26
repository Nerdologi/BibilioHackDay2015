//
//  SecondViewController.swift
//  BiblioHackDay2015
//
//  Created by Silvio Messi on 24/06/15.
//  Copyright © 2015 Nerdologi. All rights reserved.
//

import UIKit
import MapKit

class MapView: UIViewController {

    @IBOutlet weak var map: MKMapView!
    let regionRadius: CLLocationDistance = 1000
    var artworks = [Artwork]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MILANO
        let initialLocation = CLLocation(latitude: 45.4642700, longitude:9.1895100)
        centerMapOnLocation(initialLocation)
        self.loadInitialData()
        map.addAnnotations(artworks)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	func centerMapOnLocation(location: CLLocation) {
		let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
			regionRadius * 15.0, regionRadius * 15.0)
		self.map.setRegion(coordinateRegion, animated: true)
	}
	
    func loadInitialData() {
        let fileName = NSBundle.mainBundle().pathForResource("MuseiJSON", ofType: "json");
        var readError : NSError?
        var data: NSData = NSData(contentsOfFile: fileName!, options:nil ,error: &readError)!
        var datastring = NSString(data: data, encoding: NSUTF8StringEncoding)
        var json: NSObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSObject
        let d = json.valueForKey("d") as! NSDictionary
        let results = d.valueForKey("results") as! NSArray
        for museum in  results {
            let name: String = museum.valueForKey("Cdenominaz_1696258377") as! String
            let lat : CLLocationDegrees = museum.valueForKey("Cglatitude_1370772947")!.doubleValue
            let lng : CLLocationDegrees = museum.valueForKey("Cglongitude_1371311400")!.doubleValue
            let address : String = museum.valueForKey("Cindirizzo_697902738") as! String
            let phone : String = museum.valueForKey("Ctel_1365663647") as! String
            let www : String = museum.valueForKey("Cwww_118167") as! String
            let artwork = Artwork(title: name ,subtitle: address + " - " + phone + " - " + www,coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lng))
            self.artworks.append(artwork)

        }
    }

}

