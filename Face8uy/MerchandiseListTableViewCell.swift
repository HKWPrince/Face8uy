//
//  MerchandiseListTableViewCell.swift
//  Face8uy
//
//  Created by 國維黃 on 2020/9/4.
//  Copyright © 2020 國維黃. All rights reserved.
//

import UIKit

class MerchandiseListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var confirm: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        confirm.layer.cornerRadius = 8
        confirm.layer.shadowColor = UIColor.darkGray.cgColor
        confirm.layer.shadowRadius = 2
        confirm.layer.shadowOpacity = 0.5
        confirm.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
