//
//  SearchDetailViewController.swift
//  Face8uy
//
//  Created by 國維黃 on 2020/9/7.
//  Copyright © 2020 國維黃. All rights reserved.
//

import UIKit
import Firebase

class SearchDetailViewController: UIViewController {

    @IBOutlet weak var Suggimage: UIImageView!
    @IBOutlet weak var suggName: UILabel!
    @IBOutlet weak var suggPrice: UILabel!
    @IBOutlet weak var suggType: UILabel!
    @IBOutlet weak var suggNumber: UILabel!
    @IBOutlet weak var suggaddToCart: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        suggaddToCart.layer.cornerRadius = 8
        suggaddToCart.layer.shadowColor = UIColor.darkGray.cgColor
        suggaddToCart.layer.shadowRadius = 2
        suggaddToCart.layer.shadowOpacity = 0.5
        suggaddToCart.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)
        
        Suggimage.layer.cornerRadius = 8
        Suggimage.layer.shadowColor = UIColor.darkGray.cgColor
        Suggimage.layer.shadowRadius = 2
        Suggimage.layer.shadowOpacity = 0.5
        Suggimage.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)
    }
/*
        
        // Do any additional setup after loading the view.
    
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
    func getMerchandiseType(_ ID: String,completion: @escaping ((String?) -> ()))
    {
        var a_type :String?
        let db = Firestore.firestore()
        db.collection("merchandise").document(ID).getDocument() { (document, error) in
        if error == nil
        {
            if document != nil && document!.exists
            {
                let type = document!.get("Type")
                a_type = type as! String?

            }
        }
        completion(a_type!)
        
    }
    }
    func getMerchandiseInventory(_ ID: String,completion: @escaping ((String?) -> ()))
        {
            var a_inventory :String?
            let db = Firestore.firestore()
            db.collection("merchandise").document(ID).getDocument() { (document, error) in
            if error == nil
            {
                if document != nil && document!.exists
                {
                    let inventory = document!.get("Inventory")
                    a_inventory = inventory as! String?

                }
            }
            completion(a_inventory!)
            
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
    func getMerchandiseP(_ ID: String,completion: @escaping ((String?) -> ()))
    {
        var nameOFitem :String?
        
        let db = Firestore.firestore()
        db.collection("merchandise").document(ID).getDocument() { (document, error) in
        if error == nil
        {
            if document != nil && document!.exists
            {
                let documentData = document!.get("Price")
                //print(documentData!)
                
                //print(type(of: documentData))
                nameOFitem = documentData as! String?
                //print(type(of: nameOFitem))
                //print(type(of: nameOFitem))
                //print("A")
            }
        }
        completion(nameOFitem!)
        //print(nameOFitem!)
        //let finlResult = nameOFitem!
        //self.codeTextLabel.text = nameOFitem as! String
                
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
*/
}
