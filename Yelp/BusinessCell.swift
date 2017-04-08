//
//  BusinessCell.swift
//  Yelp
//
//  Created by Jessica Thrasher on 4/7/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {


    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var distanceNameLabel: UILabel!
    @IBOutlet weak var expenseAmountNameLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var starsImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    
    var business: Business! {
        didSet {
            businessNameLabel.text = business.name
            distanceNameLabel.text = business.distance
            reviewCountLabel.text = "\(business.reviewCount!) Reviews"
            addressLabel.text = business.address
            
            if let ratingImageURL = business.ratingImageURL {
                starsImageView.setImageWith(ratingImageURL)
            }
            
            if let thumbnailImageURL = business.imageURL {
                thumbnailImageView.setImageWith(thumbnailImageURL)
            }
            
            categoriesLabel.text = business.categories
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        thumbnailImageView.layer.cornerRadius = 3
        thumbnailImageView.clipsToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
