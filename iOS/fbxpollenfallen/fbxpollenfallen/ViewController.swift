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
    var pollenSources = 13
    var pollenSourceSwitches = [Bool]()
    var years = ["2016", "2016"]
    
    //The corresponding arrays are for 1 year of data, with labels & colors for each
        //pollen source
    let names = ["Birch", "Spruce", "Poplar Aspen", "Willow", "Alder", "Other Tree", "Other Tree 2", "Weed", "Mold", "Grass", "Grass 2", "Other 1", "Other 2"]
    //swift has UIColor from 0.0-1.0, so I had to divide by 255 for RGB
    let color = [UIColor(displayP3Red: 34.0/255, green: 102.0/255, blue: 102.0/255, alpha: 1.0),UIColor(displayP3Red: 170.0/255, green: 108.0/255, blue: 57.0/255, alpha: 1.0),UIColor(displayP3Red: 198.0/255, green: 92.0/255, blue: 0.0, alpha: 1.0),UIColor(displayP3Red: 114.0/255, green: 125.0/255, blue: 21.0/255, alpha: 1.0), UIColor.green, UIColor(displayP3Red: 118.0/255, green: 39.0/255, blue: 108.0/255, alpha: 1.0), UIColor(displayP3Red: 170.0/255, green: 57.0/255, blue: 57.0/255, alpha: 1.0), UIColor(displayP3Red: 198.0/255, green: 148.0/255, blue: 0.0/255, alpha: 1.0), UIColor(displayP3Red: 154.0/255, green: 3.0/255, blue: 88.0/255, alpha: 1.0), UIColor(displayP3Red: 11.0/255, green: 166.0/255, blue: 104.0/255, alpha: 1.0), UIColor(displayP3Red: 10.0/255, green: 14.0/255, blue: 180.0/255, alpha: 1.0), UIColor(displayP3Red: 76.0/255, green: 45.0/255, blue: 115.0/255, alpha: 1.0),UIColor(displayP3Red: 42.0/255, green: 79.0/255, blue: 110.0/255, alpha: 1.0)]
   
    
    //MARK: Notification
    func setupNotification(){
        //Setup an Observer to know when device is rotated
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    //Deinitializer for notification
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
 
    //Draw the y Axis Vertical label
    var yAxislabel = UILabel()
    
    func drawYAxisLabel(){
        //For label viewing purposes
        let screen = UIScreen.main.bounds
        
        //Create y_axis label
        yAxislabel = UILabel(frame: CGRect(x: yAxisView.bounds.width/4, y: screen.size.height/2, width: 100, height: 100))
        yAxislabel.text = "Grains Per Cubic Meter of Air (p/m2)"
        yAxislabel.sizeToFit()
        //Rotate the label -90 deg
        yAxislabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
        //Make the new boundaries for the label to be visible in the view
        yAxislabel.frame = CGRect(x: yAxisView.bounds.width/8, y: yAxisView.bounds.height/2 - yAxislabel.frame.height/2, width: 20, height: yAxisView.bounds.height/2)
        yAxislabel.sizeToFit()
        
        yAxisView.addSubview(yAxislabel) //add the new label to the view
    }
    
    //ViewDidLoad() Initial loading/drawing 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup "Notifications" or Observers
        setupNotification()

        //Draw Label Y Axis
        drawYAxisLabel()
        
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

        //Sort the years so that the oldest year is first Ex: 2015, 2016 not 2016, 2015
        years.sort()
        //convert year string to int
        var yearsInNumbers = [Int]()
        for i in 0..<years.count{
            yearsInNumbers.append(Int(years[i])!)
        }
        
        //Get initial data from the server
        getServerData(years: yearsInNumbers)

        //have horizontal stack view w/ chart & y_axis label fill screen
        lineChartVerticalStackView.distribution = .fill
    }
    
    //MARK: Orientation Changes
    //Called when device is rotated, redraw based on new window width
    @objc func rotated(){
        //remove label
        let subviews = yAxisView.subviews
        for subview in subviews{
            subview.removeFromSuperview()
        }
        //redraw at new position
        drawYAxisLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
/* The Result enum, closure, and httpGet() are all inspired from:
    https://medium.com/@sdrzn/networking-and-persistence-with-json-in-swift-4-c400ecab402d
 */
    enum Result<Value>{
        case success(Value)
        case failure(Error)
    }
    var graphData = [pollenJSON]()
    
    func getServerData(years: [Int]){
        
        var yearKeys = years
        
        //If it's the same year, then delete one of the entries when doing a GET request
        //  to avoid getting the same information twice.
        if years[0] == years[1] {
            yearKeys.removeLast()
        }
        
        //closure
        httpGET(for : yearKeys){ (result) in
            switch result {
            case .success(let data):
                self.graphData = data
                
                //sort the data by day, month, & year
                for i in 0..<self.graphData.count{
                   self.graphData[i].Data = self.graphData[i].Data.sorted(by: {
                        if $0.Month < $1.Month { //sort on month if not equal
                            return true
                        }
                        else if $0.Month == $1.Month { //IF they are the same month, sort based on day
                            return $0.Day < $1.Day
                        }
                        else{
                            return false;
                        }
                    })
                }

                //Data pulling was a success, graph the data
                self.changeChart(x: self.graphData.count, y: self.graphData, labels: self.names, colors: self.color, yearsInNumbers: years);
                
            case .failure(let error):
                //Could not get data from network, tell user via graph
                print("Failure to grab data. Disconnected from the network? : " + String(describing: error))
            }
        }
    }
    
    //An HTTP GET request to our server
    func httpGET(for givenYears: [Int], completion: ((Result<[pollenJSON]>) -> Void)?) {
        
        //Host url path
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "fbxpollenfallen.com"
        urlComponents.path = "/pollen"

        //find the json data based on these values
        var itemArr = [URLQueryItem]()
        let givenYearsSorted = givenYears.sorted()
        
        //Server takes a GET request with from: year= to: year=
        let item = URLQueryItem(name: "year", value: "\(givenYearsSorted[0])")
        itemArr.append(item)
        
        //multiple years
        if givenYearsSorted.count > 1{
            let item2 = URLQueryItem(name: "year", value: "\(givenYearsSorted[1])")
            itemArr.append(item2)
        }
        
        urlComponents.queryItems = itemArr
        guard let url = urlComponents.url else {
            fatalError("Could not create URL from request")
        }

        //the actual GET request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        //configure a session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        //Get the data, response, and errors from the server
        let task = session.dataTask(with: request){ (responseData, response, responseError) in
            DispatchQueue.main.async {

                guard responseError == nil else{
                    completion?(.failure(responseError!))
                   return
                }

                guard let jsonData = responseData else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrived"]) as Error
                    completion?(.failure(error))
                   return
                }

                let decoder = JSONDecoder()

                do {
                    //decode the JSON to our swift structs
                    let pollenData = try decoder.decode([pollenJSON].self, from:  jsonData)
                    completion?(.success(pollenData))
                } catch {
                    completion?(.failure(error))
                }
            }
            
        }
        task.resume() //grab the data until complete
    }
    
     //MARK: Chart functions
    //called when user re-opens graph scene from edit screen due to segues
    func changeChart(x: Int, y: [pollenJSON], labels: [String], colors: [UIColor], yearsInNumbers: [Int]){
        lineChart.clear()
        
        //only add values to the chart that the user wants
        var labelArr = [String]()
        var colorArr = [UIColor]()

        for i in 0..<pollenSourceSwitches.count{
            if(pollenSourceSwitches[i]){
                //only add the needed labels & colors
                labelArr.append(labels[i])
                colorArr.append(colors[i])
            }
        }
        
        //Update the Chart
        makeChart(x: y.count, y: y, labels: labelArr, colors: colorArr, yearsInNumbers: yearsInNumbers)
    }
    
    //Draws the chart from the given data
    func makeChart(x: Int, y: [pollenJSON], labels: [String], colors: [UIColor], yearsInNumbers: [Int]){
        
        //get all years in between
        let yearDifference = yearsInNumbers[1] - yearsInNumbers[0]
        var yearsToGraph = [yearsInNumbers[0]]
        if yearDifference != 0{
            for i in 1..<yearDifference+1{
                yearsToGraph.append(yearsToGraph[0]+i)
            }
        }
        
        //We are graphing multiple years, graph the totals
        if yearsToGraph.count > 1 {
            
            //Check to see if there is any data to graph (if all switches are off)
            var falseCount = 0
            for p in pollenSourceSwitches {
                if p {
                    break; //there is at least one value to graph
                }
                else{
                    falseCount+=1
                }
            }
            
            if falseCount == pollenSourceSwitches.count {
                //no data to graph
                return
            }
            
            //graphing multiple years, total all the values we want together
            var xAxisMonths = [String]()
            let data = LineChartData()
            //per year
            for i in 0..<yearsToGraph.count{
                var yVal : [ChartDataEntry] = [ChartDataEntry]()
                xAxisMonths = [String]()
                //per day in year that data was taken
                for j in 0..<y[i].Data.count{
                    xAxisMonths.append(String(y[i].Data[j].Month) + "/" + String(y[i].Data[j].Day))
                    
                    if pollenSourceSwitches[0] {
                        yVal.append(ChartDataEntry(x: Double(j+1), y: Double(y[i].Data[j].Birch)))
                    }
                    if pollenSourceSwitches[1]{
                        yVal.append(ChartDataEntry(x: Double(j+1), y: Double(y[i].Data[j].Spruce)))
                    }
                    if pollenSourceSwitches[2]{
                        yVal.append(ChartDataEntry(x: Double(j+1), y: Double(y[i].Data[j].Poplar_Aspen)))
                    }
                    if pollenSourceSwitches[3]{
                        yVal.append(ChartDataEntry(x: Double(j+1), y: Double(y[i].Data[j].Willow)))
                    }
                    if pollenSourceSwitches[4]{
                        yVal.append(ChartDataEntry(x: Double(j+1), y: Double(y[i].Data[j].Alder)))
                    }
                    if pollenSourceSwitches[5]{
                        yVal.append(ChartDataEntry(x: Double(j+1), y: Double(y[i].Data[j].Other1_Tree)))
                    }
                    if pollenSourceSwitches[6]{
                        yVal.append(ChartDataEntry(x: Double(j+1), y: Double(y[i].Data[j].Other2_Tree)))
                    }
                    if pollenSourceSwitches[7]{
                        yVal.append(ChartDataEntry(x: Double(j+1), y: Double(y[i].Data[j].Weed)))
                    }
                    if pollenSourceSwitches[8]{
                        yVal.append(ChartDataEntry(x: Double(j+1), y: Double(y[i].Data[j].Mold)))
                    }
                    if pollenSourceSwitches[9]{
                        yVal.append(ChartDataEntry(x: Double(j+1), y: Double(y[i].Data[j].Grass)))
                    }
                    if pollenSourceSwitches[10]{
                        yVal.append(ChartDataEntry(x: Double(j+1), y: Double(y[i].Data[j].Grass2)))
                    }
                    if pollenSourceSwitches[11]{
                        yVal.append(ChartDataEntry(x: Double(j+1), y: Double(y[i].Data[j].Other1)))
                    }
                    if pollenSourceSwitches[12]{
                        yVal.append(ChartDataEntry(x: Double(j+1), y: Double(y[i].Data[j].Other2)))
                    }
                }
                
                //make the year's data set
                let yearDataSet = LineChartDataSet(values: yVal, label: String(yearsToGraph[i]))
                yearDataSet.setColor(color[i])
                yearDataSet.setCircleColor(color[i])
                //add the year's data to our data
                data.addDataSet(yearDataSet)
            }
            
            //Give our xAxis labels & our graph the new data
            lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: xAxisMonths)
            lineChart.xAxis.granularity = 1
            lineChart.data = data
        }
        //Only graphing 1 year's data -> graph each pollen source
        else {
            //make the y values for each pollen source & store them to be added to the dataset later
            var pollenSourceDataSets = [[[ChartDataEntry]]]()
            var birchDataSet = [[ChartDataEntry]]()
            var spruceDataSet = [[ChartDataEntry]]()
            var poplarAspenDataSet = [[ChartDataEntry]]()
            var willowDataSet = [[ChartDataEntry]]()
            var alderDataSet = [[ChartDataEntry]]()
            var otherTree1DataSet = [[ChartDataEntry]]()
            var otherTree2DataSet = [[ChartDataEntry]]()
            var weedDataSet = [[ChartDataEntry]]()
            var moldDataSet = [[ChartDataEntry]]()
            var grassDataSet = [[ChartDataEntry]]()
            var grass2DataSet = [[ChartDataEntry]]()
            var other1DataSet = [[ChartDataEntry]]()
            var other2DataSet = [[ChartDataEntry]]()
            
            var xAxisMonths = [String]()
            for i in 0..<yearsToGraph.count{
                var birchVal : [ChartDataEntry] = [ChartDataEntry]()
                var spruceVal : [ChartDataEntry] = [ChartDataEntry]()
                var poplarAspenVal : [ChartDataEntry] = [ChartDataEntry]()
                var willowVal : [ChartDataEntry] = [ChartDataEntry]()
                var alderVal : [ChartDataEntry] = [ChartDataEntry]()
                var otherTree1Val : [ChartDataEntry] = [ChartDataEntry]()
                var otherTree2Val : [ChartDataEntry] = [ChartDataEntry]()
                var weedVal : [ChartDataEntry] = [ChartDataEntry]()
                var moldVal : [ChartDataEntry] = [ChartDataEntry]()
                var grassVal : [ChartDataEntry] = [ChartDataEntry]()
                var grass2Val : [ChartDataEntry] = [ChartDataEntry]()
                var other1Val : [ChartDataEntry] = [ChartDataEntry]()
                var other2Val : [ChartDataEntry] = [ChartDataEntry]()
                
                for j in 0..<y[i].Data.count{
                    //only graphing 1 year, seperate out the values
                    xAxisMonths.append(String(y[i].Data[j].Month) + "/" + String(y[i].Data[j].Day))
                    
                    birchVal.append(ChartDataEntry(x: Double(j+1), y: Double(y[i].Data[j].Birch)))
                    spruceVal.append(ChartDataEntry(x: Double(j+1), y: Double(y[i].Data[j].Spruce)))
                    poplarAspenVal.append(ChartDataEntry(x: Double(j+1), y: Double(y[i].Data[j].Poplar_Aspen)))
                    willowVal.append(ChartDataEntry(x: Double(j+1), y: Double(y[i].Data[j].Willow)))
                    alderVal.append(ChartDataEntry(x: Double(j+1), y: Double(y[i].Data[j].Alder)))
                    otherTree1Val.append(ChartDataEntry(x: Double(j+1), y: Double(y[i].Data[j].Other1_Tree)))
                    otherTree2Val.append(ChartDataEntry(x: Double(j+1), y: Double(y[i].Data[j].Other2_Tree)))
                    weedVal.append(ChartDataEntry(x: Double(j+1), y: Double(y[i].Data[j].Weed)))
                    moldVal.append(ChartDataEntry(x: Double(j+1), y: Double(y[i].Data[j].Mold)))
                    grassVal.append(ChartDataEntry(x: Double(j+1), y: Double(y[i].Data[j].Grass)))
                    grass2Val.append(ChartDataEntry(x: Double(j+1), y: Double(y[i].Data[j].Grass2)))
                    other1Val.append(ChartDataEntry(x: Double(j+1), y: Double(y[i].Data[j].Other1)))
                    other2Val.append(ChartDataEntry(x: Double(j+1), y: Double(y[i].Data[j].Other2)))
                    
                }
                
                //append to a dataset (totaling all the data for each pollen source for the year)
                birchDataSet.append(birchVal)
                spruceDataSet.append(spruceVal)
                poplarAspenDataSet.append(poplarAspenVal)
                willowDataSet.append(willowVal)
                alderDataSet.append(alderVal)
                otherTree1DataSet.append(otherTree1Val)
                otherTree2DataSet.append(otherTree2Val)
                weedDataSet.append(weedVal)
                moldDataSet.append(moldVal)
                grassDataSet.append(grassVal)
                grass2DataSet.append(grass2Val)
                other1DataSet.append(other1Val)
                other2DataSet.append(other2Val)
                
                pollenSourceDataSets.append(birchDataSet)
                pollenSourceDataSets.append(spruceDataSet)
                pollenSourceDataSets.append(poplarAspenDataSet)
                pollenSourceDataSets.append(willowDataSet)
                pollenSourceDataSets.append(alderDataSet)
                pollenSourceDataSets.append(otherTree1DataSet)
                pollenSourceDataSets.append(otherTree2DataSet)
                pollenSourceDataSets.append(weedDataSet)
                pollenSourceDataSets.append(moldDataSet)
                pollenSourceDataSets.append(grassDataSet)
                pollenSourceDataSets.append(grass2DataSet)
                pollenSourceDataSets.append(other1DataSet)
                pollenSourceDataSets.append(other2DataSet)
            }
            
            //set the colors and add the dataset to the chart
            let data = LineChartData()
            //loop through arrays, birch, spruce, etc
            var labelIndex = 0
            for i in 0..<pollenSourceDataSets.count{
                //loop through the values in those arrays, birch = [0, 1, ...]
                if pollenSourceSwitches[i] {
                    for j in 0..<pollenSourceDataSets[i].count {
                        let dataSet = LineChartDataSet(values: pollenSourceDataSets[i][j], label: labels[labelIndex])
                        dataSet.setColor(colors[labelIndex])
                        dataSet.setCircleColor(colors[labelIndex])
                        data.addDataSet(dataSet)
                    }
                    labelIndex+=1
                }
                
            }
            //make our new lineChart
            lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: xAxisMonths)
            lineChart.xAxis.granularity = 1
            lineChart.data = data
        }
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
        
        //Sort the years so that the oldest year is first Ex: 2015, 2016 not 2016, 2015
        years.sort()
        //convert year string to int
        var yearsInNumbers = [Int]()
        for i in 0..<years.count{
            yearsInNumbers.append(Int(years[i])!)
        }
        //Get new data for our graph & draw the new graph
        getServerData(years: yearsInNumbers)
    }
    
    //When transitioning to edit view, we want the edit view to display what parts of the graph are active
    @IBAction override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender) //always call the super when overriding a function
        
        //Our navigation controller is between this view controller and our next one
        let destNC = segue.destination as! UINavigationController

        if let nextViewController = destNC.topViewController as? EditViewController{
            nextViewController.pollenSourceSwitches = pollenSourceSwitches
            
            //change display of switches based on current graph data
            var index = 0
            for i in 0..<pollenSourceSwitches.count{
                if i%2==0{
                    //even is i/2
                    nextViewController.pollenSourceSwitches[i] = pollenSourceSwitches[i/2]
                }
                else{
                    //odd last +1
                    if(index<7){
                        index = 7
                        nextViewController.pollenSourceSwitches[i] = pollenSourceSwitches[index]
                        index+=1
                    }
                    else{
                        nextViewController.pollenSourceSwitches[i] = pollenSourceSwitches[index]
                        index+=1
                    }
                }
            }
        
            //change what years display on the buttons
            nextViewController.firstYearButton.setTitle(years[0], for: .normal)
            nextViewController.endYearButton.setTitle(years[1], for: .normal)
        }
    }

}

