//
//  CheckOutTableViewCell.swift
//  Face8uy
//
//  Created by 國維黃 on 2020/9/9.
//  Copyright © 2020 國維黃. All rights reserved.
//

import UIKit

class CheckOutTableViewCell: UITableViewCell {
    
    @IBOutlet var checkOutImage: UIImageView!
    @IBOutlet var checkOutName: UILabel!
    @IBOutlet var checkOutPrice: UILabel!
    @IBOutlet var checkOutNum: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
