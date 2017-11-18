//
//  ViewController.swift
//  fbxpollenfallen
//
//  Created by Laurin Fisher on 11/10/17.
//  Copyright © 2017 UAF. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController, ChartViewDelegate {


    @IBOutlet weak var yAxisView: UIView!
    @IBOutlet weak var yAxisLabel: UILabel!
    @IBOutlet weak var lineChartVerticalStackView: UIStackView!
    @IBOutlet weak var GraphLabel: UILabel!
    @IBOutlet weak var xAxisLabel: UILabel!
    @IBOutlet weak var lineChart: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        yAxisLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
       // yAxisLabel.bounds.width = yAxisView.bounds.height
        //yAxisView.frame.size.width = 10
        
        self.lineChart.delegate = self
        self.lineChart.chartDescription?.text = "Tap node for details"
        self.lineChart.chartDescription?.textColor = UIColor.white
        self.lineChart.gridBackgroundColor = UIColor.darkGray
        self.lineChart.noDataText = "no data provided"
        
        //fake data
        let x = [0, 1, 2, 3, 4, 5];
        let y = [20, 30, 50, 22, 30];
        
        makeChart(x: x, y: y)
        
        //have horizontal stack view w/ chart & y_axis label fill screen
       // lineChartVerticalStackView.axis = .vertical
        lineChartVerticalStackView.distribution = .fill
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Chart functions
    func makeChart(x: [Int], y: [Int]){
  
        var yVal : [ChartDataEntry] = [ChartDataEntry]()
        for i in 0..<y.count{
            yVal.append(ChartDataEntry(x: Double(i+1), y: Double(y[i])))
        }
        var xVal : [ChartDataEntry] = [ChartDataEntry]()
        for i in 0..<x.count{
            xVal.append(ChartDataEntry(x: Double(i+1), y: Double(x[i])))
        }
        let data = LineChartData()
        let dataSet = LineChartDataSet(values: yVal, label: "Pollen Count")
        dataSet.setColor(UIColor.red)
        dataSet.setCircleColor(UIColor.red)
        let dataSet2 = LineChartDataSet(values: xVal, label: "Something")
        dataSet2.setColor(UIColor.black)
        dataSet2.setCircleColor(UIColor.black)
        data.addDataSet(dataSet)
        data.addDataSet(dataSet2)
        
        let months = [" ", "Jan", "Feb", "Mar", "Apr", "May"]
        lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        lineChart.xAxis.granularity = 1
        lineChart.xAxis.avoidFirstLastClippingEnabled = true
        lineChart.xAxis.labelPosition = .bottom
       // lineChart.xAxis.setLabelCount(5, force: true)
        lineChart.data = data
    }


}

