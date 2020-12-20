//
//  BusAPI.swift
//  Face8uy
//
//  Created by 國維黃 on 2020/10/9.
//  Copyright © 2020 國維黃. All rights reserved.
//

import Foundation

func requestWithURL(urlString: String, parameters: [String: Any], completion: @escaping (Data) -> Void){
    
    var urlComponents = URLComponents(string: urlString)!
    urlComponents.queryItems = []
    
    for (key, value) in parameters{
        guard let value = value as? String else{return}
        urlComponents.queryItems?.append(URLQueryItem(name: key, value: value))
    }
    
    guard let queryedURL = urlComponents.url else{return}
    
    let request = URLRequest(url: queryedURL)
    
    fetchedDataByDataTask(from: request, completion: completion)
}


func fetchedDataByDataTask(from request: URLRequest, completion: @escaping (Data) -> Void){
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        
        if error != nil{
            print(error as Any)
        }else{
            guard let data = data else{return}
            do{
                let js = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                print(js)
                
            }
            catch{
                print(error)
            }
            
            print(data)
            completion(data)
        }
    }
    task.resume()
}
