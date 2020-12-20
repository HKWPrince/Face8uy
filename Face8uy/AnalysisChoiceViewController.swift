//
//  AnalysisChoiceViewController.swift
//  Face8uy
//
//  Created by 國維黃 on 2020/9/8.
//  Copyright © 2020 國維黃. All rights reserved.
//

import UIKit

class AnalysisChoiceViewController: UIViewController {
    
    
    
    @IBOutlet var ageONE: UIButton!
    @IBOutlet var genderONE: UIButton!
    @IBOutlet var timeONE: UIButton!
    @IBOutlet var preferONE: UIButton!
    @IBOutlet var maskONE: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ageONE.layer.cornerRadius = 8
        ageONE.layer.shadowColor = UIColor.darkGray.cgColor
        ageONE.layer.shadowRadius = 2
        ageONE.layer.shadowOpacity = 0.5
        ageONE.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)
        
        genderONE.layer.cornerRadius = 8
        genderONE.layer.shadowColor = UIColor.darkGray.cgColor
        genderONE.layer.shadowRadius = 2
        genderONE.layer.shadowOpacity = 0.5
        genderONE.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)
        
        preferONE.layer.cornerRadius = 8
        preferONE.layer.shadowColor = UIColor.darkGray.cgColor
        preferONE.layer.shadowRadius = 2
        preferONE.layer.shadowOpacity = 0.5
        preferONE.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)
        
        timeONE.layer.cornerRadius = 8
        timeONE.layer.shadowColor = UIColor.darkGray.cgColor
        timeONE.layer.shadowRadius = 2
        timeONE.layer.shadowOpacity = 0.5
        timeONE.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)
        
        maskONE.layer.cornerRadius = 8
        maskONE.layer.shadowColor = UIColor.darkGray.cgColor
        maskONE.layer.shadowRadius = 2
        maskONE.layer.shadowOpacity = 0.5
        maskONE.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)
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
