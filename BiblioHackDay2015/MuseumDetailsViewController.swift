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

    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

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
