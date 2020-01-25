//
//  MemeTableViewCell.swift
//  IOSND-MemeMe-2.0
//
//  Created by Dimopoulos Stavros tou Athanasiou on 24/1/20.
//  Copyright © 2020 Dimopoulos Stavros tou Athanasiou. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {
    @IBOutlet weak var memeImage: UIImageView!
    
    @IBOutlet weak var memeText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
