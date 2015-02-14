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

    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: FiltersViewControllerDelegate?;
    
    var selectedCategories = NSMutableSet();
    
    var sortSelection = 0;
    var radiusSelection = 0;
    
    var dealsSelected = false;

    var categories: NSArray!;
    
    func filters() -> NSDictionary{
        var results = NSMutableDictionary();
        var codes = NSMutableArray();
        
        if(selectedCategories.count > 0){
            for cat in selectedCategories{
                codes.addObject((cat as NSArray)[1]["code"] as NSString);
            }
            
            results.setObject(codes.componentsJoinedByString(","), forKey: "category_filter")
           // results.setObject(codes.componentsJoinedByString(","), forKey: "sort")
        }
        results.setObject(sortSelection, forKey: "sort");
        results.setObject(radiusSelection, forKey: "radius_filter");
        results.setObject(dealsSelected, forKey: "deals_filter");
        return results;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Bordered, target: self, action: "onCancelButton");
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply", style: UIBarButtonItemStyle.Bordered, target: self, action: "onApplyButton");

        self.navigationController?.navigationBar.backgroundColor = UIColor.orangeColor();

        
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
        

        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        }
        return 1;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            let cell = tableView.dequeueReusableCellWithIdentifier("FilterCell") as FilterTableViewCell;
            cell.setOn(self.selectedCategories.containsObject(self.categories[indexPath.row]), animated: true);
            cell.categoryLabel.text = (self.categories[indexPath.row] as NSArray)[0]["name"] as NSString
            cell.delegate = self;
            
            return cell;
        }else if(indexPath.section == 1){
            let cell = tableView.dequeueReusableCellWithIdentifier("SortCell") as SortTableViewCell;
            cell.delegate = self;
            
            return cell;
        }else if(indexPath.section == 2){
            let cell = tableView.dequeueReusableCellWithIdentifier("RadiusCell") as RadiusTableViewCell;
            cell.delegate = self;
            
            return cell;
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("DealsCell") as DealsTableViewCell;
        cell.delegate = self;
        
        return cell;
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            return "Categories:";
        }else if(section == 1){
            return "Sort By:";
        }
        
        return "Radius:";
    }
    
    func didUpdateValue(filterTableViewCell: FilterTableViewCell, value: Bool) {
        var indexPath: NSIndexPath = self.tableView.indexPathForCell(filterTableViewCell)!;
        
        if(value){
            self.selectedCategories.addObject(self.categories[indexPath.row]);
        }else{
            self.selectedCategories.removeObject(self.categories[indexPath.row])
        }
    }
    
    func didSortingChanged(sortTableViewCell: SortTableViewCell, value: Int) {
        self.sortSelection = value;
        //println(sortSelection);
    }
    
    func didRadiusChanged(radiusTableViewCell: RadiusTableViewCell, value: Int) {
        self.radiusSelection = value;
        //println(radiusSelection);
    }
    
    func didDealsChanged(dealsTableViewCell: DealsTableViewCell, value: Bool) {
        self.dealsSelected = value;
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
