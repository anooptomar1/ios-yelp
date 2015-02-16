//
//  DetailsViewController.swift
//  yelpHelp
//
//  Created by Anoop tomar on 2/15/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var business: Business!;
    var client: YelpClient!;
    
    @IBOutlet weak var backImage: UIImageView!
    
    @IBOutlet weak var businessName: UILabel!
    
    @IBOutlet weak var ratingUrl: UIImageView!
    
    @IBOutlet weak var moreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // println(business.Id);
        
        // add navivation title
        self.navigationController?.navigationBar.barTintColor = UIColor.redColor();
        var titleLabel = UILabel();
        titleLabel.text = "Details View";
        titleLabel.textColor = UIColor.whiteColor();
        titleLabel.sizeToFit();
        titleLabel.backgroundColor = UIColor.clearColor();
        titleLabel.font = UIFont(name: "Chalkduster", size: 20);
        self.navigationItem.titleView = titleLabel;
        
        // add buttons to navigation bar
        var cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Bordered, target: self, action: "onCancelButton");
        cancelButton.tintColor = UIColor.whiteColor();
        cancelButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Chalkduster", size: 12)!], forState: UIControlState.Normal)
        self.navigationItem.leftBarButtonItem = cancelButton;
        downloadBusinessDetails();
        // Do any additional setup after loading the view.
    }
    
    func onCancelButton(){
        dismissViewControllerAnimated(true, completion: nil);
    }


    func downloadBusinessDetails(){
        client.getBusinessById(business.Id, success: {(operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
               var obj = response as NSDictionary!
            self.backImage.setImageWithURL(NSURL(string: obj["image_url"] as NSString))
            self.businessName.text = self.business.name
            self.ratingUrl.setImageWithURL(NSURL(string: obj["rating_img_url_large"] as NSString))
            self.moreLabel.text = obj["snippet_text"] as NSString
            }, faliure: {(operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        })
    }
    
    override func didReceiveMemoryWarning() {
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
