//
//  LocationCell.swift
//  YOUC_Event_Page
//
//  Created by Beverly Abadines on 3/12/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//  Adapted from Timothy Lees' Photo Map

import UIKit
import AFNetworking
class LocationCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var categoryView: UIImageView!
    
    var location: NSDictionary! {
        didSet {
            titleLabel.text = location["name"] as? String
            locationLabel.text = location.value(forKeyPath: "location.address") as? String
            
            let categories = location["categories"] as? NSArray
            if (categories != nil && categories!.count > 0) {
                let category = categories![0] as! NSDictionary
                let urlPrefix = category.value(forKeyPath: "icon.prefix") as! String
                let urlSuffix = category.value(forKeyPath: "icon.suffix") as! String
                
                let url = "\(urlPrefix)bg_32\(urlSuffix)"
                categoryView.setImageWith(URL(string: url)!)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

