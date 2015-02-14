//
//  DealsTableViewCell.swift
//  yelpHelp
//
//  Created by Anoop tomar on 2/14/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

protocol DealsTableViewCellDelegate: class{
    func didDealsChanged(dealsTableViewCell: DealsTableViewCell, value: Bool);
}

class DealsTableViewCell: UITableViewCell {
    
    weak var delegate: DealsTableViewCellDelegate?;

    @IBOutlet weak var dealsControl: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func dealsAction(sender: AnyObject) {
        self.delegate?.didDealsChanged(self, value: dealsControl.on);
    }
}
