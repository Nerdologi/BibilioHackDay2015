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
		}
	}
}
