//
//  GoingEventsTableViewCell.swift
//  YOUC_Event_Page
//
//  Created by Hermain Hanif on 3/5/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit

class GoingEventsTableViewCell: UITableViewCell {
    @IBOutlet weak var eventImageView: UIView!
    @IBOutlet weak var eventAuthorLabel: UILabel!
    @IBOutlet weak var eventSummaryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
