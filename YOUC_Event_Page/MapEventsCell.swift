//
//  MapEventsCell.swift
//  YOUC_Event_Page
//
//  Created by Derek Chang on 3/10/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit

class MapEventsCell: UITableViewCell {

    
    @IBOutlet weak var EventName: UILabel!
    
    @IBOutlet weak var EventImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //makes the image rounded
        EventImage.setRounded()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension UIImageView {
    

    func setRounded() {
        let radius = self.frame.height/2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
