//
//  BusTimeViewController.swift
//  Face8uy
//
//  Created by 國維黃 on 2020/10/10.
//  Copyright © 2020 國維黃. All rights reserved.
//

import UIKit

class BusTimeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var busTimeTable: UITableView!
    
    static let routeIDtable:Array<Int> = [10326, 15161, 10848, 11815, 11813, 11811, 10751, 15512, 10743, 10721, 10783, 10752, 15515, 10782, 10724, 15657, 15572, 10734, 10785, 11833, 10746, 11764, 15191, 15164, 15113, 10736, 10792, 10735, 11221, 11022, 15112, 10723, 10711, 16157, 11763, 10712, 10332, 15563, 15546, 10328,16169, 16172, 10333, 16439, 16709, 16747, 11834, 17512, 17928]
    static let busName:Array<String> = ["648","676","505","606","109","0南","棕12","675","棕11","藍28","254","278","668","673","907","280直","207","景美-榮總(快)","672","復興幹線","252","251區","660","530","208區","671","52","253","284","綠11","208","1","羅斯福路幹線","208直","236區","251","松江新生幹線","311","280","643","672區","懷恩專車S31","644","278區","254區","棕22","688","311區","907通勤"]
    
    
    
    
    static let locatedstopId:Array<Int> = [35537, 27601, 39508, 43420, 43299, 43117, 16487, 28975, 15027, 11457, 17690, 22361, 45243, 38727, 37721, 18473, 45906, 37842, 38876, 11990, 37944, 18026, 20237, 19943, 19410, 17872, 17176, 17481, 18806, 15659, 19300, 16925, 17229, 58659, 15374, 17377, 14310, 13437, 14442, 14498, 59129, 59619, 14650, 125225, 152008, 155437, 12632, 178188, 196806]

    
    
    static var idRoute:Array<String> = ["藍5"]
    //["藍5","藍10","46","市民小巴7","市民小巴7","650","藍5","藍10","46","28","669","678","669","261"]
    static var timeEstimate:Array<String> = ["3分"]
    //["3分","3分","3分","6分","7分","10分","10分","15分","17分","22分","26分","29分","ㄉ分","66分"]
    static var goOrBack:Array<String> = ["回程"]
    //["回程","去程","去程","去程","回程","去程","去程","去程","回程","去程","去程","回程","去程","回程"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        BusTimeViewController.requestWithURL(urlString: "https://tcgbusfs.blob.core.windows.net/blobbus/GetEstiamteTime.json", parameters:["":""]) { (Data) in
            
        }
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        busTimeTable.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BusTimeViewController.idRoute.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "busCell", for: indexPath) as! BusTimeTableViewCell
            
        let a = BusTimeViewController.idRoute[indexPath.row]
        cell.busNumber?.text = a
        let b = BusTimeViewController.goOrBack[indexPath.row]
        cell.goNback?.text = b
        let c = BusTimeViewController.timeEstimate[indexPath.row]
        cell.time?.text = c
            return cell

    }
    
   
    
    
    static func requestWithURL(urlString: String, parameters: [String: Any], completion: @escaping (Data) -> Void){
        
        var urlComponents = URLComponents(string: urlString)!
        urlComponents.queryItems = []
        
        for (key, value) in parameters{
            guard let value = value as? String else{return}
            urlComponents.queryItems?.append(URLQueryItem(name: key, value: value))
        }
        
        guard let queryedURL = urlComponents.url else{return}
        
        let request = URLRequest(url: queryedURL)
        
        BusTimeViewController.fetchedDataByDataTask(from: request, completion: completion)
    }


    static func fetchedDataByDataTask(from request: URLRequest, completion: @escaping (Data) -> Void){
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil{
                print(error as Any)
            }
            else
            {
                guard let data = data else{return}
                do{
                    let decoder = JSONDecoder()
                    let temp = try decoder.decode(Bus.self, from: data)
                    print(temp)
                    BusTimeViewController.timeEstimate = []
                    BusTimeViewController.goOrBack = []
                    BusTimeViewController.idRoute = []
                    //let a = temp.BusInfo
                    
                    for i in 0...(temp.BusInfo!.count-1)
                    {
                        let allBus = temp.BusInfo![i]
                        let stopID = allBus.StopID!
                        let busTimeEst = allBus.EstimateTime!
                        let routeID = allBus.RouteID!
                        let goBack = allBus.GoBack!
                        
                        
                        for j in 0...(BusTimeViewController.locatedstopId.count-1)//  尋找api裡面正確的站牌
                        {
                            if stopID == BusTimeViewController.locatedstopId[j]//  尋找api裡面正確的站牌
                            {
                                for k in 0...(BusTimeViewController.routeIDtable.count-1)//  學找一樣的車號
                                {
                                    if BusTimeViewController.routeIDtable[k] == routeID //一樣時
                                    {
                                        BusTimeViewController.idRoute.append(BusTimeViewController.busName[k])//尋找對應的名字
                                        
                                        
                                    }
                                }
                                
                                switch busTimeEst
                                {
                                case "-1":
                                    BusTimeViewController.timeEstimate.append("尚未發車")
                                case "-2":
                                    BusTimeViewController.timeEstimate.append("交管不停靠")
                                case "-3":
                                    BusTimeViewController.timeEstimate.append("末班已駛離")
                                case "-4":
                                    BusTimeViewController.timeEstimate.append("今日未營運")
                                    
                                default:
                                    let t:Int = Int(busTimeEst)!
                                    
                                    BusTimeViewController.timeEstimate.append(String(t/60)+"分")
                                }
                                
                                switch goBack
                                {
                                case "0":
                                    BusTimeViewController.goOrBack.append("去程")
                                case "1":
                                    BusTimeViewController.goOrBack.append("返程")
                                case "2":
                                    BusTimeViewController.goOrBack.append(" ")
                                case "3":
                                    BusTimeViewController.goOrBack.append("末班已駛離")
                                    
                                default:
                                    BusTimeViewController.goOrBack.append(goBack)
                                }
                                
                                                            
                                print(BusTimeViewController.idRoute)
                                print(BusTimeViewController.timeEstimate)
                                print(BusTimeViewController.goOrBack)
                            }
                            
                        }
                        
                        
                    }
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

        
    

        

