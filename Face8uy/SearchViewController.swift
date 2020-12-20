//
//  SearchViewController.swift
//  Face8uy
//
//  Created by 國維黃 on 2020/9/7.
//  Copyright © 2020 國維黃. All rights reserved.
//

import UIKit
import Firebase

class SearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
    @IBOutlet weak var targetImage: UIImageView!
    @IBOutlet weak var targetName: UILabel!
    @IBOutlet weak var targetPrice: UILabel!
    @IBOutlet weak var targetNumber: UILabel!
    @IBOutlet weak var targetType: UILabel!
    
    @IBOutlet var itemPic: UIImageView!
    @IBOutlet weak var searchTable: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchBar: UITextField!
    
    static  var target: String = ""
    
    
    var itemName = ["相框/白色","相框/樺木紋","拼貼相框","澆花壺/白色","澆花壺/紅色","花盆/白色","化妝台/白色","時鐘/白色","時鐘/黑色","時鐘/黑色","時鐘/溫度計/鬧鐘","遮光窗簾/灰色","吸音窗簾","空氣淨化窗簾/淺灰色","空氣淨化窗簾/粉紅色","單人床包/白色","單人加大","床包/淺綠色","雙人床被套/灰色","靠枕/白色","靠枕/淺粉","靠枕/灰色","靠枕/深藍","頸枕/米色","附蓋收納盒收納盒/灰色","衣物防塵套/半透明白色","附蓋收納盒","分隔收納/灰色","三人座沙發含躺椅/黑色","寵物專用毯/黑色、三角形"," 洗臉盆水龍頭","餐墊/淺粉","時鐘/溫度計/鬧鐘","酒架櫃/乳白色","木炭烤肉爐具/黑色"]
    var itemID = ["10001","10002","10003","10004","10005","10006","10007","10008","10009","10010","10011","10012","10013","10014","10015","10016","10017","10018","10019","10020","10021","10022","10023","10029","10030","10031","10032","10033","10040","20003","30002","50006","70001","80004","90005"]
    var suggestion: Array<String> = []
    var suggID: Array<String> = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        targetImage.layer.cornerRadius = 8
        targetImage.layer.shadowColor = UIColor.darkGray.cgColor
        targetImage.layer.shadowRadius = 2
        targetImage.layer.shadowOpacity = 0.5
        targetImage.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)
        
        searchBar.delegate = self
        
        BusTimeViewController.requestWithURL(urlString: "https://tcgbusfs.blob.core.windows.net/blobbus/GetEstiamteTime.json", parameters:["":""]) { (Data) in
        }
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchTable.reloadData()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          textField.resignFirstResponder()
          return true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestion.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 39.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for :indexPath) as! SeachTableViewCell
        
        cell.nameLabel?.text = suggestion[indexPath.row]
        cell.detailButton.tag = indexPath.row
        cell.detailButton.addTarget(self, action: #selector(detailButtonTapped(sender:)), for: .touchUpInside)

        return cell
    }
    
    @objc
    func detailButtonTapped(sender:UIButton)
    {
        let rowIndex: Int = sender.tag
        print(rowIndex)
        SearchViewController.target = suggID[rowIndex]
        
        getMerchandiseName(SearchViewController.target) { (a) in
            self.targetName.text = "商品名稱: "+"\(a!)"
        }
        
        getMerchandiseArea(SearchViewController.target) { (a) in
            
            let image = UIImage(named: "\(a!)")
            self.itemPic.image = image
        }
        
        
        getMerchandisePrice(SearchViewController.target) { (b) in
            self.targetPrice.text = "商品價格: "+"\(b!)"
        }
        
        getMerchandiseType(SearchViewController.target) { (c) in
            self.targetType.text = "商品類型: "+"\(c!)"
        }
        getMerchandiseInventory(SearchViewController.target) { (d) in
            self.targetNumber.text = "剩餘數量: "+"\(d!)"
        }
        getpic(SearchViewController.target) { (p) in
            self.targetImage.image = p
        }       
    }
    
    
   @IBAction func search(_ sender: Any)
    {
        var temp = ""
        let target = searchBar.text!
        //search
        for visit in itemName {
            if visit.hasPrefix(target)
            {
                let index = itemName.firstIndex(of: visit)
                suggestion.append(visit)
                suggID.append(itemID[index!])
                temp = temp + "\(visit)\n"
                print(visit)
                print(index!)
                print(suggestion)
                print(suggID)
            }
        }
        viewDidAppear(false)
    }
    
    func getMerchandiseArea(_ ID: String,completion: @escaping ((String?) -> ()))
    {
        var a_name :String?
        
        let db = Firestore.firestore()
        db.collection("merchandise").document(ID).getDocument() { (document, error) in
        if error == nil
        {
            if document != nil && document!.exists
            {
                let name = document!.get("Area")
                a_name = name as! String?
            }
        }
        completion(a_name!)
        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
