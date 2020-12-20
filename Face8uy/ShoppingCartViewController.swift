//
//  ShoppingCartViewController.swift
//  Face8uy
//
//  Created by 國維黃 on 2020/8/27.
//  Copyright © 2020 國維黃. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class ShoppingCartViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    
    @IBOutlet weak var totalPrice: UILabel!
    
    @IBOutlet weak var shoppingCartTable: UITableView!
    
    static var totalMoney: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fortotalPrice()
        self.totalPrice.text = String(ShoppingCartViewController.totalMoney)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        shoppingCartTable.reloadData()
        
        
    }
    
    
    func fortotalPrice()
    {
        var money: Int = 0
        ShoppingCartViewController.totalMoney = 0
        if (ShoppingListControl.shoppingList.count>0)
        {
            
            for i in (0...(ShoppingListControl.shoppingList.count-1))
            {
                let tempnumber: Int = ShoppingListControl.itemNumber[i]
                let tempprice: Int = Int(ShoppingListControl.itemPrice[i])!
                
                money = tempprice * tempnumber
                ShoppingCartViewController.totalMoney = ShoppingCartViewController.totalMoney + money
                
            }
            let db = Firestore.firestore()
            db.collection("users").document("\(LoginWithMail.usersID_ONLY)").setData(["shopping_cart" : ShoppingListControl.shoppingList,"shopping_cartNum":ShoppingListControl.itemNumber], merge: true)
            db.collection("users").document("\(LoginWithMail.usersID_ONLY)").setData(["toatal_amount" : ShoppingCartViewController.totalMoney], merge: true)

                //.addDocument(data: ["toatal_amount" : ShoppingCartViewController.totalMoney])
        }

        self.totalPrice.text = String(ShoppingCartViewController.totalMoney)
        viewDidAppear(false)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShoppingListControl.shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for :indexPath) as! CustomTableViewCell
        
        //cell.itemImage.image = UIImage(named: "")
        //cell.name?.text = ShoppingListControl.shoppingList[indexPath.row]
        getMerchandiseName(ShoppingListControl.shoppingList[indexPath.row]) { (a) in
            cell.itemName?.text =  a
        }
        getMerchandisePrice(ShoppingListControl.shoppingList[indexPath.row]) { (b) in
            let x = "$: "
            cell.itemPrice?.text = x + b!
            
        }
        
        getpic(ShoppingListControl.shoppingList[indexPath.row]) { (p) in
            cell.itemImage?.image = p!
        }
        

        //cell.itemPrice.text = "商品價格"
        cell.itemNumber?.text = String(ShoppingListControl.itemNumber[indexPath.row])
        
        
        
        cell.buttonAdd.tag = indexPath.row
        cell.buttonAdd.addTarget(self, action: #selector(rowAddButtonTapped(sender:)), for: .touchUpInside)
        
        cell.buttonMinus.tag = indexPath.row
        cell.buttonMinus.addTarget(self, action: #selector(rowMinusButtonTapped(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCell.EditingStyle.delete
        {
            ShoppingListControl.deletItemFromShoppingList(atIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            fortotalPrice()
            viewDidAppear(false)
        }
    }
    
    
    
    
    
    @objc
    func rowAddButtonTapped(sender:UIButton)
    {
        let rowIndex: Int = sender.tag
        ShoppingListControl.itemNumber[rowIndex] = ShoppingListControl.itemNumber[rowIndex] + 1
        print(ShoppingListControl.itemNumber[rowIndex])
        fortotalPrice()
        viewDidAppear(false)
        
    }
    @objc
    func rowMinusButtonTapped(sender:UIButton)
    {
        let rowIndex: Int = sender.tag
        
        if (ShoppingListControl.itemNumber[rowIndex] > 0)
        {
            ShoppingListControl.itemNumber[rowIndex] = ShoppingListControl.itemNumber[rowIndex] - 1
            
        }
        else
        {
            ShoppingListControl.deletItemFromShoppingList(atIndex: rowIndex)
        }
        fortotalPrice()
        viewDidAppear(false)
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
