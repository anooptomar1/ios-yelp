//
//  RadiusTableViewCell.swift
//  yelpHelp
//
//  Created by Anoop tomar on 2/13/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

protocol RadiusTableViewCellDelegate : class{
    func didRadiusChanged(radiusTableViewCell: RadiusTableViewCell, value: Int);
}

class RadiusTableViewCell: UITableViewCell {

    weak var delegate: RadiusTableViewCellDelegate?;
    
    var radiusValues = [0,480,1600,8000,32000];
    var radiusValue = 0;
    
    @IBOutlet weak var radiusControl: UISegmentedControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None;
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setRadius(value: Int){
        radiusControl.selectedSegmentIndex = value;
        radiusValue = radiusValues[value];
    }
    
    @IBAction func radiusAction(sender: AnyObject) {
        self.delegate?.didRadiusChanged(self, value: radiusValues[radiusControl.selectedSegmentIndex]);
    }
}
