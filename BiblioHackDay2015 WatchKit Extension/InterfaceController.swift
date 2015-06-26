//
//  InterfaceController.swift
//  BiblioHackDay2015 WatchKit Extension
//
//  Created by Luca Perico on 26/06/15.
//  Copyright (c) 2015 Nerdologi. All rights reserved.
//

import WatchKit
import Foundation
import MapKit
import MuseumsKit

class InterfaceController: WKInterfaceController {
	
	@IBOutlet weak var museumsTable: WKInterfaceTable!
	let museumsList: [String] = ["Museo 1", "Museo 2"]
	var museumArray = [Resource(name: NSLocalizedString("loading", comment: ""), id: NSLocalizedString("loading", comment: ""), address: "", www: "", coordinate: CLLocationCoordinate2D(latitude: 2,longitude: 2), phone: "", mail: "", detailsImageLink: "", fullImageLink: "")]
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
		
		self.museumArray = []
		self.museumArray = MuseumsHandler.getMuseumsList(MuseumsHandler())()
		self.museumsTable.setNumberOfRows(self.museumArray.count, withRowType: "MuseumTableRow")
		
		let rows = museumArray.map() { _ in "MuseumRow" }
				museumsTable.setRowTypes(rows)
				for i in 0 ..< museumArray.count {
						let title = museumArray[i].getName()
						if let row = museumsTable.rowControllerAtIndex(i) as? MuseumTableRow{
								row.rowTitle.setText(title)
							}
					}
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
	
	override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
		if segueIdentifier == "MuseumDetails" {
			let museum = museumArray[rowIndex]
			return museum
		}
		return nil
	}

}
