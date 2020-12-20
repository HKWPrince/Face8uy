//
//  AnalysisStartViewController.swift
//  Face8uy
//
//  Created by 國維黃 on 2020/9/7.
//  Copyright © 2020 國維黃. All rights reserved.
//

import UIKit
import AVFoundation
import Photos


class AnalysisStartViewController: UIViewController{

    @IBOutlet fileprivate var capturePreviewView: UIView!
    @IBOutlet fileprivate  var captureButton: UIButton!
    @IBOutlet fileprivate var photoModeButton: UIButton!
    @IBOutlet fileprivate var toggleCameraButton: UIButton!
    @IBOutlet fileprivate var toggleFlashButton: UIButton!
    @IBOutlet fileprivate var videoModeButton: UIButton!
    
    
    @IBOutlet var maleNum: UILabel!
    @IBOutlet var femaleNum: UILabel!
    @IBOutlet var age15Num: UILabel!
    @IBOutlet var age20Num: UILabel!
    @IBOutlet var age30Num: UILabel!
    @IBOutlet var age40Num: UILabel!
    @IBOutlet var age50Num: UILabel!
    @IBOutlet var age60Num: UILabel!
    @IBOutlet var age70Num: UILabel!
    @IBOutlet var totalNum: UILabel!
    @IBOutlet var withMask: UILabel!
    
    static var gender_MaleAnalysis: Int = 0
    static var gender_FemaleAnalysis: Int = 0
    static var age_15s: Int = 0
    static var age_20s: Int = 0
    static var age_30s: Int = 0
    static var age_40s: Int = 0
    static var age_50s: Int = 0
    static var age_60s: Int = 0
    static var age_70s: Int = 0
    static var totalCustomer: Int = 0
    static var withMask0: Int = 0
    
    
    let cameraController = CameraController()
    
    
        override func viewDidLoad() {
            
            func configureCameraController() {
                cameraController.prepare {(error) in
                    if let error = error {
                        print(error)
                    }
                    
                    try? self.cameraController.displayPreview(on: self.capturePreviewView)
                }
            }
            
            func styleCaptureButton() {
                captureButton.layer.borderColor = UIColor.black.cgColor
                captureButton.layer.borderWidth = 2
                
                captureButton.layer.cornerRadius = min(captureButton.frame.width, captureButton.frame.height) / 2
            }
            
            styleCaptureButton()
            configureCameraController()
            
        }
    
    
        @IBAction func toggleFlash(_ sender: Any) {
            if cameraController.flashMode == .on {
                cameraController.flashMode = .off
                toggleFlashButton.setImage(#imageLiteral(resourceName: "Flash Off Icon"), for: .normal)
            }
                
            else {
                cameraController.flashMode = .on
                toggleFlashButton.setImage(#imageLiteral(resourceName: "Flash On Icon"), for: .normal)
            }
        }
        
    @IBAction func switchCameras(_ sender: Any) {
        do {
            try cameraController.switchCameras()
        }
            
        catch {
            print(error)
        }
        
        switch cameraController.currentCameraPosition {
        case .some(.front):
            toggleCameraButton.setImage(#imageLiteral(resourceName: "Front Camera Icon"), for: .normal)
            
        case .some(.rear):
            toggleCameraButton.setImage(#imageLiteral(resourceName: "Rear Camera Icon"), for: .normal)
            
        case .none:
            return
        }
    }
    
    @IBAction func captureImage(_ sender: Any) {
        
        cameraController.captureImage {(image, error) in
                   guard let image = image else {
                       print(error ?? "Image capture error")
                       return
                   }
                   
                   try? PHPhotoLibrary.shared().performChangesAndWait {
                       PHAssetChangeRequest.creationRequestForAsset(from: image)
                   }
            //let pic = UIImage(named: "1234567")!
            //let uploadData = pic.jpegData(compressionQuality: 1.0)
            let uploadData = image.jpegData(compressionQuality: 1.0)
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            let dataPath = ["image_file":uploadData!]
            requestWithFormData(urlString: "https://api.face8.ai/api/detect", parameters: ["api_key": "23f13a516fba443796cc89daecd81509","api_secret": "f80e44bca218478ea17e5db6ff42fbad","face_detect": "1","return_attributes":"age,gender,mask"], dataPath: dataPath) { (data) in
                DispatchQueue.main.async {
                    print(data)
                }
               }
        
        
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
               fetchedDataByDataTaskFor_Analysis(from: request, completion: completion)
               
           }
        func fetchedDataByDataTaskFor_Analysis(from request: URLRequest, completion: @escaping (Data) -> Void){
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error != nil{
                    print(error as Any)
                }
                else
                {
                    guard let data = data else{return}
                    do{
                        
                        let decoder = JSONDecoder()
                        let temp = try decoder.decode(Analysis.self, from: data)
                        print(temp)
                        
                        let customerNumber:Int = temp.faces!.count
                        AnalysisStartViewController.totalCustomer = AnalysisStartViewController.totalCustomer+customerNumber
                        
                        if customerNumber > 0
                        {
                            for i in 0...(customerNumber-1)
                            {
                                let detectDetail = temp.faces![i]
                                let mask = detectDetail.attributes.mask!
                                if mask == 1 {
                                    AnalysisStartViewController.withMask0 = AnalysisStartViewController.withMask0+1
                                }
                                let gender = detectDetail.attributes.gender!
                                if gender == "Male"
                                {
                                    AnalysisStartViewController.gender_MaleAnalysis = AnalysisStartViewController.gender_MaleAnalysis+1
                                }
                                else
                                {
                                    AnalysisStartViewController.gender_FemaleAnalysis =  AnalysisStartViewController.gender_FemaleAnalysis+1
                                }
                                let age = detectDetail.attributes.age!
                                
                                if age < 20
                                {
                                    AnalysisStartViewController.age_15s = AnalysisStartViewController.age_15s+1
                                    
                                }
                                else if age >= 20 && age < 30
                                {
                                    AnalysisStartViewController.age_20s = AnalysisStartViewController.age_20s+1
                                }
                                else if age >= 30 && age < 40
                                {
                                    AnalysisStartViewController.age_30s = AnalysisStartViewController.age_30s+1
                                }
                                else if age >= 40 && age < 50
                                {
                                    AnalysisStartViewController.age_40s = AnalysisStartViewController.age_40s+1
                                }
                                else if age >= 50 && age < 60
                                {
                                    AnalysisStartViewController.age_50s = AnalysisStartViewController.age_50s+1
                                }
                                else
                                {
                                    AnalysisStartViewController.age_70s = AnalysisStartViewController.age_70s+1
                                }
    
                            }
                        }
                        
                        
                        
                        DispatchQueue.main.async {
                            self.age15Num.text = "20以下："+"\(AnalysisStartViewController.age_15s)"
                            self.age20Num.text = "2X:："+"\(AnalysisStartViewController.age_20s)"
                            self.age30Num.text = "3X:："+"\(AnalysisStartViewController.age_30s)"
                            self.age40Num.text = "4X:："+"\(AnalysisStartViewController.age_40s)"
                            self.age50Num.text = "5X:："+"\(AnalysisStartViewController.age_50s)"
                            self.age60Num.text = "6X:："+"\(AnalysisStartViewController.age_60s)"
                            self.age70Num.text = "70以上:"+"\(AnalysisStartViewController.age_70s)"
                            self.maleNum.text = "男:"+"\(AnalysisStartViewController.gender_MaleAnalysis)"
                            self.femaleNum.text = "女:"+"\(AnalysisStartViewController.gender_FemaleAnalysis)"
                            self.totalNum.text = "人："+"\(AnalysisStartViewController.totalCustomer)"
                            self.withMask.text = "口罩:"+"\(AnalysisStartViewController.withMask0)"
                            
                        }
                        
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
    }
        
    
}
    

        
        
        
        
        
        
        
    
    
    
    
    
    
    
    
    


