
//
//  LoginWithMail.swift
//  Face8uy
//
//  Created by 國維黃 on 2020/8/16.
//  Copyright © 2020 國維黃. All rights reserved.
//

import UIKit
import Foundation

class LoginWithMail: UIViewController, UITextFieldDelegate
{
    
    static var usersID_ONLY = "" //firebase使用者名稱
    static var usersToken_ONLY = ""
    
    @IBOutlet weak var Loginalert: UILabel!
    @IBOutlet weak var AccountTextbox: UITextField!
    @IBOutlet weak var PasswordTextbox: UITextField!
    @IBOutlet weak var login: UIButton!
    
    
    override func viewDidLoad()
    {
        AccountTextbox.delegate = self
        PasswordTextbox.delegate = self
        
        login.layer.cornerRadius = 8
        login.layer.shadowColor = UIColor.darkGray.cgColor
        login.layer.shadowRadius = 2
        login.layer.shadowOpacity = 0.5
        login.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)
        
        super.viewDidLoad()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == AccountTextbox {
           PasswordTextbox.becomeFirstResponder()
        }else {
          textField.endEditing(true)
        }
        return true
    }
    
    @IBAction func logincheck(_ sender: Any)
    {
        if AccountTextbox.text=="test" && PasswordTextbox.text=="test"
        {
            let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarVC")
            if let navigator = self.navigationController
            {
                 navigator.pushViewController(tabBarController, animated: true)
            }
            
        }
        else if AccountTextbox.text=="manager" && PasswordTextbox.text=="manager"
        {
            let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ManagerTableViewController")
            if let navigator = self.navigationController
            {
                 navigator.pushViewController(tabBarController, animated: true)
            }
        }
        else if AccountTextbox.text==" " && PasswordTextbox.text==" "
        {
            Loginalert.text = "帳號或密碼錯誤"
            AccountTextbox.text=""
            PasswordTextbox.text=""
            
        }
        
        else if AccountTextbox.text=="0211" && PasswordTextbox.text=="0211"
        {
            requestWithJSONBody(urlString: "http://206.189.154.239:5000/sessions/", parameters: ["password":"\(PasswordTextbox.text!)","email":"\(AccountTextbox.text!)"]) { (data) in
            print(data)
            }
            let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarVC")
            if let navigator = self.navigationController
            {
                 navigator.pushViewController(tabBarController, animated: true)
            }
            
        }
        else if AccountTextbox.text=="lee0105" && PasswordTextbox.text=="0105"
        {
            requestWithJSONBody(urlString: "http://206.189.154.239:5000/sessions/", parameters: ["password":"\(PasswordTextbox.text!)","email":"\(AccountTextbox.text!)"]) { (data) in
            print(data)
            }
            let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarVC")
            if let navigator = self.navigationController
            {
                 navigator.pushViewController(tabBarController, animated: true)
            }
            
        }
        else
        {
            Loginalert.text = "帳號或密碼錯誤"
            AccountTextbox.text=""
            PasswordTextbox.text=""
            
        }
        
        /*
        else //正常登入
        {
            requestWithJSONBody(urlString: "http://206.189.154.239:5000/sessions/", parameters: ["password":"\(PasswordTextbox.text!)","email":"\(AccountTextbox.text!)"]) { (data) in
            print(data)
            }
            let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarVC")
            if let navigator = self.navigationController
            {
                 navigator.pushViewController(tabBarController, animated: true)
            }
            
        }
         */
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
        fetchedDataByDataTaskFor_Login(from: request, completion: completion)
    }
    func fetchedDataByDataTaskFor_Login(from request: URLRequest, completion: @escaping (Data) -> Void){
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil{
                print(error as Any)
            }
            else
            {
                guard let data = data else{return}
                do{
                    let decoder = JSONDecoder()
                    let temp = try decoder.decode(Login.self, from: data)
                    print(temp)
                    
                    LoginWithMail.usersID_ONLY = temp.data.id!
                    LoginWithMail.usersToken_ONLY = temp.data.token!

                    print(LoginWithMail.usersID_ONLY)
                    print(LoginWithMail.usersToken_ONLY)
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
    
}


