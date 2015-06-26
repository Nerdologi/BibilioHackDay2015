//
//  Resource.swift
//  BiblioHackDay2015
//
//  Created by Silvio Messi on 25/06/15.
//  Copyright © 2015 Nerdologi. All rights reserved.
//

import Foundation
import MapKit

public class Resource{
    internal var name: String = ""
    internal var id: String = ""
    internal var address : String = ""
    internal var www  : String = ""
    internal var coordinate: CLLocationCoordinate2D?
    internal var phone : String = ""
    internal var mail : String = ""
    //image for details view
    internal var detailsImageLink : String = ""
    //link to full image
    internal var fullImageLink: String = ""
    
    // Init for subcategories
    public init(name: String, id: String){
        var bufferName = name.stringByReplacingOccurrencesOfString("Category:", withString: "")
        bufferName = bufferName.stringByReplacingOccurrencesOfString("(Milan)", withString: "")
        self.name = bufferName
        self.id = id
        self.address = ""
        self.www = ""
        self.coordinate = CLLocationCoordinate2DMake(2, 2)
        self.phone = ""
        self.mail = ""
        self.detailsImageLink = ""
        self.fullImageLink = ""
    }
    
    public init(name: String, id: String, fullImageLink: String){
        self.name = name
        self.id = id
        self.address = ""
        self.www = ""
        self.coordinate = CLLocationCoordinate2DMake(2, 2)
        self.phone = ""
        self.mail = ""
        self.detailsImageLink = ""
        self.fullImageLink = fullImageLink
    }
    
    //inti per musueum details
    public init(name :String, id:String, address:String, www:String, coordinate:CLLocationCoordinate2D, phone:String, mail:String, detailsImageLink:String, fullImageLink:String ){
        self.name = name
        self.id = id
        self.address = address
        self.www = www
        self.coordinate = coordinate
        self.phone = phone
        self.mail = mail
        self.detailsImageLink = detailsImageLink
        self.fullImageLink = fullImageLink
    }
    
    public func getName ()-> String{
        return self.name
    }
    
    public func getId ()-> String{
        return self.id
    }
    
    public func getAddres ()-> String{
        return self.address
    }
    
    public func getWww ()-> String{
        return self.www
    }
    
    public func getCoordinate ()-> CLLocationCoordinate2D{
        return self.coordinate!
    }
    
    public func getMail ()-> String{
        return self.mail
    }
    
    public func getDetailsImageLink ()-> String{
        return self.detailsImageLink
    }
    
    public func getFullImageLink()-> String{
        return self.fullImageLink
    }
    
    public func getPhone() -> String {
        return self.phone
    }
}
