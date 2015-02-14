//
//  BusinessCellTableViewCell.swift
//  yelpHelp
//
//  Created by Anoop tomar on 2/11/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class BusinessCellTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var business: Business!;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.nameLabel.preferredMaxLayoutWidth = self.nameLabel.frame.size.width;
        
        self.thumbImageView.layer.cornerRadius = 3;
        self.thumbImageView.clipsToBounds = true;
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setBusiness(_business: Business) -> Void{
        self.business = _business;
        
        self.thumbImageView.setImageWithURL(NSURL(string: self.business.imageUrl));
        self.nameLabel.text = self.business.name;
        self.distanceLabel.text = NSString(format: "%.2f mi", self.business.distance);
        self.ratingImageView.setImageWithURL(NSURL(string: self.business.ratingImageUrl));
        self.ratingLabel.text = NSString(format: "%ld Reviews", self.business.numReviews);
        self.addressLabel.text = self.business.address;
        self.categoryLabel.text = self.business.categories;
    }

    override func layoutSubviews() {
        super.layoutSubviews();
        self.nameLabel.preferredMaxLayoutWidth = self.nameLabel.frame.size.width;
    }
    
}
