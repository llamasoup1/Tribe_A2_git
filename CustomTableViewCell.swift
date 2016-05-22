//
//  CustomTableViewCell.swift
//  Tribe
//
//  Created by RMIT on 20/05/2016.
//  Copyright © 2016 Tristan Tambourine. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubtitle: UILabel!
    @IBOutlet weak var labelCategory: UILabel!
    @IBOutlet weak var imageViewCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageViewCell.layer.cornerRadius = 45;
        imageViewCell.layer.masksToBounds = true;
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
