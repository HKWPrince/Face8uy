//
//  SeachTableViewCell.swift
//  Face8uy
//
//  Created by 國維黃 on 2020/9/7.
//  Copyright © 2020 國維黃. All rights reserved.
//

import UIKit

class SeachTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        detailButton.layer.cornerRadius = 8
        detailButton.layer.shadowColor = UIColor.darkGray.cgColor
        detailButton.layer.shadowRadius = 2
        detailButton.layer.shadowOpacity = 0.5
        detailButton.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
