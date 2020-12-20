//
//  FirebaseDatamethod.swift
//  Face8uy
//
//  Created by 國維黃 on 2020/8/19.
//  Copyright © 2020 國維黃. All rights reserved.
//

import Foundation
import Firebase
class FirebaseDatamethod
{
    static func readMerchandiseName(_ inputID: String)->String
    {
        let db = Firestore.firestore()
        
        var nameOFitem :String?
        
        db.collection("merchandise").document(inputID).getDocument() { (document, error) in
            if error == nil
            {
                if document != nil && document!.exists
                {
                    let documentData = document!.get("Name")
                    print(documentData!)
                    
                    print(type(of: documentData))
                    nameOFitem = documentData as! String?
                    print(type(of: nameOFitem))
                    print(type(of: nameOFitem))
                    print("A")
                }
            }
        }
        
       
        
            
        
        
        
        print("B")
        let finlResult = nameOFitem!
        print("C")
        return finlResult
    }
    
    
    static func addMerchandise()
    {
        //print("A")
        let db = Firestore.firestore()
        
        db.collection("merchandise").addDocument(data: ["ID" : 12345])
        //print("B")
    }
    
    
}



