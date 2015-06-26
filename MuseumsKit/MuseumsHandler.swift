 //
//  MuseumsHandler.swift
//  BiblioHackDay2015
//
//  Created by Luca Perico on 26/06/15.
//  Copyright (c) 2015 Nerdologi. All rights reserved.
//

import Foundation
import MapKit

public class MuseumsHandler {
	
	var museumArray = [Resource(name: NSLocalizedString("loading", comment: ""), id: NSLocalizedString("loading", comment: ""), address: "", www: "", coordinate: CLLocationCoordinate2D(latitude: 2,longitude: 2), phone: "", mail: "", detailsImageLink: "", fullImageLink: "")]
    
	
	public init(){
		
	}

	public func getMuseumsList () -> [Resource] {
		let fileName = NSBundle.mainBundle().pathForResource("./MuseiJSON", ofType: "json")//NSBundle.mainBundle().pathForResource("MuseiJSON", ofType: "json");
		
		var readError : NSError?
		var data: NSData = NSData(contentsOfFile: fileName!, options:nil, error: &readError)!
		var datastring = NSString(data: data, encoding: NSUTF8StringEncoding)
		var json: NSObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSObject
		let d = json.valueForKey("d") as! NSDictionary
		let results = d.valueForKey("results") as! NSArray
		
		self.museumArray = []
        var id = ""
        var name = ""
        var address = ""
        var www  = ""
        var lat : CLLocationDegrees = 2
        var lng : CLLocationDegrees = 2
        var phone = ""
        var mail = ""
        var imageUrl = ""
        var coordinate: CLLocationCoordinate2D
        
        
        for museum in  results{
			if museum.valueForKey("ID") != nil{
                id = museum.valueForKey("ID") as! String
            }
            if museum.valueForKey("Cdenominaz_1696258377") != nil{
                name = museum.valueForKey("Cdenominaz_1696258377") as! String
            }
            if museum.valueForKey("Cwww_118167") != nil{
                www = museum.valueForKey("Cwww_118167") as! String
            }
            if museum.valueForKey("Cindirizzo_697902738") != nil{
                address = museum.valueForKey("Cindirizzo_697902738") as! String
            }
            if museum.valueForKey("Ctel_1365663647") != nil{
                phone = museum.valueForKey("Ctel_1365663647") as! String
            }
            if museum.valueForKey("Cmail_3343799") != nil{
                mail = museum.valueForKey("Cmail_3343799") as! String
            }
            if museum.valueForKey("Cglatitude_1370772947") != nil{
                lat = museum.valueForKey("Cglatitude_1370772947")!.doubleValue
            }
            if museum.valueForKey("Cglongitude_1371311400") != nil{
                lng = museum.valueForKey("Cglongitude_1371311400")!.doubleValue
            }
            if museum.valueForKey("cimageurl") != nil{
                imageUrl = museum.valueForKey("cimageurl") as! String
            }
            coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
          		self.museumArray.append(Resource(name: name, id: id, address: address, www: www, coordinate: coordinate, phone: phone, mail: mail, detailsImageLink: imageUrl, fullImageLink: ""))
		}
		
		return self.museumArray
	}
}