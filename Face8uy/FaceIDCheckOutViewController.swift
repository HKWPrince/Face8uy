//
//  FaceIDCheckOutViewController.swift
//  Face8uy
//
//  Created by 國維黃 on 2020/9/5.
//  Copyright © 2020 國維黃. All rights reserved.
//

import UIKit
import Firebase

class FaceIDCheckOutViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var customerID: UILabel!
    @IBOutlet weak var faceID: UIButton!
    @IBOutlet weak var checkOUT: UIButton!
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var checkOUTTable: UITableView!
    @IBOutlet weak var totalAmount: UILabel!
    
   
    static var userID: String = ""
    static var faceToken: String = ""
    static var merchandise: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        faceID.layer.cornerRadius = 8
        faceID.layer.shadowColor = UIColor.darkGray.cgColor
        faceID.layer.shadowRadius = 2
        faceID.layer.shadowOpacity = 0.5
        faceID.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)
        
        checkOUT.layer.cornerRadius = 8
        checkOUT.layer.shadowColor = UIColor.darkGray.cgColor
        checkOUT.layer.shadowRadius = 2
        checkOUT.layer.shadowOpacity = 0.5
        checkOUT.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkOUTTable.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FaceIDCheckOutViewController.merchandise.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckOUTCell", for :indexPath) as! CheckOutTableViewCell
        
        //cell.itemImage.image = UIImage(named: "")
        //cell.name?.text = ShoppingListControl.shoppingList[indexPath.row]
        getMerchandiseName("\(FaceIDCheckOutViewController.merchandise[indexPath.row])") { (a) in
            cell.checkOutName.text =  a
        }
        getMerchandisePrice("\(FaceIDCheckOutViewController.merchandise[indexPath.row])") { (b) in
            let x = "$: "
            cell.checkOutPrice.text = x + b!
            
        }
        
        getpic("\(FaceIDCheckOutViewController.merchandise[indexPath.row])") { (p) in
            cell.checkOutImage.image = p!
        }
        
                
        return cell
    }
    

    
    @IBAction func identify(_ sender: Any)
    {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            
            photo.image = image
            //let pic = UIImage(named: "D2")!
            //photo.image = pic
            //let uploadData = pic.jpegData(compressionQuality: 1.0)
            let uploadData = image.jpegData(compressionQuality: 1.0)
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            let dataPath = ["image_file":uploadData!]
            requestWithFormData(urlString: "https://api.face8.ai/api/faceset/search", parameters: ["api_key": "23f13a516fba443796cc89daecd81509","api_secret": "f80e44bca218478ea17e5db6ff42fbad","faceset_token": "7c33af4267574e9c9e9337190fdfcc3d","face_tokens":"test","face_detect": "0"], dataPath: dataPath) { (data) in
                DispatchQueue.main.async {
                    print(data)
                }
            }
            
        }
        
        dismiss(animated: true, completion:nil)
    }
    
    
    func requestWithFormData(urlString: String, parameters: [String: Any], dataPath: [String: Data], completion: @escaping (Data) -> Void){
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary+\(arc4random())\(arc4random())"
        var body = Data()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        for (key, value) in parameters {
            body.appendString(string: "--\(boundary)\r\n")
            body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString(string: "\(value)\r\n")
        }
        
        for (key, value) in dataPath {
            body.appendString(string: "--\(boundary)\r\n")
            body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(arc4random())\"\r\n") //此處放入file name，以隨機數代替，可自行放入
            body.appendString(string: "Content-Type: image/jpeg\r\n\r\n") //image/png 可改為其他檔案類型 ex:jpeg
            body.append(value)
            body.appendString(string: "\r\n")
        }
        
        body.appendString(string: "--\(boundary)--\r\n")
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "accept")
        fetchedDataByDataTask(from: request, completion: completion)
        
    }
    
    
    @IBAction func refresh(_ sender: Any) {
        viewDidAppear(false)
    }
    
    
    
    
    func fetchedDataByDataTask(from request: URLRequest, completion: @escaping (Data) -> Void){
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil{
                print(error as Any)
            }
            else
            {
                guard let data = data else{return}
                do{
                    let decoder = JSONDecoder()
                    let temp = try decoder.decode(Faceset_search.self, from: data)
                    print(temp)
                    
                    let facesetsearch = temp.faces
                    let theDetail = facesetsearch![0]
                    let result = theDetail.results
                    let dicResult = result![0]
                    let facetoken = dicResult.face_token!
                    let userid = dicResult.user_id!
                    FaceIDCheckOutViewController.faceToken = facetoken
                    FaceIDCheckOutViewController.userID = userid
                    print(facetoken)
                    print(userid)
                    DispatchQueue.main.async {
                        self.Name("") { (a) in
                            self.customerName.text =  a
                        }
                        
                        self.customerID.text = FaceIDCheckOutViewController.faceToken
                        let db = Firestore.firestore()
                        db.collection("users").whereField("face_token", isEqualTo: "\(FaceIDCheckOutViewController.faceToken)").getDocuments { (snapshot, error) in
                            if error == nil && snapshot != nil
                            {
                                for document in snapshot!.documents
                                {
                                    let documentData = document.data()
                                    
                                    FaceIDCheckOutViewController.merchandise =  (documentData["shopping_cart"] as? Array<String>)!

                                    
                                }
                            }
                            
                        }
                        
                        self.Amount("") { (a) in
                            self.totalAmount.text = "總金額：" + (String(a!))
                        }
                        
                        self.viewDidAppear(false)
                        
                        
                    }

                }
                catch
                {
                    print(error)
                    
                }
                print(data)
                
                completion(data)
                
            }
            
            
            /*
            if error == nil && data != nil
            {
                let getData: Data?
                
                    let decoder = JSONDecoder()
                    let temp = try decoder.decode(Faceset_search.self, from: data!)
                    print(temp)
                    //getData = (temp as! Data)
                
                
                
                    print("Error in JSON Parsing")
                
                
                completion(temp)
            }
            else
            {
                print(error as Any)
            }
        */
        }
        task.resume()
    }
    func getMerchandiseArray(_ ID: String,completion: @escaping ((Array<String>) -> ()))
    {
        var a_name :Array<String> = []
        
        let db = Firestore.firestore()
        db.collection("users").document("\(LoginWithMail.usersID_ONLY)").getDocument() { (document, error) in
        if error == nil
        {
            if document != nil && document!.exists
            {
                let name = document!.get("shopping_cart")
                a_name = name as! Array<String>
            }
        }
        completion(a_name)
        
        }
    }
    func Name(_ ID: String,completion: @escaping ((String?) -> ()))
    {
        var a_name :String?
        let db = Firestore.firestore()
        db.collection("users").whereField("face_token", isEqualTo: "\(FaceIDCheckOutViewController.faceToken)").getDocuments { (snapshot, error) in
                if error == nil && snapshot != nil
               {
                   for document in snapshot!.documents
                   {
                       let documentData = document.data()
                       a_name =  documentData["name"] as? String
                              
                   }
               }
        completion(a_name!)
        
        }
    }
    func Amount(_ ID: String,completion: @escaping ((Int?) -> ()))
    {
        var a_name :Int?
        let db = Firestore.firestore()
        db.collection("users").whereField("face_token", isEqualTo: "\(FaceIDCheckOutViewController.faceToken)").getDocuments { (snapshot, error) in
                if error == nil && snapshot != nil
               {
                   for document in snapshot!.documents
                   {
                       let documentData = document.data()
                       a_name =  documentData["toatal_amount"] as? Int
                              
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
