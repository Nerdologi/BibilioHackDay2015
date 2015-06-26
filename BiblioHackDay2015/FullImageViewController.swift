//
//  FullImageViewController.swift
//  BiblioHackDay2015
//
//  Created by Silvio Messi on 25/06/15.
//  Copyright (c) 2015 Nerdologi. All rights reserved.
//

import UIKit

public class FullImageViewController: UIViewController {
    public var url = ""
    
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: self.url)
        let downoloadImageTask = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            dispatch_async(dispatch_get_main_queue()) {
                if (data != nil){
                    self.imageView.image = UIImage(data: data!)
                    self.loadingLabel.hidden = true
                }
            }
        }
        downoloadImageTask.resume();

        // Do any additional setup after loading the view.
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
