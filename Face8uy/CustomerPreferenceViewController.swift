//
//  ThirdViewController.swift
//  Example2
//
//  Created by apple on 2020/8/27.
//  Copyright © 2020 apple. All rights reserved.
// 顧客喜好


import UIKit
import Charts

class CustomerPreferenceViewController: UIViewController {
    
    @IBOutlet var pieView:PieChartView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupPieChart()
    }
    
    func setupPieChart() {
        pieView.noDataText = "You Need to Provide Data."
        pieView.chartDescription?.enabled = false
        pieView.drawHoleEnabled = false
        pieView.rotationAngle = 0
        //pieView.rotationEnabled = false
        pieView.isUserInteractionEnabled = false
        pieView.usePercentValuesEnabled = true
        
        var data = [Int]()
        data.append(contentsOf: [10001,10002,10003,10004,10001,10002,10003,10004,10005,10006,10007,10008,10009,10010,10011,10012,10013,10014,10015,10016,10017,10018,10019,10020,10021,10022,10023,10029,10030,10031,10032,10033,10040,10041,10042,10043,10044,10045,10046,10047,10048,10049,10050,10051,10052,10053,10054,10055,10056,10057,10058,10059,10060,20001,20002,20003,20004,20001,20002,20003,20004,20001,20002,20003,20004,20001,20002,20003,20004,30001,30002,30003,30004,30005,30006,30007,30008,30009,30003,30004,30005,30006,30007,30008,30009,30010,30011,30012,30013,30014,30015,50001,50002,50003,50001,50002,50003,50004,50005,50006,50008,50009,50010,70001,70002,70001,70002,70003,70001,70002,70003,70001,70002,70003,70001,70002,70003,80001,80002,80003,80004,80005,80006,80007,80008,80009,80010,80011,80012,80013,80010,80011,80012,80013,80014,80015,80016,80017,80018,80019,80020,80021,80022,80023,80024,80025,80026,80027,80028,80029,80030,90001,90002,90003,90004,90005,90001,90002,90003,90004,90005,90001,90002,90003,90004,90005])
        
        
        var count1 = 0
        var count2 = 0
        var count3 = 0
        var count4 = 0
        var count5 = 0
        var count6 = 0
        var count7 = 0
        
        for i in 0..<data.count{
            switch data[i] {
            case 30000...39999:
                count1 += 1
            case 70000...79999:
                count2 += 1
            case 20000...29999:
                count3 += 1
            case 90000...99999:
                count4 += 1
            case 80000...89999:
                count5 += 1
            case 50000...59999:
                count6 += 1
            case 10000...19999:
                count7 += 1
            default:
                break
            }
        }
        
        
        
        var value = [Int]()
        value.append(contentsOf: [count1,count2,count3,count4,count5,count6,count7])
        var sum = 0
        for i in value{
            sum += i
        }
        
        var number = [Double]()
        for i in 0..<value.count{
            number.append(Double(value[i])/Double(sum))
        }
        
        
        var entries: [PieChartDataEntry] = Array()
        entries.append(PieChartDataEntry(value: number[0],label: "浴室"))
        entries.append(PieChartDataEntry(value: number[1],label: "瑞典食物"))
        entries.append(PieChartDataEntry(value: number[2],label: "寵物用品"))
        entries.append(PieChartDataEntry(value: number[3],label: "戶外空間"))
        entries.append(PieChartDataEntry(value: number[4],label: "廚房"))
        entries.append(PieChartDataEntry(value: number[5],label: "餐廳"))
        entries.append(PieChartDataEntry(value: number[6],label: "居家生活"))

        let dataSet = PieChartDataSet(entries: entries, label: "")
        
        let c1 = NSUIColor (hex: 0xFF79BC)
        let c2 = NSUIColor (hex: 0xF89F43)
        let c3 = NSUIColor (hex: 0xFFD306)
        let c4 = NSUIColor (hex: 0x5CA043)
        let c5 = NSUIColor (hex: 0x23b89f)
        let c6 = NSUIColor (hex: 0x53A0FF)
        let c7 = NSUIColor (hex: 0xAEB1FC)

        dataSet.colors = [c1, c2, c3, c4, c5, c6, c7]
        dataSet.drawValuesEnabled = true
        
        pieView.data = PieChartData(dataSet: dataSet)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
