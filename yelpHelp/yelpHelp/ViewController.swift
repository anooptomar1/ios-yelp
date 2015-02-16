//
//  ViewController.swift
//  yelpHelp
//
//  Created by Anoop tomar on 2/10/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FiltersViewControllerDelegate{

    var client: YelpClient!;
    var businesses = [Business]();
    var filteredBusiness = [Business]();
    var pageNumber = 0;
    var pageLimit = 10;
    var businessText = "Food";
    var paramDictionary = NSDictionary();
    
    var searchBar: UISearchBar = UISearchBar();
    
    @IBOutlet weak var tableView: UITableView!
    
    let yelpConsumerKey = "2y_snbcqpfpQB_1UXA9M4Q";
    let yelpConsumerSecret = "h6qPQh1jID4M4HMrAbZ2jOctjEY";
    let yelpToken = "qS5Q1BTAh22-ewpo1gj6WzTcoLEHhjvF";
    let yelpTokenSecret = "kKogF4lK7zoCyuXFh_eEcH6CUVE";
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret);
        searchYelpContent(businessText, param: paramDictionary);
        
    }
//    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
//        searchBar.resignFirstResponder();
//    }
    
//    @IBAction func tapAction(sender: AnyObject) {
//        searchBar.resignFirstResponder();
//    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        searchBar.resignFirstResponder();
    }
    
    func searchYelpContent(searchTerm: String, param: NSDictionary){
        client.searchWithTerm(searchTerm, limit: pageLimit, offset: pageNumber,param: param, success: {(operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            if(response["businesses"] != nil){
                var businesses: NSArray = response["businesses"] as NSArray;
                if(businesses.count > 0){
                    self.businesses.extend(Business().businessesWithDictionaries(businesses));
                    
                    self.tableView.reloadData();
                    self.tableView.infiniteScrollingView.stopAnimating();
                }else{
                    self.tableView.infiniteScrollingView.stopAnimating();
                    
                }
            }
            
            }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error);
        });
    }
    
    func filterContentForSearchText(searchText: String){
        self.filteredBusiness = self.businesses.filter({(business: Business) -> Bool in
            let categoryMatch = business.categories.rangeOfString(searchText);
            return categoryMatch != nil;
        });
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        clearTableView();
        businessText = searchBar.text;
        searchYelpContent(searchBar.text, param: paramDictionary);
        searchBar.resignFirstResponder();
    }
    
    func clearTableView(){
        pageNumber = 0;
        businesses = [Business]();
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.navigationItem.titleView = searchBar;
        
        searchBar.sizeToFit();
        searchBar.delegate = self;
        
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        //self.title = "Yelp";
        
        // filter button
        var filterButton = UIBarButtonItem(title: "Filter", style: UIBarButtonItemStyle.Plain, target: self, action: "onFilterButton");
        filterButton.tintColor = UIColor.whiteColor();
        filterButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Chalkduster", size: 12)!], forState: UIControlState.Normal)
        self.navigationItem.leftBarButtonItem = filterButton;
        
        // map view button
        var mapButton = UIBarButtonItem(title: "Map", style: UIBarButtonItemStyle.Plain, target: self, action: "onMapButton");
        mapButton.tintColor = UIColor.whiteColor();
        mapButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Chalkduster", size: 12)!], forState: UIControlState.Normal);
        self.navigationItem.rightBarButtonItem = mapButton;
        
        // navbar color
        self.navigationController?.navigationBar.barTintColor = UIColor.redColor();
        
        tableView.addInfiniteScrollingWithActionHandler(insertMoreBusinesses);
        
    }
    
    func didChangeFilter(filtersViewController: FiltersViewController, filters: NSDictionary) {
        clearTableView();
        paramDictionary = filters;
        searchYelpContent(businessText, param: filters);
    }
    
    func onMapButton(){
        var mvc = self.storyboard?.instantiateViewControllerWithIdentifier("mapVC") as MapViewController;
        mvc.businesses = self.businesses;
        var navC = UINavigationController(rootViewController: mvc);
        presentViewController(navC, animated: true, completion: nil);
    }
    
    func onFilterButton(){
        var fvc = self.storyboard?.instantiateViewControllerWithIdentifier("filterVC") as FiltersViewController;
        fvc.delegate = self;
        var nvc = UINavigationController(rootViewController: fvc);
        presentViewController(nvc, animated: true, completion: nil);
    }
    
    func insertMoreBusinesses(){
        pageNumber = businesses.count;
        searchYelpContent(businessText, param: paramDictionary);
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        self.tableView.rowHeight = UITableViewAutomaticDimension;
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var dvc = self.storyboard?.instantiateViewControllerWithIdentifier("detailsVC") as DetailsViewController;
        dvc.client = self.client;
        if(filteredBusiness.count > 0){
            dvc.business = self.filteredBusiness[indexPath.row];
        }else{
            dvc.business = self.businesses[indexPath.row];
        }
        var nvc = UINavigationController(rootViewController: dvc);
        presentViewController(nvc, animated: true, completion: nil);
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if (businesses.count>0){
                if(filteredBusiness.count > 0){
                    return filteredBusiness.count;
                }else{
                    return businesses.count;
                }
            }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell") as BusinessCellTableViewCell;
        
        if(filteredBusiness.count > 0){
            cell.setBusiness(filteredBusiness[indexPath.row] as Business);
        }
        else{
            cell.setBusiness(businesses[indexPath.row] as Business);
        }
        
        return cell;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

