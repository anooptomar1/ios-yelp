//
//  FiltersViewController.swift
//  yelpHelp
//
//  Created by Anoop tomar on 2/12/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

protocol FiltersViewControllerDelegate : class{
    func didChangeFilter(filtersViewController: FiltersViewController,filters: NSDictionary) -> Void;
}

class FiltersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FilterTableViewCellDelegate, SortTableViewCellDelegate, RadiusTableViewCellDelegate, DealsTableViewCellDelegate {

    enum CellType{
        case sortCell, radiusCell
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: FiltersViewControllerDelegate?;
    
    // category properties
    var categories: NSArray!;
    var selectedCategories = NSMutableSet();
    
    // radius properties
    var radiusCategories: NSArray!;
    var selectedRadius = NSMutableSet();
    
    // sort properties
    var sortCategories: NSArray!;
    var selectedSort = NSMutableSet();
    
    // deals properties
    var dealsSelected = false;

    
    func filters() -> NSDictionary{
        var results = NSMutableDictionary();
        var codes = NSMutableArray();
        var sortValue = "0";
        var radiusSelection = "0";
        
        if(selectedCategories.count > 0){
            for cat in selectedCategories{
                codes.addObject((cat as NSArray)[1]["code"] as NSString);
            }
            
            results.setObject(codes.componentsJoinedByString(","), forKey: "category_filter")
        }
        if(selectedSort.count > 0){
            for cat in selectedSort{
                sortValue = (cat as NSArray)[1]["value"] as NSString;
            }
        }
        if(selectedRadius.count > 0){
            for cat in selectedRadius{
                radiusSelection = (cat as NSArray)[1]["value"] as NSString;
            }
        }
        results.setObject(sortValue, forKey: "sort");
        results.setObject(radiusSelection, forKey: "radius_filter");
        results.setObject(dealsSelected, forKey: "deals_filter");
        return results;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add buttons to navigation bar
        var cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Bordered, target: self, action: "onCancelButton");
        cancelButton.tintColor = UIColor.whiteColor();
        cancelButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Chalkduster", size: 12)!], forState: UIControlState.Normal)
        self.navigationItem.leftBarButtonItem = cancelButton;
        
        
        // apply button
        var applyButton = UIBarButtonItem(title: "Search", style: UIBarButtonItemStyle.Bordered, target: self, action: "onApplyButton");
        applyButton.tintColor = UIColor.whiteColor();
        applyButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Chalkduster", size: 12)!], forState: UIControlState.Normal)
        self.navigationItem.rightBarButtonItem = applyButton

        // set color to navigation bar
        self.navigationController?.navigationBar.barTintColor = UIColor.redColor();
        var titleLabel = UILabel();
        titleLabel.text = "Filters";
        titleLabel.textColor = UIColor.whiteColor();
        titleLabel.sizeToFit();
        titleLabel.backgroundColor = UIColor.clearColor();
        titleLabel.font = UIFont(name: "Chalkduster", size: 20);
        self.navigationItem.titleView = titleLabel;
        
        // initialize category arrays
        initializeCategories();
        
        // add tableview delegate and data source
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }

    func initializeCategories(){
        
        // type categories
        self.categories = [
            [["name": "Afghan"], ["code": "afghani"]],
            [["name": "African"], ["code": "african"]],
            [["name": "American, New"], ["code": "newamerican"]],
            [["name": "American, Traditional"],["code": "tradamerican"]],
            [["name": "Arabian"], ["code": "arabian"]],
            [["name": "Argentine"], ["code": "argentine"]],
            [["name": "Asian Fusion"], ["code": "asianfusion"]],
            [["name": "Austrian"], ["code": "austrian"]],
            [["name": "Thai"], ["code":"thai"]],
            [["name": "Indian"], ["code": "indpak"]],
            [["name": "Bars"], ["code": "bars"]],
            [["name": "Brazilian"], ["code": "brazilian"]],
            [["name": "Caribbean"], ["code": "caribbean"]]
        ];
        
        // sort categories
        self.sortCategories = [
            [["name": "Best Match"], ["value": "0"]],
            [["name": "Distance"], ["value": "1"]],
            [["name": "Highest Rated"], ["value": "2"]],
        ];
        
        // radius categories
        self.radiusCategories = [
            [["name" : "Best Match"], ["value" : "0"]],
            [["name" : "0.3 miles"], ["value" : "480"]],
            [["name" : "1 mile"], ["value" : "1600"]],
            [["name" : "5 miles"], ["value" : "8000"]],
            [["name" : "20 miles"], ["value" : "32000"]]
        ];

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4;
    }
    
    func onCancelButton(){
        dismissViewControllerAnimated(true, completion: nil);
    }
    
    func onApplyButton(){
        self.delegate?.didChangeFilter(self, filters: self.filters());
        dismissViewControllerAnimated(true, completion: nil);
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return self.categories.count;
        }else if(section == 1){
            return self.sortCategories.count;
        }else if(section == 2){
            return self.radiusCategories.count;
        }
        return 1;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            
            // load filter categories
            let cell = tableView.dequeueReusableCellWithIdentifier("FilterCell") as FilterTableViewCell;
            cell.setOn(self.selectedCategories.containsObject(self.categories[indexPath.row]), animated: true);
            cell.categoryLabel.text = (self.categories[indexPath.row] as NSArray)[0]["name"] as NSString
            cell.delegate = self;
            return cell;
            
        }else if(indexPath.section == 1){
            
            // load sort categories
            let cell = tableView.dequeueReusableCellWithIdentifier("SortCell") as SortTableViewCell;
            cell.setOn(self.selectedSort.containsObject(self.sortCategories[indexPath.row]), animated: true);
            cell.sortLabel.text = (self.sortCategories[indexPath.row] as NSArray)[0]["name"] as NSString;
            cell.delegate = self;
            return cell;
            
        }else if(indexPath.section == 2){
            
            // load radius categories
            let cell = tableView.dequeueReusableCellWithIdentifier("RadiusCell") as RadiusTableViewCell;
            cell.setOn(self.selectedRadius.containsObject(self.radiusCategories[indexPath.row]), animated: true);
            cell.radiusLabel.text = (self.radiusCategories[indexPath.row] as NSArray)[0]["name"] as NSString;
            cell.delegate = self;
            return cell;
            
        }
        
        // load deals
        let cell = tableView.dequeueReusableCellWithIdentifier("DealsCell") as DealsTableViewCell;
        cell.delegate = self;
        return cell;
        
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //println(indexPath);
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            return "Categories:";
        }else if(section == 1){
            return "Sort By:";
        }else if(section == 2){
            return "Radius:";
        }
        
        return "Deals:";
    }
    
    
    func didUpdateValue(filterTableViewCell: FilterTableViewCell, value: Bool) {
        var indexPath: NSIndexPath = self.tableView.indexPathForCell(filterTableViewCell)!;
        
        if(value){
            self.selectedCategories.addObject(self.categories[indexPath.row]);
        }else{
            self.selectedCategories.removeObject(self.categories[indexPath.row])
        }
    }
    
    func didSortingChanged(sortTableViewCell: SortTableViewCell, value: Bool) {
        var indexPath: NSIndexPath = self.tableView.indexPathForCell(sortTableViewCell)!;
        if(value){
            deselectAllOthers(indexPath, cellType:CellType.sortCell);
            self.selectedSort.removeAllObjects();
            self.selectedSort.addObject(self.sortCategories[indexPath.row]);
        }else{
            self.selectedSort.removeObject(self.sortCategories[indexPath.row]);
        }
        //println(selectedSort);
    }
    
    func didRadiusChanged(radiusTableViewCell: RadiusTableViewCell, value: Bool) {
        var indexPath: NSIndexPath = self.tableView.indexPathForCell(radiusTableViewCell)!;
        if(value){
            deselectAllOthers(indexPath, cellType: CellType.radiusCell);
            self.selectedRadius.removeAllObjects();
            self.selectedRadius.addObject(self.radiusCategories[indexPath.row]);
        }
        else{
            self.selectedRadius.removeObject(self.radiusCategories[indexPath.row]);
        }
       // println(self.selectedRadius);
    }
    
    func didDealsChanged(dealsTableViewCell: DealsTableViewCell, value: Bool) {
        self.dealsSelected = value;
    }
    
    func deselectAllOthers(indexPath: NSIndexPath, cellType: CellType){
        for i in 0..<tableView.numberOfRowsInSection(indexPath.section){
            if(i != indexPath.row){
                switch cellType{
                case CellType.sortCell:
                    var otherCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: indexPath.section)) as SortTableViewCell;
                    otherCell.setOn(false, animated: false);
                case CellType.radiusCell:
                    var otherCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: indexPath.section)) as RadiusTableViewCell;
                    otherCell.setOn(false, animated: false);
                }
            }
        }
    }
  
}
