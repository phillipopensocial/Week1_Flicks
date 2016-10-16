//
//  MovieCell.swift
//  Week1_Flicks
//
//  Created by Phillip Pang on 10/16/16.
//  Copyright © 2016 Phillip Pang. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var theImage: UIImageView!
    @IBOutlet weak var theTitle: UILabel!
    @IBOutlet weak var theOverview: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
