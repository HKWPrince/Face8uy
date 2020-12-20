//
//  BusTimeTableViewCell.swift
//  Face8uy
//
//  Created by 國維黃 on 2020/10/12.
//  Copyright © 2020 國維黃. All rights reserved.
//

import UIKit

class BusTimeTableViewCell: UITableViewCell {

    @IBOutlet var busNumber: UILabel!
    @IBOutlet var goNback: UILabel!
    @IBOutlet var time: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        busNumber.layer.cornerRadius = 8
        busNumber.layer.shadowColor = UIColor.darkGray.cgColor
        busNumber.layer.shadowRadius = 2
        busNumber.layer.shadowOpacity = 0.5
        busNumber.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        
    }

}
