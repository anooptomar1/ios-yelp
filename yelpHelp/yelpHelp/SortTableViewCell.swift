//
//  SortTableViewCell.swift
//  yelpHelp
//
//  Created by Anoop tomar on 2/13/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

protocol SortTableViewCellDelegate : class{
    func didSortingChanged(sortTableViewCell:SortTableViewCell, value: Int);
}

class SortTableViewCell: UITableViewCell {

    weak var delegate: SortTableViewCellDelegate?;
    
    var sortValue = 0;
    
    @IBOutlet weak var sortControl: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None;
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setSortValue(value: Int){
        self.sortValue = value;
        sortControl.selectedSegmentIndex = value;
    }

    @IBAction func didSortSelected(sender: AnyObject) {
        self.delegate?.didSortingChanged(self, value: sortControl.selectedSegmentIndex);
    }
}
