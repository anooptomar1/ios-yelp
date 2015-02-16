//
//  MapViewController.swift
//  yelpHelp
//
//  Created by Anoop tomar on 2/15/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit
import MapKit;

class MapViewController: UIViewController {

    var businesses = [Business]();
    
    @IBOutlet weak var mp: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var i = 0;
        for business in self.businesses{
            let location = CLLocationCoordinate2D(
                latitude: business.latitude,
                longitude: business.longitude
            )
            
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location, span: span)
            mp.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.setCoordinate(location)
            annotation.title = business.name
            annotation.subtitle = business.categories
            mp.addAnnotation(annotation)
            if(i == 0){
                mp.selectAnnotation(annotation, animated: true)
                i++
            }
        }
        
        // map view settings
        mp.pitchEnabled = true
        
        // add navivation title
        self.navigationController?.navigationBar.barTintColor = UIColor.redColor();
        var titleLabel = UILabel();
        titleLabel.text = "Map View";
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

    }
    
    func onCancelButton(){
        dismissViewControllerAnimated(true, completion: nil);
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
