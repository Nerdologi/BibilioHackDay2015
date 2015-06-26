//
//  SubCategoriesTableViewController.swift
//  BiblioHackDay2015
//
//  Created by Silvio Messi on 24/06/15.
//  Copyright © 2015 Nerdologi. All rights reserved.
//

import UIKit
import MapKit

public class SubCategoriesTableViewController: UITableViewController {

    public var topCategory = ""
    var categoriesArray = [Resource(name: NSLocalizedString("loading", comment: ""), id: NSLocalizedString("loading", comment: ""), address: "", www: "", coordinate: CLLocationCoordinate2D(latitude: 2,longitude: 2), phone: "", mail: "", detailsImageLink: "", fullImageLink: "")]
    var imageFlag: Bool = false;

    public override func viewDidLoad() {
        super.viewDidLoad()
        downloadData(self.topCategory)
        
        //necessario per la creazione dinamica delle TableView per le sottocategorie
        self.tableView.registerClass(CategoryOrImageCellTableViewCell.self , forCellReuseIdentifier: "categoryCell")
        let nib = UINib(nibName: "CategoryOrImageCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "customCategoryCell")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
    }
    
    public func downloadData(var topCategory :String){
        topCategory = topCategory.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        let stringUrl = "https://commons.wikimedia.org/w/api.php?action=query&list=categorymembers&cmtitle=" + topCategory + "&format=json&cmlimit=500&cmtype=subcat"
        let url = NSURL(string: stringUrl)
        let taskCategory = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            var error: NSError?
            let jsonResult: AnyObject? = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: &error)
            if (error == nil){
                if  (jsonResult as? NSDictionary != nil) {
                    let query = jsonResult!.valueForKey("query") as! NSObject
                    let categories = query.valueForKey("categorymembers") as! NSArray
                    self.categoriesArray = []
                    for category in categories{
                        self.categoriesArray.append(Resource(name:category.valueForKey("title")!.description, id:category.valueForKey("title")!.description))
                    }
                }
            else{
                self.categoriesArray = []
                self.categoriesArray = [Resource(name:NSLocalizedString("error", comment: ""),id: NSLocalizedString("error", comment: ""))]
            }
            
            //provo a scaricare le immagini
            if (self.categoriesArray.count == 0){
                self.categoriesArray = [Resource(name: NSLocalizedString("loading", comment: ""),id: NSLocalizedString("loading", comment: ""))]
                let stringUrl = "https://commons.wikimedia.org/w/api.php?action=query&list=categorymembers&cmtitle=" + topCategory + "&format=json&cmlimit=500&cmtype=file"
                let url = NSURL(string: stringUrl)
                let taskImage = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
                    var error: NSError?
                    let jsonResult: AnyObject? = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: &error)
                    if (error == nil){
                        if  (jsonResult as? NSDictionary != nil) {
                            let query = jsonResult!.valueForKey("query") as! NSObject
                            let images = query.valueForKey("categorymembers") as! NSArray
                            self.categoriesArray = []
                            for image in images{
                                var imageName = (image.valueForKey("title")?.description)!
                                imageName = imageName.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
                                //recupero il link all'immagine
                                let stringUrl = "https://commons.wikimedia.org/w/api.php?action=query&titles=" + imageName + "&prop=imageinfo&iiprop=url&format=json&iiurlheight=100"
                                let url = NSURL(string: stringUrl)
                                let taskLinkImage = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
                                var error: NSError?
                                let jsonResult: AnyObject? = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: &error)
                                    if(error == nil){
                                        if  (jsonResult as? NSDictionary != nil) {
                                            let query = jsonResult!.valueForKey("query") as! NSObject
                                            let pages = query.valueForKey("pages") as! NSDictionary
                                            for (_, value) in pages {
                                                if (value.objectForKey("imageinfo") != nil){
                                                    let imageInfo = value.valueForKey("imageinfo") as! NSArray
                                                    self.categoriesArray.append(Resource(name:imageName,id: imageInfo[0].valueForKey("thumburl")!.description, fullImageLink:imageInfo[0].valueForKey("url")!.description ))
                                                }
                                            }
                                        }
                                    }
                                    else {
                                        self.categoriesArray = []
                                        self.categoriesArray = [Resource(name:NSLocalizedString("error", comment: ""),id: NSLocalizedString("error", comment: ""))]
                                    }
                                    self.imageFlag = true;
                                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                    self.tableView.reloadData()
                                    })
                                }
                                taskLinkImage.resume()
                            }
                        }
                    }
                    else {
                        self.categoriesArray = []
                        self.categoriesArray = [Resource(name:NSLocalizedString("error", comment: ""),id: NSLocalizedString("error", comment: ""))]
                    }
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.tableView.reloadData()
                    })
                }
                taskImage.resume()
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        }
        }
        taskCategory.resume()
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    public override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    public override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoriesArray.count
    }

    
    public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("customCategoryCell") as! CategoryOrImageCellTableViewCell
        if (imageFlag){
            //cell.accessoryType = UITableViewCellAccessoryType.None
            //cell.selectionStyle = UITableViewCellSelectionStyle.None
            //cell.userInteractionEnabled = false
            let stringUrl = self.categoriesArray[indexPath.row].getId()
            let url = NSURL(string: stringUrl)
            let downoloadImageTask = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
                dispatch_async(dispatch_get_main_queue()) {
                    if (data != nil){
                        cell.pictureImage!.image = UIImage(data: data!)
                        cell.categoryLabel.text = ""
                    }
                }
            }
            downoloadImageTask.resume();
        }
        else{
            cell.categoryLabel.text = self.categoriesArray[indexPath.row].getName()
        }
        return cell
        
    }
    
    public override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (imageFlag == false){
            let selectedItem = categoriesArray[(indexPath.row)].getId() as String
            let newTableView : SubCategoriesTableViewController = SubCategoriesTableViewController.alloc()
            newTableView.categoriesArray = [Resource(name: NSLocalizedString("loading", comment: ""),id: NSLocalizedString("loading", comment: ""))]
            newTableView.topCategory = selectedItem
            newTableView.imageFlag = false;
            self.navigationController?.pushViewController(newTableView, animated: true)
        }
        else{
            let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let fullImageView : FullImageViewController = mainStoryboard.instantiateViewControllerWithIdentifier("fullImageIdentifier") as! FullImageViewController
            fullImageView.url = categoriesArray[(indexPath.row)].getFullImageLink() as String
            self.navigationController?.pushViewController(fullImageView, animated: true)
        }
    }
    
    public override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (imageFlag == false){
            return 44
        }
        else{
            return 117
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
