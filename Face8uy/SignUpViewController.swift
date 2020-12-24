//
//  SignUpViewController.swift
//  Face8uy
//
//  Created by 國維黃 on 2020/9/2.
//  Copyright © 2020 國維黃. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
   
    static var user_id: String = ""
    static var faceToken: String = ""
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var upLoadPhoto: UIButton!
    
    @IBOutlet weak var signUP: UIButton!
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var birthday: UITextField!
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var address: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.delegate = self
        phoneNumber.delegate = self
        birthday.delegate = self
        mail.delegate = self
        passWord.delegate = self
        address.delegate = self
        
        upLoadPhoto.layer.shadowColor = UIColor.darkGray.cgColor
        upLoadPhoto.layer.shadowRadius = 4
        upLoadPhoto.layer.shadowOpacity = 0.5
        upLoadPhoto.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)
        
        signUP.layer.cornerRadius = 8
        signUP.layer.shadowColor = UIColor.darkGray.cgColor
        signUP.layer.shadowRadius = 2
        signUP.layer.shadowOpacity = 0.5
        signUP.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)

        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == name
        {
           phoneNumber.becomeFirstResponder()
        }
        else if textField == phoneNumber
        {
            birthday.becomeFirstResponder()
        }
        else {
          textField.endEditing(true)
        }
        return true
    }
    
    
    
    @IBAction func takePhoto(_ sender: Any)
    {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            //let pic = UIImage(named: "IU")!
            //photo.image = pic
            //let uploadData = pic.jpegData(compressionQuality: 1.0)
            //UIImageWriteToSavedPhotosAlbum(pic, nil, nil, nil)
            
            photo.image = image
            let uploadData = image.jpegData(compressionQuality: 1.0)
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            let dataPath = ["image_file":uploadData!]
            requestWithFormData(urlString: "https://api.face8.ai/api/detect", parameters: ["api_key": "\(Secret.api_key)","api_secret": "\(Secret.api_secret)","face_detect": "0"], dataPath: dataPath) { (data) in
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
        fetchedDataByDataTaskFor_Token(from: request, completion: completion)
        
    }
    func requestWithFormDataONLY(urlString: String, parameters: [String: Any], completion: @escaping (Data) -> Void){
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
        
        body.appendString(string: "--\(boundary)--\r\n")
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "accept")
       APIManager().fetchedDataByDataTask(from: request, completion: completion)
        
    }
    func fetchedDataByDataTaskFor_Token(from request: URLRequest, completion: @escaping (Data) -> Void){
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil{
                print(error as Any)
            }
            else
            {
                guard let data = data else{return}
                do{
                    let decoder = JSONDecoder()
                    let temp = try decoder.decode(Face_Detect.self, from: data)
                    print(temp)
                    
                    let faceDetect = temp.faces
                    let detectDetail = faceDetect![0]
                    SignUpViewController.faceToken = detectDetail.face_token!
                    
                    print(SignUpViewController.faceToken)
                }
                catch
                {
                    print(error)
                }
                print(data)
                completion(data)
            }
        }
        task.resume()
    }
    func fetchedDataByDataTaskFor_SignUP(from request: URLRequest, completion: @escaping (Data) -> Void){
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil{
                print(error as Any)
            }
            else
            {
                guard let data = data else{return}
                do{
                    let decoder = JSONDecoder()
                    let temp = try decoder.decode(SignUP.self, from: data)
                    print(temp)
                    
                    let signup = temp.data
                    let a = signup.id!
                    
                    SignUpViewController.user_id = a
                    
                    print(SignUpViewController.user_id)
                }
                catch
                {
                    print(error)
                }
                print(data)
                completion(data)
            }
        }
        task.resume()
    }
    
    func requestWithJSONBody(urlString: String, parameters: [String: Any], completion: @escaping (Data) -> Void){
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions())
        }catch let error{
            print(error)
        }
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        fetchedDataByDataTaskFor_SignUP(from: request, completion: completion)
    }
    
    @IBAction func submit(_ sender: Any)
    {
        requestWithJSONBody(urlString: "http://206.189.154.239:5000/users/", parameters: ["password":"\(passWord.text!)","face_token":"\(SignUpViewController.faceToken)","name":"\(name.text!)","gender":"\(birthday.text!)","email":"\(mail.text!)"]) { (data) in
            print(data)
            let controller = UIAlertController(title: "註冊成功", message: "關閉視窗即可登入！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            controller.addAction(okAction)
            self.present(controller, animated: true)
            
        }

       
        
        
       
  
        
    }

}

