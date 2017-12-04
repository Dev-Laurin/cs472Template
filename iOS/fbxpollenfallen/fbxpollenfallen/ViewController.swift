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

    //Ctrl-Dragged from Storyboard, views & subviews for use
    @IBOutlet weak var yAxisView: UIView!
    @IBOutlet weak var lineChartVerticalStackView: UIStackView!
    @IBOutlet weak var GraphLabel: UILabel!
    @IBOutlet weak var lineChart: LineChartView!
    
    //For Charting
    var pollenSources = 14
    var pollenSourceSwitches = [Bool]()
    var years = ["2015", "2015"]
    
    //fake data
    let birchForTheYear = [0, 2, 4, 5, 6, 6, 3, 1, 0]
    let spruceForTheYear = [0,4,5,6,7,3,2,1, 9]
    let poplarAspenForTheYear = [0,1,1,1,1,1,1,1, 1]
    let willowForTheYear = [0,2,2,2,5,2,2,2, 2]
    let alderForTheYear = [0,3,4,6,4,3,3,3, 3]
    let otherTree1 = [5,4,9,4,4,4,4,4, 4]
    let otherTree2 = [5,6,5,6,5,5,5,7, 5]
    let weed = [1,2,6,6,7,6,6,7,6]
    let mold = [8,8,5,6,8,8,1,0, 8]
    let grass = [0,9,9,6,9,3,9,1, 10]
    let grass2 = [0,14,15,16,17,13,12,11, 19]
    let other1 = [0,0,0,0,5,0,0,0, 0]
    let other2 = [0,3,3,3,4,1,2,1,0]
    
    //The corresponding 3 arrays are for 1 year of data, with labels & colors for each
        //pollen source
    var year = [[Int]]()
    let names = ["Birch", "Spruce", "Poplar Aspen", "Willow", "Alder", "Other Tree", "Other Tree 2", "Weed", "Mold", "Grass", "Grass 2", "Other 1", "Other 2"]
    //swift has UIColor from 0.0-1.0, so I had to divide by 255 for RGB
    let color = [UIColor(displayP3Red: 34.0/255, green: 102.0/255, blue: 102.0/255, alpha: 1.0),UIColor(displayP3Red: 170.0/255, green: 108.0/255, blue: 57.0/255, alpha: 1.0),UIColor(displayP3Red: 198.0/255, green: 92.0/255, blue: 0.0, alpha: 1.0),UIColor(displayP3Red: 114.0/255, green: 125.0/255, blue: 21.0/255, alpha: 1.0), UIColor.green, UIColor(displayP3Red: 118.0/255, green: 39.0/255, blue: 108.0/255, alpha: 1.0), UIColor(displayP3Red: 170.0/255, green: 57.0/255, blue: 57.0/255, alpha: 1.0), UIColor(displayP3Red: 198.0/255, green: 148.0/255, blue: 0.0/255, alpha: 1.0), UIColor(displayP3Red: 154.0/255, green: 3.0/255, blue: 88.0/255, alpha: 1.0), UIColor(displayP3Red: 11.0/255, green: 166.0/255, blue: 104.0/255, alpha: 1.0), UIColor(displayP3Red: 10.0/255, green: 14.0/255, blue: 180.0/255, alpha: 1.0), UIColor(displayP3Red: 76.0/255, green: 45.0/255, blue: 115.0/255, alpha: 1.0),UIColor(displayP3Red: 42.0/255, green: 79.0/255, blue: 110.0/255, alpha: 1.0) ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //For label viewing purposes
        let screen = UIScreen.main.bounds
        
        //Create y_axis label
        let label = UILabel(frame: CGRect(x: yAxisView.bounds.width/4, y: screen.size.height/2, width: 100, height: 100))
        label.text = "Grains Per Cubic Meter of Air (p/m2)"
        label.sizeToFit()
        //Rotate the label -90 deg
        label.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
        //Make the new boundaries for the label to be visible in the view
        label.frame = CGRect(x: yAxisView.bounds.width/8, y: 0, width: 20, height: yAxisView.bounds.height/2)
        label.sizeToFit() 
        yAxisView.addSubview(label) //add the new label to the view
        
        //Initialize the Chart
        self.lineChart.delegate = self
        self.lineChart.chartDescription?.text = "Tap node for details"
        self.lineChart.chartDescription?.textColor = UIColor.white
        self.lineChart.gridBackgroundColor = UIColor.white
        self.lineChart.noDataText = "no data provided" //if no data
        
        //show all pollen sources initially
        for _ in 0..<pollenSources {
            pollenSourceSwitches.append(true)
        }
        
        //fake data
        year = [birchForTheYear, spruceForTheYear, poplarAspenForTheYear, willowForTheYear, alderForTheYear, otherTree1, otherTree2, weed, mold, grass, grass2, other1, other2]
        makeChart(x: year.count, y: year, labels: names, colors: color)
        
        //have horizontal stack view w/ chart & y_axis label fill screen
        lineChartVerticalStackView.distribution = .fill
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func turnDatabaseDataIntoChartable(){
        
    }
    
     //MARK: Chart functions
    //called when user re-opens graph scene from edit screen due to segues
    func changeChart(x: Int, y: [[Int]], labels: [String], colors: [UIColor]){
        lineChart.clear()
        //only add values to the chart that the user wants
        var yearArr = [[Int]]()
        var labelArr = [String]()
        var colorArr = [UIColor]()
        
        for i in 0..<pollenSourceSwitches.count{
            if(pollenSourceSwitches[i]){
                //add to year
                yearArr.append(y[i])
                labelArr.append(labels[i])
                colorArr.append(colors[i])
            }
        }
        makeChart(x: yearArr.count, y: yearArr, labels: labelArr, colors: colorArr)
    }
    
    func makeChart(x: Int, y: [[Int]], labels: [String], colors: [UIColor]){
        
        //Sort the years so that the oldest year is first Ex: 2015, 2016 not 2016, 2015
        years.sort()
        //convert year string to int
        var yearsInNumbers = [Int]()
        for i in 0..<years.count{
            print(i)
            yearsInNumbers.append(Int(years[i])!)
        }
        //get all years in between
        let yearDifference = yearsInNumbers[1] - yearsInNumbers[0]
        var yearsToGraph = [yearsInNumbers[0]]
        if yearDifference != 0{
            for i in 1..<yearDifference+1{
                yearsToGraph.append(yearsToGraph[0]+i)
            }
        }

        //print 1 day of the pollen fake data
        var pollenSourceDataSets = [[ChartDataEntry]]()
        for i in 0..<x{
            var yVal : [ChartDataEntry] = [ChartDataEntry]()
            
            for j in 0..<y[i].count{
                yVal.append(ChartDataEntry(x: Double(j+1), y: Double(y[i][j])))
            }
            
            //append to a dataset
            pollenSourceDataSets.append(yVal)
        }
        
        let data = LineChartData()
        for i in 0..<pollenSourceDataSets.count{
            let dataSet = LineChartDataSet(values: pollenSourceDataSets[i], label: labels[i])
            dataSet.setColor(colors[i])
            dataSet.setCircleColor(colors[i])
            data.addDataSet(dataSet)
        }
        lineChart.data = data
    }

    //MARK: Navigation
    //Function that gets called when we are back from edit view
    @IBAction func unwindToChart(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? EditViewController{
            pollenSourceSwitches = sourceViewController.pollenSourceSwitches
            
            //re-arrange the switches so they are correct for UI
            //switches are assigned to a tag according to order which is a problem
                //between the view controller & edit view controller. The edit view
                //has trees on the left and others on the right, but
                //the view controller goes in order (see arrays at top of files).
                //Thus I had to re-order them for the graph view (view controller).
            var ps = pollenSourceSwitches
            var psIndex = 0
            for i in 0..<pollenSourceSwitches.count{
                
                if(i<7){
                    pollenSourceSwitches[i] = ps[psIndex]
                    psIndex+=2
                }
                else if(i==7){
                    psIndex = 1
                    pollenSourceSwitches[i] = ps[psIndex]
                    psIndex+=2
                }
                else{
                    pollenSourceSwitches[i] = ps[psIndex]
                    psIndex+=2
                }
                
            }
            years = sourceViewController.chosenYears
        }
        changeChart(x: year.count, y: year, labels: names, colors: color);
    }
    
    

}

