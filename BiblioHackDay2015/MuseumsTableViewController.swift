//
//  MuseumsTableViewController.swift
//  BiblioHackDay2015
//
//  Created by Silvio Messi on 24/06/15.
//  Copyright © 2015 Nerdologi. All rights reserved.
//

import UIKit
import MapKit
import MuseumsKit

class MuseumsTableViewController: UITableViewController {
	
	var museumArray = [Resource(name: NSLocalizedString("loading", comment: ""), id: NSLocalizedString("loading", comment: ""), address: "", www: "", coordinate: CLLocationCoordinate2D(latitude: 2,longitude: 2), phone: "", mail: "", detailsImageLink: "", fullImageLink: "")]
	
	override func viewDidLoad() {
		super.viewDidLoad()
        self.navigationItem.title = "MUSEI"
        
		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false
		
		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		// self.navigationItem.rightBarButtonItem = self.editButtonItem()
		
		/*let url = NSURL(string: "https://commons.wikimedia.org/w/api.php?action=query&list=categorymembers&cmtitle=Category:Museums%20in%20Milan&format=json&cmlimit=500&cmtype=subcat")
		let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
		var error: NSError?
		let jsonResult: AnyObject? = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: &error)
		if (error == nil){
		if  (jsonResult as? NSDictionary != nil) {
		let query = jsonResult!.valueForKey("query") as! NSObject
		let museums = query.valueForKey("categorymembers") as! NSArray
		self.museumArray = []
		for museum in museums{
		self.museumArray.append(Resource(name:museum.valueForKey("title")!.description,link:museum.valueForKey("title")!.description))
		}
		}
		}
		else{
		self.museumArray = []
		self.museumArray = [Resource(name:NSLocalizedString("error", comment: ""),link: NSLocalizedString("error", comment: ""))]
		}
		dispatch_async(dispatch_get_main_queue(), { () -> Void in
		self.tableView.reloadData()
		})
		}
		task.resume()*/
		
		museumArray = []
        for museum in MuseumsHandler.getMuseumsList(MuseumsHandler())() {
            museumArray.append(Resource(name: museum.getName(), id: museum.getId(), address: museum.getAddres(), www: museum.getWww(), coordinate: museum.getCoordinate(), phone: museum.getPhone(), mail: museum.getMail(), detailsImageLink: museum.getDetailsImageLink(), fullImageLink: museum.getFullImageLink()))
        }
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: - Table view data source
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return museumArray.count
	}
	
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("museumCell", forIndexPath: indexPath) as! UITableViewCell
		let name = museumArray[indexPath.row].getName()
		cell.textLabel?.text = name
		if (name == NSLocalizedString("error", comment: "")){
			cell.accessoryType = UITableViewCellAccessoryType.None
			cell.selectionStyle = UITableViewCellSelectionStyle.None
			cell.userInteractionEnabled = false
		}
		return cell
	}
	
	
	/*
	// Override to support conditional editing of the table view.
	override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
	// Return false if you do not want the specified item to be editable.
	return true
	}
	*/
	
	/*
	// Override to support editing the table view.
	override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
	if editingStyle == .Delete {
	// Delete the row from the data source
	tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
	} else if editingStyle == .Insert {
	// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
	}
	}
	*/
	
	/*
	// Override to support rearranging the table view.
	override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
	
	}
	*/
	
	/*
	// Override to support conditional rearranging of the table view.
	override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
	// Return NO if you do not want the item to be re-orderable.
	return true
	}
	*/
	
	
	// MARK: - Navigation
	
	//In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		// Get the new view controller using segue.destinationViewController.
		// Pass the selected object to the new view controller.
		let detailsView = segue.destinationViewController as! MuseumDetailsViewController
        let museumIndex = self.tableView.indexPathForSelectedRow()?.row
        detailsView.museumID = museumArray[museumIndex!].getId()
        detailsView.image  = museumArray[museumIndex!].getDetailsImageLink()
        var info = ""
        if (museumArray[museumIndex!].getAddres() != ""){
            info = info + "\n" + museumArray[museumIndex!].getAddres()
        }
        if (museumArray[museumIndex!].getPhone() != ""){
            info = info + "\n" + museumArray[museumIndex!].getPhone()
        }
        if (museumArray[museumIndex!].getMail() != ""){
            info = info + "\n" + museumArray[museumIndex!].getMail()
        }
        detailsView.infoMuseum = info
        detailsView.museumName = museumArray[museumIndex!].getName()
	}
	
}
