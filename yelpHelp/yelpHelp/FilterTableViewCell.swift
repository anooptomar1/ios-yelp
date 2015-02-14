//
//  FilterTableViewCell.swift
//  yelpHelp
//
//  Created by Anoop tomar on 2/13/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

protocol FilterTableViewCellDelegate : class{
    func didUpdateValue(filterTableViewCell: FilterTableViewCell, value: Bool);
}

class FilterTableViewCell: UITableViewCell {

    weak var delegate: FilterTableViewCellDelegate?;
    
    var on: Bool!;
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var categorySwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None;
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setOn(on: Bool, animated: Bool){
        self.on = on;
        categorySwitch.setOn(on, animated: animated);
    }

    @IBAction func switchChanged(sender: AnyObject) {
        self.delegate?.didUpdateValue(self, value: categorySwitch.on);
    }
}
