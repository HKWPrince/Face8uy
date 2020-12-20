//
//  DetailOfMerchandiseViewController.swift
//  Face8uy
//
//  Created by 國維黃 on 2020/8/31.
//  Copyright © 2020 國維黃. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage


class DetailOfMerchandiseViewController: UIViewController {
    
    @IBOutlet weak var merchandiseName: UILabel!
    @IBOutlet weak var merchandisePrice: UILabel!
    @IBOutlet weak var merchandiseCategory: UILabel!
    @IBOutlet weak var merchandiseInventory: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var addToCart: UIButton!
    
    var merchandiseID: String = ""

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addToCart.layer.cornerRadius = 8
        addToCart.layer.shadowColor = UIColor.darkGray.cgColor
        addToCart.layer.shadowRadius = 2
        addToCart.layer.shadowOpacity = 0.5
        addToCart.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)
        
        photo.layer.cornerRadius = 8
        photo.layer.shadowColor = UIColor.darkGray.cgColor
        photo.layer.shadowRadius = 2
        photo.layer.shadowOpacity = 0.5
        photo.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)
        
        
        
        
        
        getpic(merchandiseID) { (p) in
        }
        
        getMerchandiseName(merchandiseID) { (a) in
            self.merchandiseName.text = a
        }
        
        getMerchandisePrice(merchandiseID) { (b) in
            self.merchandisePrice.text = b
        }
        
        getMerchandiseType(merchandiseID) { (c) in
            self.merchandiseCategory.text = c
        }
        getMerchandiseInventory(merchandiseID) { (d) in
            self.merchandiseInventory.text = d
        }
        getpic(merchandiseID) { (p) in
            self.photo.image = p
        }
        
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
    
    @IBAction func addToShoppingList(_ sender: Any)
    {
        ShoppingListControl.addItemToShoppingList(newItem: QRCodeViewController.additemtolist )
        ShoppingListControl.addItemToShoppingList(newItem: QRCodeViewController.additemtolist )
        getMerchandiseP(QRCodeViewController.additemtolist) { (a) in
            ShoppingListControl.addItemPriceToList(newPrice: a!)}
        
        let controller = UIAlertController(title: "成功加入購物車", message: "請再接再厲塞滿購物車", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true)
        
        
        
        
    }
    
}
