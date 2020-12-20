//
//  ViewController.swift
//  Face8uy
//
//  Created by 國維黃 on 2020/8/16.
//  Copyright © 2020 國維黃. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController
{
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var login: UIButton!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        
        signUp.layer.cornerRadius = 8
        signUp.layer.shadowColor = UIColor.darkGray.cgColor
        signUp.layer.shadowRadius = 2
        signUp.layer.shadowOpacity = 0.5
        signUp.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)
        login.layer.shadowColor = UIColor.darkGray.cgColor
        login.layer.shadowRadius = 2
        login.layer.shadowOpacity = 0.5
        login.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)
        
        
        super.viewDidLoad()
    }
}


