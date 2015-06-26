//
//  CategoryOrImageCellTableViewCell.swift
//  BiblioHackDay2015
//
//  Created by Silvio Messi on 25/06/15.
//  Copyright © 2015 Nerdologi. All rights reserved.
//

import UIKit

class CategoryOrImageCellTableViewCell: UITableViewCell {

    @IBOutlet weak var pictureImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
