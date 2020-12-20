//
//  MerchandiseListViewController.swift
//  Face8uy
//
//  Created by 國維黃 on 2020/9/4.
//  Copyright © 2020 國維黃. All rights reserved.
//

import UIKit
import Firebase

class MerchandiseListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var managerTable: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MerchandiseListControl.merchandiseList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManagerCell", for: indexPath) as! MerchandiseListTableViewCell
        
        
        

        
        
        
        getMerchandiseName(MerchandiseListControl.merchandiseList[indexPath.row]) { (a) in
            cell.name?.text =  a
        }
        
        getMerchandisePrice((MerchandiseListControl.merchandiseList[indexPath.row])) { (b) in
            let x = "$: "
            cell.price?.text = x + b!
            
        }
        
        getMerchandiseIventory((MerchandiseListControl.merchandiseList[indexPath.row])) { (b) in
            cell.number?.text =  b
            
        }
        
        
        
        getpic(MerchandiseListControl.merchandiseList[indexPath.row]) { (p) in
            cell.picture?.image = p!
        }
        
        
        
        
        
        
        //cell.picture
        cell.confirm.tag = indexPath.row
        cell.confirm.addTarget(self, action: #selector(confirmButtonTapped(sender:)), for: .touchUpInside)
        
        
        //cell.itemImage.image = UIImage(named: "")
        
        
        
        return cell
    }
    
    @objc
    func confirmButtonTapped(sender:UIButton)
    {
        let rowIndex: Int = sender.tag
        print(rowIndex)
    }
    
    func getMerchandiseName(_ ID: String,completion: @escaping ((String?) -> ()))
    {
        var a_name :String?
        
        let db = Firestore.firestore()
        db.collection("merchandise").document(ID).getDocument() { (document, error) in
        if error == nil
        {
            if document != nil && document!.exists
            {
                let name = document!.get("Name")
                a_name = name as! String?
            }
        }
        completion(a_name!)
        
        }
    }
       
    func getMerchandisePrice(_ ID: String,completion: @escaping ((String?) -> ()))
    {
        var a_price :String?
        let db = Firestore.firestore()
        db.collection("merchandise").document(ID).getDocument() { (document, error) in
        if error == nil
        {
            if document != nil && document!.exists
            {
                let price = document!.get("Price")
                a_price = price as! String?

            }
        }
        completion(a_price!)
        
        }
    }
    func getMerchandiseIventory(_ ID: String,completion: @escaping ((String?) -> ()))
    {
        var a_price :String?
        let db = Firestore.firestore()
        db.collection("merchandise").document(ID).getDocument() { (document, error) in
        if error == nil
        {
            if document != nil && document!.exists
            {
                let price = document!.get("Inventory")
                a_price = price as! String?

            }
        }
        completion(a_price!)
        
        }
    }
    func getpic(_ ID: String,completion: @escaping ((UIImage?) -> ()))
    {
        
        var itemphoto :UIImage?
        
        let storage = Storage.storage(url:"gs://face8uy.appspot.com")
        // Create a reference to the file you want to download
        // Get a reference to the storage service using the default Firebase App

        // Create a storage reference from our storage service
        let storageRef = storage.reference()
        let islandRef = storageRef.child("merchandise").child(ID+".jpg")

        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        islandRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error == nil
            {
                let image = UIImage(data: data!)
                itemphoto = image
            // Uh-oh, an error occurred!
            }
            completion(itemphoto)
            
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
