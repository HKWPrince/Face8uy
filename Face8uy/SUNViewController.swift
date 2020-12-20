//
//  SunViewController.swift
//  Example2
//
//  Created by apple on 2020/9/7.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Charts
class SUNViewController: UIViewController, ChartViewDelegate{

    

    var barChart = BarChartView()
    override func viewDidLoad() {
        super.viewDidLoad()
        barChart.delegate = self

        
    }
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()

        barChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
           barChart.noDataText = "You Need to Provide Data."
           barChart.center = view.center
           view.addSubview(barChart)
           
           var data1 = [Int]()
           data1.append(contentsOf: [14,16,14,16,15,18,19,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,17,19,12,13,10,11,12,10,11,13,16,17,19,18,14,16,12,10,16,19,18,17,10,18,19,15,17,16,16,17,20,10,13,14,16,12,10,11,13,16,17,19,18,13,16,17,19,18,14,16,12,10,16,19,18,17,10,18,19,15,17,16,16,17,20,10,13,14,16,12,10,11,13,16,17,19,18,14,16,12,10,16,14,15,16,14,16,16,14,15,16,14,16,15,18,19,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,20,10,13,14,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,20,10,13,14,16,17,19,18,17,10,18,19,17,16,16,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,17,19,12,13,10,11,12,18,19,21,20,20,10,13,14,16,12,10,11,13,16,17,19,18,14,16,12,10,16,14,15,16,14,16,15,18,19,21,20,20,10,13,14,16,14,16,15,18,19,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,17,19,12,13,10,11,12,10,11,13,16,17,19,18,14,16,12,10,16,14,15,16,14,16,10,16,19,18,17,10,18,19,15,17,16,16,17,20,10,13,14,16,12,10,11,13,16,17,19,18,14,16,12,10,16,14,15,16,14,16,15,18,19,21,20,20,10,13,14,16,14,16,15,18,19,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,17,19,12,13,10,11,12,10,11,13,16,17,19,18,14,16,12,10,16,19,18,17,10,18,19,15,17,16,16,17,19,12,13,10,11,12,10,11,13,16,17,19,18,14,16,12,10,16,14,15,16,14,16,15,18,19,21,20,20,10,13,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,20,10,13,14,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,16,19,18,17,10,18,19,15,17,16,16,17,19,12,13,10,11,12,10,11,13,16,17,19,18,14,16,12,10,16,14,15,16,14,16,15,18,19,21,20,20,10,13,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,20,10,13,14,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,20,10,13,14,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,17,19,12,13,10,11,12,18,19,21,20,20,10,13,14,16,12,10,11,13,16,17,19,18,14,16,12,10,16,14,15,16,14,16,15,18,19,21,20,20,10,13,14,16,14,16,15,18,19,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,17,19,12,13,10,11,12,10,11,13,16,17,19,18,14,16,12,10,16,14,15,16,14,16,15,18,19,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,17,19,14,16,14,16,15,18,19,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,17,19,12,13,10,11,12,10,11,13,16,17,19,18,14,16,12,10,16,19,18,17,10,18,19,15,17,16,16,17,20,10,13,14,16,12,10,11,13,16,17,19,18,13,16,17,19,18,14,16,12,10,16,19,18,17,10,18,19,15,17,16,16,17,20,10,13,14,16,12,10,11,13,16,17,19,18,14,16,12,10,16,14,15,16,14,16,16,14,15,16,14,16,15,18,19,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,20,10,13,14,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,20,10,13,14,16,17,19,18,17,10,18,19,17,16,16,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,17,19,12,13,10,11,12,18,19,21,20,20,10,13,14,16,12,10,11,13,16,17,19,18,14,16,12,10,16,14,15,16,14,16,15,18,19,21,20,20,10,13,14,16,14,16,15,18,19,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,17,19,12,13,10,11,12,10,11,13,16,17,19,18,14,16,12,10,16,14,15,16,14,16,10,16,19,18,17,10,18,19,15,17,16,16,17,20,10,13,14,16,12,10,11,13,16,17,19,18,14,16,12,10,16,14,15,16,14,16,15,18,19,21,20,20,10,13,14,16,14,16,15,18,19,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,17,19,12,13,10,11,12,10,11,13,16,17,19,18,14,16,12,10,16,19,18,17,10,18,19,15,17,16,16,17,19,12,13,10,11,12,10,11,13,16,17,19,18,14,16,12,10,16,14,15,16,14,16,15,18,19,21,20,20,10,13,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,20,10,13,14,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,16,19,18,17,10,18,19,15,17,16,16,17,19,12,13,10,11,12,10,11,13,16,17,19,18,14,16,12,10,16,14,15,16,14,16,15,18,19,21,20,20,10,13,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,20,10,13,14,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,20,10,13,14,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,17,19,12,13,10,11,12,18,19,21,20,20,10,13,14,16,12,10,11,13,16,17,19,18,14,16,12,10,16,14,15,16,14,16,15,18,19,21,20,20,10,13,14,16,14,16,15,18,19,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,17,19,12,13,10,11,12,10,11,13,16,17,19,18,14])//[]放入這星期日所有"時"的資料
           var data2 = [Int]()
           data2.append(contentsOf: [16,12,10,16,14,15,16,14,16,15,18,19,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,17,19,14,16,14,16,15,18,19,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,17,19,12,13,10,11,12,10,11,13,16,17,19,18,14,16,12,10,16,19,18,17,10,18,19,15,17,16,16,17,20,10,13,14,16,12,10,11,13,16,17,19,18,13,16,17,19,18,14,16,12,10,16,19,18,17,10,18,19,15,17,16,16,17,20,10,13,14,16,12,10,11,13,16,17,19,18,14,16,12,10,16,14,15,16,14,16,16,14,15,16,14,16,15,18,19,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,20,10,13,14,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,20,10,13,14,16,17,19,18,17,10,18,19,17,16,16,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,17,19,12,13,10,11,12,18,19,21,20,20,10,13,14,16,12,10,11,13,16,17,19,18,14,16,12,10,16,14,15,16,14,16,15,18,19,21,20,20,10,13,14,16,14,16,15,18,19,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,17,19,12,13,10,11,12,10,11,13,16,17,19,18,14,16,12,10,16,14,15,16,14,16,10,16,19,18,17,10,18,19,15,17,16,16,17,20,10,13,14,16,12,10,11,13,16,17,19,18,14,16,12,10,16,14,15,16,14,16,15,18,19,21,20,20,10,13,14,16,14,16,15,18,19,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,17,19,12,13,10,11,12,10,11,13,16,17,19,18,14,16,12,10,16,19,18,17,10,18,19,15,17,16,16,17,19,12,13,10,11,12,10,11,13,16,17,19,18,14,16,12,10,16,14,15,16,14,16,15,18,19,21,20,20,10,13,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,20,10,13,14,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,16,19,18,17,10,18,19,15,17,16,16,17,19,12,13,10,11,12,10,11,13,16,17,19,18,14,16,12,10,16,14,15,16,14,16,15,18,19,21,20,20,10,13,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,20,10,13,14,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,20,10,13,14,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,17,19,12,13,10,11,12,18,19,21,20,20,10,13,14,16,12,10,11,13,16,17,19,18,14,16,12,10,16,14,15,16,14,16,15,18,19,21,20,20,10,13,14,16,14,16,15,18,19,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,17,19,12,13,10,11,12,10,11,13,16,17,19,18,14,16,12,10,16,14,15,16,14,16,15,18,19,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,17,19,14,16,14,16,15,18,19,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,17,19,12,13,10,11,12,10,11,13,16,17,19,18,14,16,12,10,16,19,18,17,10,18,19,15,17,16,16,17,20,10,13,14,16,12,10,11,13,16,17,19,18,13,16,17,19,18,14,16,12,10,16,19,18,17,10,18,19,15,17,16,16,17,20,10,13,14,16,12,10,11,13,16,17,19,18,14,16,12,10,16,14,15,16,14,16,16,14,15,16,14,16,15,18,19,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,20,10,13,14,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,20,10,13,14,16,17,19,18,17,10,18,19,17,16,16,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,17,19,12,13,10,11,12,18,19,21,20,20,10,13,14,16,12,10,11,13,16,17,19,18,14,16,12,10,16,14,15,16,14,16,15,18,19,21,20,20,10,13,14,16,14,16,15,18,19,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,17,19,12,13,10,11,12,10,11,13,16,17,19,18,14,16,12,10,16,14,15,16,14,16,10,16,19,18,17,10,18,19,15,17,16,16,17,20,10,13,14,16,12,10,11,13,16,17,19,18,14,16,12,10,16,14,15,16,14,16,15,18,19,21,20,20,10,13,14,16,14,16,15,18,19,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,17,19,12,13,10,11,12,10,11,13,16,17,19,18,14,16,12,10,16,19,18,17,10,18,19,15,17,16,16,17,19,12,13,10,11,12,10,11,13,16,17,19,18,14,16,12,10,16,14,15,16,14,16,15,18,19,21,20,20,10,13,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,20,10,13,14,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,16,19,18,17,10,18,19,15,17,16,16,17,19,12,13,10,11,12,10,11,13,16,17,19,18,14,16,12,10,16,14,15,16,14,16,15,18,19,21,20,20,10,13,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,20,10,13,14,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,20,10,13,14,21,20,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,20,10,13,14,16,17,19,18,17,10,18,19,15,17,16,16,17,19,12,13,10,11,12,18,19,21,20,20,10,13,14,16,12,10,11,13,16,17,19,18,14,16,12,10,16,14,15,16,14,16])//[]放入下星期日所有"時"的資料
           
           var count1 = 0
           var count2 = 0
           var count3 = 0
           var count4 = 0
           var count5 = 0
           var count6 = 0
           var count7 = 0
           var count8 = 0
           var count9 = 0
           var count10 = 0
           var count11 = 0
           var count12 = 0
           var dcount1 = 0
           var dcount2 = 0
           var dcount3 = 0
           var dcount4 = 0
           var dcount5 = 0
           var dcount6 = 0
           var dcount7 = 0
           var dcount8 = 0
           var dcount9 = 0
           var dcount10 = 0
           var dcount11 = 0
           var dcount12 = 0
           
           for i in 0..<data1.count{
               switch data1[i] {
               case 10:
                   count1 += 1
               case 11:
                   count2 += 1
               case 12:
                   count3 += 1
               case 13:
                   count4 += 1
               case 14:
                   count5 += 1
               case 15:
                   count6 += 1
               case 16:
                   count7 += 1
               case 17:
                   count8 += 1
               case 18:
                   count9 += 1
               case 19:
                   count10 += 1
               case 20:
                   count11 += 1
               case 21:
                   count12 += 1
               default:
                   break
               }
           }
           
           for i in 0..<data2.count{
               switch data2[i] {
               case 10:
                   dcount1 += 1
               case 11:
                   dcount2 += 1
               case 12:
                   dcount3 += 1
               case 13:
                   dcount4 += 1
               case 14:
                   dcount5 += 1
               case 15:
                   dcount6 += 1
               case 16:
                   dcount7 += 1
               case 17:
                   dcount8 += 1
               case 18:
                   dcount9 += 1
               case 19:
                   dcount10 += 1
               case 20:
                   dcount11 += 1
               case 21:
                   dcount12 += 1
               default:
                   break
               }
           }
              
              var value = [Double]()
           var Sun1 = [Int]()
           var Sun2 = [Int]()
           Sun1.append(contentsOf: [count1,count2,count3,count4,count5,count6,count7,count8,count9,count10,count11,count12])//[]內放入這星期一所有時段的來客數
           Sun2.append(contentsOf: [dcount1,dcount2,dcount3,dcount4,dcount5,dcount6,dcount7,dcount8,dcount9,dcount10,dcount11,dcount12])//[]內放入下星期一所有時段的來客數
           value.append(Double(Sun1[0]+Sun2[0])/2/20)//10.~11.
           value.append(Double(Sun1[1]+Sun2[1])/2/20)//11.~12.
           value.append(Double(Sun1[2]+Sun2[2])/2/20)//12.~13.
           value.append(Double(Sun1[3]+Sun2[3])/2/20)//13.~14.
           value.append(Double(Sun1[4]+Sun2[4])/2/20)//14.~15.
           value.append(Double(Sun1[5]+Sun2[5])/2/20)//15.~16.
           value.append(Double(Sun1[6]+Sun2[6])/2/20)//16.~17.
           value.append(Double(Sun1[7]+Sun2[7])/2/20)//17.~18.
           value.append(Double(Sun1[8]+Sun2[8])/2/20)//18.~19.
           value.append(Double(Sun1[9]+Sun2[9])/2/20)//19.~20.
           value.append(Double(Sun1[10]+Sun2[10])/2/20)//20.~21.
           value.append(Double(Sun1[11]+Sun2[11])/2/20)//21.~22.
        
        
        
           var entries = [BarChartDataEntry]()
           
        entries.append(BarChartDataEntry(x: 10.5, y: value[0]))
        entries.append(BarChartDataEntry(x: 11.5, y: value[1]))
        entries.append(BarChartDataEntry(x: 12.5, y: value[2]))
        entries.append(BarChartDataEntry(x: 13.5, y: value[3]))
        entries.append(BarChartDataEntry(x: 14.5, y: value[4]))
        entries.append(BarChartDataEntry(x: 15.5, y: value[5]))
        entries.append(BarChartDataEntry(x: 16.5, y: value[6]))
        entries.append(BarChartDataEntry(x: 17.5, y: value[7]))
        entries.append(BarChartDataEntry(x: 18.5, y: value[8]))
        entries.append(BarChartDataEntry(x: 19.5, y: value[9]))
        entries.append(BarChartDataEntry(x: 20.5, y: value[10]))
        entries.append(BarChartDataEntry(x: 21.5, y: value[11]))
           
           
           let set = BarChartDataSet(entries: entries)
           set.colors = ChartColorTemplates.joyful()
    
           let data = BarChartData(dataSet: set)
           
           barChart.data = data
        let leftFormatter = NumberFormatter()
        leftFormatter.positiveSuffix = "百"
        barChart.leftAxis.valueFormatter = DefaultAxisValueFormatter.init(formatter: leftFormatter)
        let xFormatter = NumberFormatter()
        xFormatter.positiveSuffix = "."
        barChart.xAxis.valueFormatter = DefaultAxisValueFormatter.init(formatter: xFormatter)
           barChart.legend.enabled = false
           barChart.xAxis.labelPosition = .bottom
           barChart.xAxis.axisMinimum = 10
           barChart.xAxis.axisMaximum = 22
           barChart.xAxis.labelCount=12
           barChart.rightAxis.enabled = false
           barChart.leftAxis.axisMinimum = 0
           barChart.leftAxis.drawZeroLineEnabled = true
           barChart.leftAxis.axisMaximum = 20
           barChart.leftAxis.labelCount = 10
       }

}
