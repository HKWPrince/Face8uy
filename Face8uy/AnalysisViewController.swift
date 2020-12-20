//
//  AnalysisViewController.swift
//  Face8uy
//
//  Created by 國維黃 on 2020/9/6.
//  Copyright © 2020 國維黃. All rights reserved.
//

import UIKit

class AnalysisViewController: UIViewController {

    @IBOutlet weak var start: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        start.layer.cornerRadius = 8
        start.layer.shadowColor = UIColor.darkGray.cgColor
        start.layer.shadowRadius = 2
        start.layer.shadowOpacity = 0.5
        start.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)

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
