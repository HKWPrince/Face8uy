//
//  TimeAnalysisViewController.swift
//  Face8uy
//
//  Created by 國維黃 on 2020/9/8.
//  Copyright © 2020 國維黃. All rights reserved.
//

import UIKit

class TimeAnalysisViewController: UIViewController {
    
    
    @IBOutlet var sun: UIButton!
    @IBOutlet var mon: UIButton!
    @IBOutlet var tue: UIButton!
    @IBOutlet var wed: UIButton!
    @IBOutlet var thu: UIButton!
    @IBOutlet var fri: UIButton!
    @IBOutlet var sat: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sun.layer.cornerRadius = 8
        sun.layer.shadowColor = UIColor.darkGray.cgColor
        sun.layer.shadowRadius = 2
        sun.layer.shadowOpacity = 0.5
        sun.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)
        
        mon.layer.cornerRadius = 8
        mon.layer.shadowColor = UIColor.darkGray.cgColor
        mon.layer.shadowRadius = 2
        mon.layer.shadowOpacity = 0.5
        mon.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)
        
        tue.layer.cornerRadius = 8
        tue.layer.shadowColor = UIColor.darkGray.cgColor
        tue.layer.shadowRadius = 2
        tue.layer.shadowOpacity = 0.5
        tue.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)
        
        thu.layer.cornerRadius = 8
        thu.layer.shadowColor = UIColor.darkGray.cgColor
        thu.layer.shadowRadius = 2
        thu.layer.shadowOpacity = 0.5
        thu.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)
        
        fri.layer.cornerRadius = 8
        fri.layer.shadowColor = UIColor.darkGray.cgColor
        fri.layer.shadowRadius = 2
        fri.layer.shadowOpacity = 0.5
        fri.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)
        sat.layer.cornerRadius = 8
        sat.layer.shadowColor = UIColor.darkGray.cgColor
        sat.layer.shadowRadius = 2
        sat.layer.shadowOpacity = 0.5
        sat.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
