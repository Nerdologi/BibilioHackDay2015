//
//  MuseumDetailController.swift
//  BiblioHackDay2015
//
//  Created by Luca Perico on 26/06/15.
//  Copyright (c) 2015 Nerdologi. All rights reserved.
//

import WatchKit
import MuseumsKit

class MuseumDetailController: WKInterfaceController {
	var museum: Resource!
	
	@IBOutlet weak var museumTitle: WKInterfaceLabel!
	@IBOutlet weak var museumImage: WKInterfaceImage!
	
	var coords = CLLocationCoordinate2D()
	
	@IBOutlet weak var buttonImage: WKInterfaceButton!
	override func willActivate() {
		// This method is called when watch view controller is about to be visible to user
		super.willActivate()
	}
	
	override func didDeactivate() {
		// This method is called when watch view controller is no longer visible
		super.didDeactivate()
	}
	
	override func awakeWithContext(context: AnyObject?) {
		super.awakeWithContext(context)
		
		if let museum = context as? Resource {
			self.museum = museum
			self.museumTitle.setText(museum.getName())
			self.coords = museum.getCoordinate()
			
			// Scarico l'immagine
			let url = NSURL(string: self.museum.getDetailsImageLink())
			let downoloadImageTask = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
				dispatch_async(dispatch_get_main_queue()) {
					if (data != nil){
						let image = UIImage(data: data)
						self.buttonImage.setBackgroundImage(image)
					}
				}
			}
			downoloadImageTask.resume();
		}
	}
}
