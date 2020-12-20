//
//  TestViewController.swift
//  Face8uy
//
//  Created by 國維黃 on 2020/9/4.
//  Copyright © 2020 國維黃. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class TestViewController: UIViewController {
    
    

    
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var delet: UIButton!
    @IBOutlet weak var update: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    @IBAction func addData(_ sender: Any)
    {
        let db = Firestore.firestore()
        /*新增文件內容by dictionary _會生產文件名
        let db = Firestore.firestore()
        db.collection("testbyHKQ").addDocument(data: ["textbox1":"sdfghjkl", "textbox2":"sdfghjkl", "textbox3":"sdfghjkl"])
        */
        
        /*新增文件內容by dictionary _會生產文件名參照id
        let newdata = db.collection("testbyHKQ").document()
        newdata.setData(["textbox1":"123", "textbox2":"123", "textbox3":"123","id" : newdata.documentID ])
        */
        
        /*新增文件內容by dictionary _會生產文件名參照id，merger為複寫
        db.collection("testbyHKW").document("test").collection("test").document("test").setData(["1": 123, "2":123],merge: true)
        */
        
    }
    
    
    
    
    @IBAction func deletData(_ sender: Any)
    {
        let db = Firestore.firestore()
        /*刪除document
        db.collection("testbyHKW").document("test").delete()
        */
        /*刪除field
        db.collection("testbyHKW").document("test2").collection("test2").document("4Tec7M9QPIpD4fEyEAS3").updateData(["test2" : FieldValue.delete()])
        */
    }
    
    
    
    

    @IBAction func updateData(_ sender: Any)
    {
        let db = Firestore.firestore()
        db.collection("merchandise").whereField("ID", isEqualTo: 10008).getDocuments { (snapshot, error) in
            if error == nil && snapshot != nil
            {
                for document in snapshot!.documents
                {
                    let documentData = document.data()
                    
                    let name =  documentData["ID"]

                    print(name!)
                }
            }
            
        }
    }
    
}
