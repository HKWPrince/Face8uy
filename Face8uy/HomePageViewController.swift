//
//  HomePageViewController.swift
//  Face8uy
//
//  Created by 國維黃 on 2020/8/17.
//  Copyright © 2020 國維黃. All rights reserved.
//

import UIKit


class HomePageViewController: UIViewController
{
    @IBOutlet weak var mapLabel: UIStackView!
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        mapLabel.layer.cornerRadius = 8
        mapLabel.layer.shadowColor = UIColor.darkGray.cgColor
        mapLabel.layer.shadowRadius = 2
        mapLabel.layer.shadowOpacity = 0.5
        mapLabel.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)
        label.layer.cornerRadius = 8
        label.layer.shadowColor = UIColor.darkGray.cgColor
        label.layer.shadowRadius = 2
        label.layer.shadowOpacity = 0.5
        label.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)
        
        
        
    }
    
}

