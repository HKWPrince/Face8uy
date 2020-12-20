//
//  MaskViewController.swift
//  Example2
//
//  Created by apple on 2020/9/8.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Charts


class MaskAnslysisViewController: UIViewController {
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
        data.append(contentsOf: [0,1,1,1,1,0,0,0,1,0,1,1,1,1,0,1,1,1,1,0,0,0,1,0,1,1,1,1,0,1,1,1,1,0,0,0,1,0,1,1,1,1,0,1,1,1,1,0,0,0,1,0,1,1,1,1])//[]放入"Mask"內的資料(0 or 1)
        
        var count1 = 0.0
        var count2 = 0.0
        
        for i in 0..<data.count{
            switch data[i] {
            case 0:
                count1 += 1
            case 1:
                count2 += 1
            default:
                    break
            }
            
        }
        
        var value = [Double]()
        value.append(contentsOf: [count1,count2])
        
        let no = value[0]/(value[0]+value[1])
        let yes = value[1]/(value[0]+value[1])
        
        let x1 = yes.rounded(toPlaces: 8)
        let x2 = no.rounded(toPlaces: 8)
        
        var entries: [PieChartDataEntry] = Array()
        entries.append(PieChartDataEntry(value: x1,label: "有戴口罩"))
        entries.append(PieChartDataEntry(value: x2,label: "沒戴口罩"))
        
        
        let dataSet = PieChartDataSet(entries: entries, label: "")
        
        
        let c1 = NSUIColor (hex: 0x33CCFF)
        let c2 = NSUIColor (hex: 0x9999CC)
       
        
        dataSet.colors = [c1, c2]
        dataSet.drawValuesEnabled = true
        

        
        pieView.data = PieChartData(dataSet: dataSet)
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
