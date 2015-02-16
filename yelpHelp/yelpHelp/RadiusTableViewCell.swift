//
//  RadiusTableViewCell.swift
//  yelpHelp
//
//  Created by Anoop tomar on 2/13/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

protocol RadiusTableViewCellDelegate : class{
    func didRadiusChanged(radiusTableViewCell: RadiusTableViewCell, value: Bool);
}

class RadiusTableViewCell: UITableViewCell {

    @IBOutlet weak var radiusLabel: UILabel!
    @IBOutlet weak var radiusSwitch: UISwitch!
    
    weak var delegate: RadiusTableViewCellDelegate?;
    
    var on: Bool!;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None;
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setOn(on: Bool, animated: Bool){
        self.on = on;
        self.radiusSwitch.setOn(on, animated: animated);
    }
    
    @IBAction func radiusChanged(sender: AnyObject) {
        self.delegate?.didRadiusChanged(self, value: self.radiusSwitch.on);
    }
}
