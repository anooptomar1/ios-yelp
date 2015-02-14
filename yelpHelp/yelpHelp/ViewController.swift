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
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.navigationItem.titleView = searchBar;
        
        searchBar.sizeToFit();
        searchBar.delegate = self;
        
        searchBar.setShowsCancelButton(true, animated: true);
        
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
        self.tableView.rowHeight = 89;
        //self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.title = "Yelp";
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: UIBarButtonItemStyle.Bordered, target: self, action: "onFilterButton");
        self.navigationController?.navigationBar.backgroundColor = UIColor.orangeColor();
        
        tableView.addInfiniteScrollingWithActionHandler(insertMoreBusinesses);
        
    }
    
    func didChangeFilter(filtersViewController: FiltersViewController, filters: NSDictionary) {
        clearTableView();
        paramDictionary = filters;
        searchYelpContent(businessText, param: filters);
        //println("\(filters)");
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
        self.tableView.rowHeight = 89;
        //self.tableView.rowHeight = UITableViewAutomaticDimension;
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

