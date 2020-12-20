//
//  FourthViewController.swift
//  Example2
//
//  Created by apple on 2020/9/1.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Charts
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

class GenderAnalysisViewController: UIViewController {
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
        
        
        var data = [String]()
        data.append(contentsOf: ["男","女","男","女","男","女","男","女","男","男","男","男","男","男","女"])//[]放入"性別"內的資料
        
        var count1 = 0.0
        var count2 = 0.0
        
        for i in 0..<data.count{
            switch data[i] {
            case "男":
                count1 += 1
            case "女":
                count2 += 1
            default:
                    break
            }
            
        }
        
        var value = [Double]()
        value.append(contentsOf: [count1,count2])
        
        let man = value[0]/(value[0]+value[1])
        let woman = value[1]/(value[0]+value[1])
        
        let x1 = Double(man).rounded(toPlaces: 8)
        let x2 = Double(woman).rounded(toPlaces: 8)
        
        var entries: [PieChartDataEntry] = Array()
        entries.append(PieChartDataEntry(value: Double(x1),label: "男生"))
        entries.append(PieChartDataEntry(value: Double(x2),label: "女生"))
        
        
        let dataSet = PieChartDataSet(entries: entries, label: "")
        
        
        let c1 = NSUIColor (hex: 0x0072E3)
        let c2 = NSUIColor (hex: 0xFF359A)
       
        
        dataSet.colors = [c1, c2]
        dataSet.drawValuesEnabled = true
        

        
        pieView.data = PieChartData(dataSet: dataSet)
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


