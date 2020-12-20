//
//  CustomTableViewCell.swift
//  Face8uy
//
//  Created by 國維黃 on 2020/9/2.
//  Copyright © 2020 國維黃. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemNumber: UILabel!
    @IBOutlet weak var buttonAdd: UIButton!
    @IBOutlet weak var buttonMinus: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
