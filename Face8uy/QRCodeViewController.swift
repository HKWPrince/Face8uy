
//
//  QRCodeViewController.swift
//  Face8uy
//
//  Created by 國維黃 on 2020/8/18.
//  Copyright © 2020 國維黃. All rights reserved.
//

import UIKit
import AVFoundation
import SafariServices
import Firebase

class QRCodeViewController: UIViewController , AVCaptureMetadataOutputObjectsDelegate ,UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    @IBOutlet weak var camView: UIView!
    @IBOutlet weak var codeTextLabel: UILabel!
    @IBOutlet weak var webButton: UIButton!
    @IBOutlet weak var albumButton: UIButton!
    @IBOutlet weak var detail: UIButton!
    @IBOutlet weak var clear: UIButton!
    
    var captureSesion:AVCaptureSession?
    var previewLayer:AVCaptureVideoPreviewLayer!
    var QRCodeString:String!
    
    var merchandiseID: String = ""
    static var additemtolist: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webButton.layer.cornerRadius = 8
        webButton.layer.shadowColor = UIColor.black.cgColor
        webButton.layer.shadowRadius = 2
        webButton.layer.shadowOpacity = 0.5
        webButton.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)
        
        albumButton.layer.cornerRadius = 8
        albumButton.layer.shadowColor = UIColor.black.cgColor
        albumButton.layer.shadowRadius = 2
        albumButton.layer.shadowOpacity = 0.5
        albumButton.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)
        detail.layer.cornerRadius = 8
        detail.layer.shadowColor = UIColor.black.cgColor
        detail.layer.shadowRadius = 2
        detail.layer.shadowOpacity = 0.5
        detail.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)
        
        clear.layer.cornerRadius = 8
        clear.layer.shadowColor = UIColor.black.cgColor
        clear.layer.shadowRadius = 2
        clear.layer.shadowOpacity = 0.5
        clear.layer.shadowOffset = CGSize(width: 0.6, height: 0.6)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if(captureSesion?.isRunning == false){
            captureSesion?.startRunning()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
         setQRCodeScan()
        
    }
    
    //掃QRCode的動作
    func setQRCodeScan(){
        
        //實體化一個AVCaptureSession物件
        captureSesion = AVCaptureSession()
        
        //AVCaptureDevice可以抓到相機和其屬性
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {return}
        let videoInput:AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        }catch let error {
            print(error)
            return
        }
        if (captureSesion?.canAddInput(videoInput) ?? false ){
            captureSesion?.addInput(videoInput)
        }else{
            return
        }
        
        //AVCaptureMetaDataOutput輸出影音資料，先實體化AVCaptureMetaDataOutput物件
        let metaDataOutput = AVCaptureMetadataOutput()
        if (captureSesion?.canAddOutput(metaDataOutput) ?? false)
        {
            //***
            captureSesion?.addOutput(metaDataOutput)
            
            //關鍵！執行處理QRCode
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            //metadataOutput.metadataObjectTypes表示要處理哪些類型的資料，處理QRCODE
            metaDataOutput.metadataObjectTypes = [.qr, .ean8 , .ean13 , .pdf417]
            
        }else{
            return
        }
        
        //用AVCaptureVideoPreviewLayer來呈現Session上的資料
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSesion!)
        //顯示size
        previewLayer.videoGravity = .resizeAspectFill
        //呈現在camView上面
        previewLayer.frame = camView.layer.frame
        //加入畫面
        view.layer.addSublayer(previewLayer)
        
        //顯示scan Area window 框框
        let size = 300
        let sWidth = Int(view.frame.size.width)
        let xPos = (sWidth/2)-(size/2)
        let scanRect = CGRect(x: CGFloat(xPos), y: 100 , width: CGFloat(size) , height: CGFloat(size))
        //設定scan Area window 框框
        let scanAreaView = UIView()
        scanAreaView.layer.borderColor = UIColor.gray.cgColor
        scanAreaView.layer.borderWidth = 2
        scanAreaView.frame = scanRect
        view.addSubview(scanAreaView)
        view.bringSubviewToFront(scanAreaView)
        
        //開始影像擷取呈現鏡頭的畫面
        captureSesion?.startRunning()
    }
    //延遲時間
    
    
    
    
    
    // 從資料庫裡以ID打撈商品名稱出來，並回傳
        
    
    
    //使用AVCaptureMetadataOutput物件辨識QR Code，此AVCaptureMetadataOutputObjectsDelegate的委派方法metadataOutout會被呼叫
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection)
    {
        captureSesion?.startRunning()
        if let metadataObject = metadataObjects.first{
            
            //AVMetadataMachineReadableCodeObject是從OutPut擷取到barcode內容
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else {return}
            //將讀取到的內容轉成string
            guard let stringValue = readableObject.stringValue else {return}
            merchandiseID = stringValue
            //掃到QRCode後的震動提示
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            //將string資料放到label元件上
            //var result: String?
            
            //存取QRcodeURL
            
            if ((Int(stringValue) ?? 0)/10000 > 0)
            {
                getMerchandiseName(stringValue) { (result) in
                    
                    
                        self.codeTextLabel.text = result
                    
                }
                //codeTextLabel.text =
                //存取QRcodeURL
                QRCodeString = stringValue
                QRCodeViewController.additemtolist = stringValue
                
            }
            else
            {
                let controller = UIAlertController(title: "查無此商品", message: "請掃描正確商品Qrcode", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                controller.addAction(okAction)
                present(controller, animated: true)
            }
            
            
            
        }
    }
    
    //畫面不顯示即停止掃描
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if(captureSesion?.isRunning == true){
            captureSesion?.stopRunning()
        }
    }
    
    
    //掃碼的按鈕
    @IBAction func scanAlbumButton(_ sender: Any) {
        let photoController = UIImagePickerController()
        photoController.delegate = self
        photoController.sourceType = .photoLibrary
        present(photoController,animated: true , completion: nil)
    }
    
    //取得相片後讀取QRCode
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
            let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh]),
            let ciImage = CIImage(image: pickedImage),
            let features = detector.features(in: ciImage) as? [CIQRCodeFeature] else {return}
        let qrCodeLink = features.reduce(""){ $0 + ($1.messageString ?? "")}
        codeTextLabel.text = qrCodeLink
        QRCodeString = qrCodeLink
        picker.dismiss(animated: true, completion: nil)
    }
    
    //開啟網頁
    //＊＊＊＊要把QRcode內容傳到購物清單頁面
    
    
    
    
    
    
    @IBAction func openWebButton(_ sender: Any) {
        
        //QRCodeViewController.additemtolist
        
        ShoppingListControl.addItemToShoppingList(newItem: QRCodeViewController.additemtolist )
        getMerchandiseP(QRCodeViewController.additemtolist) { (a) in
            ShoppingListControl.addItemPriceToList(newPrice: a!)
        }
        
        
        let controller = UIAlertController(title: "成功加入購物車", message: "請再接再厲塞滿購物車", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true)
        
    }
    
    //清空codeTextLabel
    @IBAction func removeQRCode(_ sender: Any) {
        QRCodeString.removeAll()
        codeTextLabel.text = ""
    }
    
    
    @IBAction func detailAboutMerchanidse(_ sender: Any) {
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is DetailOfMerchandiseViewController
        {
            let vc = segue.destination as? DetailOfMerchandiseViewController
            vc?.merchandiseID = merchandiseID
        }
    }
    
    
    //start
    func getMerchandiseName(_ ID: String,completion: @escaping ((String?) -> ()))
    {
        var nameOFitem :String?
        
        let db = Firestore.firestore()
        db.collection("merchandise").document(ID).getDocument() { (document, error) in
        if error == nil
        {
            if document != nil && document!.exists
            {
                let documentData = document!.get("Name")
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
    

}

