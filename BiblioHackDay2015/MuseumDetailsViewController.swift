//
//  MuseumDetails.swift
//  BiblioHackDay2015
//
//  Created by Lorenzo on 26/06/15.
//  Copyright (c) 2015 Nerdologi. All rights reserved.
//

import UIKit

public class MuseumDetailsViewController: UIViewController {
    public var museumID = ""
    public var image = ""
    public var infoMuseum = ""
    public var museumName = ""

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var detailsImage: UIImageView!
    @IBOutlet weak var titlte: UILabel!
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: self.image)
        let downloadImageTask = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            
            dispatch_async(dispatch_get_main_queue()) {
                if (data != nil){
                    self.detailsImage.image = UIImage(data: data!)
                }
            }
        }
        downloadImageTask.resume()
        
        infoLabel.lineBreakMode = .ByWordWrapping // or NSLineBreakMode.ByWordWrapping
        infoLabel.numberOfLines = 0
        infoLabel.sizeToFit()
        infoLabel.textAlignment = NSTextAlignment.Center
        infoLabel.text = self.infoMuseum
        titlte.text = self.museumName
        titlte.textAlignment = NSTextAlignment.Center


        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var info: UILabel!

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let categoriesContoller = segue.destinationViewController as! SubCategoriesTableViewController
        categoriesContoller.topCategory = museumID
    }
    

}
