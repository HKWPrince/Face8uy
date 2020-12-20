//
//  MeberShipViewController.swift
//  Face8uy
//
//  Created by 國維黃 on 2020/8/23.
//  Copyright © 2020 國維黃. All rights reserved.
//

import UIKit
import Foundation
class MeberShipViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    
    @IBOutlet weak var meberTableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        meberTableView.dataSource = self
        meberTableView.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellone", for: indexPath)
         if indexPath.section == 0
         {
            
            if indexPath.row == 0
            {
                cell.textLabel?.text = "個人資料"
                cell.imageView?.image = UIImage(systemName: "person.circle.fill")
            }
            else if indexPath.row == 1
            {
                cell.textLabel?.text = "訂單記錄"
                cell.imageView?.image = UIImage(systemName: "doc.text.fill")
                cell.imageView?.tintColor = UIColor.systemBlue
            }
            else if indexPath.row == 2
            {
                cell.textLabel?.text = "回饋"
                cell.imageView?.image = UIImage(systemName: "envelope.fill")
                cell.imageView?.tintColor = UIColor.systemGreen
            }
            else if indexPath.row == 3
            {
                cell.textLabel?.text = "我的錢包"
                cell.imageView?.image = UIImage(systemName: "creditcard.fill")
                cell.imageView?.tintColor = UIColor.systemRed
            }
            else if indexPath.row == 4
            {
                cell.textLabel?.text = "帳號登出"
                cell.imageView?.image = UIImage(systemName: "eject.fill")
                cell.imageView?.tintColor = UIColor.systemGray5
            }
        }
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if indexPath.row == 0
        {
            let personalProfileViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PersonalProfileViewController")
                if let navigator = self.navigationController
                {
                     navigator.pushViewController(personalProfileViewController, animated: true)
                }
            
        }
        else if indexPath.row == 1
        {
            
            
        }
        else if indexPath.row == 2
        {
            
        }
        else if indexPath.row == 3
        {
            
        }
        else if indexPath.row == 4
        {
            
        }
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
