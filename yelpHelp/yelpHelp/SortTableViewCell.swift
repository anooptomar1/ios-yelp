//
//  SortTableViewCell.swift
//  yelpHelp
//
//  Created by Anoop tomar on 2/13/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

protocol SortTableViewCellDelegate : class{
    func didSortingChanged(sortTableViewCell:SortTableViewCell, value: Bool);
}

class SortTableViewCell: UITableViewCell {

    weak var delegate: SortTableViewCellDelegate?;
    
    var on: Bool!;
    
    @IBOutlet weak var sortSwitch: UISwitch!
    @IBOutlet weak var sortLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None;
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setOn(on: Bool, animated: Bool){
        self.on  = on;
        sortSwitch.setOn(on, animated: animated);
    }

    @IBAction func sortAction(sender: AnyObject) {
        self.delegate?.didSortingChanged(self, value: sortSwitch.on);
    }
}
