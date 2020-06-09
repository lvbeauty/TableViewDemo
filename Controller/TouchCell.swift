//
//  TouchCell.swift
//  Touch
//
//  Created by Tong Yi on 5/4/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import UIKit

class TouchCell: UITableViewCell {

    @IBOutlet var makeupImage: UIImageView!
    @IBOutlet var titleLable: UILabel!
    @IBOutlet var subtitleLable: UILabel!
    @IBOutlet var rateImage: UIImageView!
    @IBOutlet var rateLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
