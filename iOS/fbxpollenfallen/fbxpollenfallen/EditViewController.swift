//
//  EditViewController.swift
//  fbxpollenfallen
//
//  Created by Laurin Fisher on 11/19/17.
//  Copyright © 2017 UAF. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UIScrollViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var editView: UIView! //keep this, it crashes otherwise
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBAction func cancel(_ sender: UIBarButtonItem) { //if the cancel button is pushed, don't call the segue functions
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Variables
    var pollenSources = ["Birch","Weed", "Spruce","Mold", "Poplar Aspen","Grass", "Willow","Grass 2", "Alder","Other", "Other Tree","Other 2", "Other Tree 2"]
    var years = ["2016", "2015", "2014", "2013", "2012", "2011", "2010", "2009", "2008", "2007", "2006", "2005", "2004"]
    var spaces = 8
    
    //Segue Variables -- What a user changes in the edit view to be sent to last view
    //Store which switches/pollen sources are chosen for the graph
    var pollenSourceSwitches = [Bool]()
    //Store switches in array for changing upon loading later (saving user preferences)
    var allSwitches = [UISwitch]()
    //Store the years chosen
    var chosenYears = [String]()
    
    //Views
        //pickerView
    var yearPicker = UIPickerView()
    //View that greys out the rest of the screen (drawn on top) for picker view
    var greyView = UIView(frame: CGRect(x: 0, y:0, width: 0, height: 0))
    
    //make buttons accessible by picker
    var firstYearButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    var endYearButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    
    //keep track of which button was picked
    var buttonClicked = UIButton()
    
//    //for drawing
//    var screensize: CGRect = UIScreen.main.bounds
//    var screenWidth = UIScreen.main.bounds.width
//    var screenHeight = UIScreen.main.bounds.height
//
    //Deinitializer
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: Notification
    func setupNotification(){
        //Setup an Observer to know when device is rotated
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
  
    //MARK: ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup "Notifications" or Observers
        setupNotification()

        //Draw to the View
        drawLabelsAndSwitches(labels: pollenSources, spacing: spaces)
        
        //Allowing the scrollview to scroll
        scrollView.isScrollEnabled = true
        
        //Upon start have picker hidden
        yearPicker.isHidden = true
        greyView.isHidden = true
    }
    
    //MARK: Draw to the Screen
    private func drawLabelsAndSwitches(labels: [String], spacing: Int){
        let screensize = UIScreen.main.bounds
        let screenWidth = screensize.width
        let screenHeight = screensize.height
        
        //Draw label
        let pollenSourceLabel =  UILabel(frame: CGRect(x: 0 , y: spacing, width: 0, height: 0))
        pollenSourceLabel.text = "Pollen Sources (X Axis)"
        pollenSourceLabel.sizeToFit()
        pollenSourceLabel.frame.origin = CGPoint(x: Int(ceil((screenWidth - pollenSourceLabel.bounds.width)/2)), y: spacing)
        scrollView.addSubview(pollenSourceLabel)
        var ySpacing = 0
        
        //find largest label to determine how many can fit on screen
        if let max = labels.max(by: {$1.count > $0.count}) {
            //Find the size of a UISwitch
            let mySwitch = UISwitch()
            let SwitchWidth = Int(ceil(mySwitch.frame.size.width))
            let SwitchHeight = Int(ceil(mySwitch.frame.size.height))

            //Calculate the size of the biggest text label
            let newLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            newLabel.text = max
            newLabel.sizeToFit()
            let maxWidth = Int(ceil(newLabel.bounds.size.width))
            
            //calculate width of the horizontal stack of longest
            let longestWidth = maxWidth + spacing + SwitchWidth
 
            //get biggest usable width in view
            let viewWidth = self.view.frame.size.width - CGFloat(spacing*4)
            
            //how many of the longest item can we use across the screen
            let itemsAvailablePerViewWidth = Int(viewWidth)/longestWidth

            //Spacing between columns
            let inBetweenSpacing = (viewWidth - CGFloat((longestWidth * itemsAvailablePerViewWidth))) / (CGFloat(itemsAvailablePerViewWidth))
            

            //Draw the labels & switches
            let remainder = (pollenSources.count % itemsAvailablePerViewWidth)
            var itemRows = (pollenSources.count / itemsAvailablePerViewWidth)
            if remainder != 0 {
                itemRows+=1
            }
            var index = 0
            ySpacing = SwitchHeight/2 + (2*spacing) + Int(ceil(pollenSourceLabel.bounds.height))
            //Draw all rows
            for _ in 0..<itemRows {
               
                var xSpacing = spacing
                
                //each row
                for _ in 0..<itemsAvailablePerViewWidth{
                    
                    if index != pollenSources.count{
                        //Draw pollen source text
                        let Label = UILabel(frame: CGRect(x: xSpacing, y: ySpacing, width: 0, height: 0))
                        Label.text = pollenSources[index]
                        Label.sizeToFit()
                        scrollView.addSubview(Label)
                        
                        //draw corresponding switch
                        let Switch = UISwitch(frame: CGRect(x: (xSpacing  + longestWidth - SwitchWidth), y: ySpacing - (SwitchHeight/2), width: 0, height: 0))
                        Switch.tag = index
                        Switch.isOn = pollenSourceSwitches[index]
                        Switch.addTarget(self, action: #selector(switchChanged), for: UIControlEvents.valueChanged)
                        allSwitches.append(Switch)
                        scrollView.addSubview(Switch)
                        
                        //Spacing between columns
                        if inBetweenSpacing > 0 {
                            xSpacing+=spacing + longestWidth + Int(inBetweenSpacing)
                        }
                        else{
                            xSpacing+=spacing + longestWidth
                        }
                        index += 1
                    }

                }
                ySpacing+=spacing + 50
            }
            
            //Now draw the year picker (from _ to _)
            //Draw Year label
            let yearLabel =  UILabel(frame: CGRect(x: 0 , y: ySpacing, width: 0, height: 0))
            yearLabel.text = "Year(s)"
            yearLabel.sizeToFit()
            let yearLabelXCenter = Int(ceil((screenWidth - yearLabel.bounds.width)/2))
            yearLabel.frame.origin = CGPoint(x: yearLabelXCenter, y: ySpacing)
            scrollView.addSubview(yearLabel)
            
            ySpacing+=spacing + Int(ceil(yearLabel.bounds.height))
            
            //draw buttons that open up a picker view
            firstYearButton.backgroundColor = UIColor.lightGray
            //firstYearButton.setTitle(chosenYears[0], for: .normal)
            firstYearButton.setTitleColor(.black, for: .normal)
            firstYearButton.layer.borderWidth = 2 
            firstYearButton.layer.borderColor = UIColor.black.cgColor
            firstYearButton.sizeToFit()
            firstYearButton.frame.origin = CGPoint(x: yearLabelXCenter - Int(ceil(firstYearButton.bounds.width)), y: ySpacing)
            firstYearButton.addTarget(self, action: #selector(yearButtonPressed(sender:)), for: .touchDown)
            firstYearButton.addTarget(self, action: #selector(yearButtonReleased(sender:)), for: .touchUpInside)
            firstYearButton.addTarget(self, action: #selector(yearButtonReleased(sender:)), for: .touchUpOutside)
            
            firstYearButton.layer.cornerRadius = 4
            scrollView.addSubview(firstYearButton)
            
            var xSpacing = yearLabelXCenter + spacing
            
            //draw label between buttons
            let toLabel = UILabel(frame: CGRect(x: xSpacing, y: ySpacing + Int(ceil(firstYearButton.bounds.height)), width: 100, height: 100))
            toLabel.text = " To "
            toLabel.sizeToFit()
            toLabel.frame.origin = CGPoint(x: xSpacing, y: ySpacing + Int(ceil(firstYearButton.bounds.height - toLabel.bounds.height)))
            scrollView.addSubview(toLabel)
            
            xSpacing += Int(ceil(toLabel.bounds.width)) + spacing
            
            //ending year button
            endYearButton.backgroundColor = UIColor.lightGray
          //  endYearButton.setTitle(chosenYears[1], for: .normal)
            endYearButton.setTitleColor(.black, for: .normal)
            endYearButton.layer.borderWidth = 2
            endYearButton.layer.borderColor = UIColor.black.cgColor
            endYearButton.sizeToFit()
            endYearButton.frame.origin = CGPoint(x: xSpacing, y: ySpacing)
            endYearButton.addTarget(self, action: #selector(yearButtonPressed(sender:)), for: .touchDown)
            endYearButton.addTarget(self, action: #selector(yearButtonReleased(sender:)), for: .touchUpInside)
            endYearButton.addTarget(self, action: #selector(yearButtonReleased(sender:)), for: .touchUpOutside)
            
            endYearButton.layer.cornerRadius = 4
            scrollView.addSubview(endYearButton)
            scrollView.sizeToFit()
            scrollView.contentSize = CGSize(width: screenWidth, height: CGFloat(ySpacing + 50))
        }
        
        //picker view was up and is not hidden upon rotation -> hide it, re-draw, unhide
        var greyViewWasHidden = true
        if greyView.isHidden == false{
            //not hidden, hide it for redraw
            greyView.isHidden = true
            greyViewWasHidden = false
            yearPicker.isHidden = true
        }

        //View that greys out the rest of the screen (drawn on top) for picker view
        greyView = UIView(frame: CGRect(x: 0, y:0, width: Int(screenWidth), height: Int(scrollView.contentSize.height) + Int(screenHeight)))
        greyView.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        greyView.isOpaque = false
        greyView.isHidden = true
        greyView.tag = 334
        scrollView.addSubview(greyView)
        
        //pickerView
        yearPicker = UIPickerView(frame: CGRect(x: screenWidth/2, y: screenHeight/2, width: 0, height: 0))
        yearPicker.sizeToFit()
        yearPicker.delegate = self
        yearPicker.isHidden = true //hide picker view, only want to see it when button is pressed
        yearPicker.backgroundColor = UIColor.white
        yearPicker.isOpaque = true
        yearPicker.tag = 333
        //draw yearpicker halfway in screen (x), but over buttons (y)
        yearPicker.frame.origin = CGPoint(x: screenWidth/2 - yearPicker.bounds.width/2, y: (CGFloat(ySpacing) + endYearButton.bounds.height) - yearPicker.bounds.height)
        greyView.addSubview(yearPicker)
        
        if !greyViewWasHidden {
            greyView.isHidden = false
            yearPicker.isHidden = false
        }

        scrollView.bringSubview(toFront: greyView)
    }
    
    //MARk: Button "animation" changes so user can see it is a button
    //when pressed down
    @objc private func yearButtonPressed(sender: UIButton!){
        sender.backgroundColor = UIColor.darkGray
        sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        
        //save which button was clicked
        buttonClicked = sender
        
        //show picker view
        greyView.isHidden = false
        yearPicker.isHidden = false
        
    }
    
    //when button is released
    @objc private func yearButtonReleased(sender: UIButton!){
        sender.backgroundColor = UIColor.lightGray
        sender.transform = CGAffineTransform(scaleX: 1, y: 1)
    }
    
    //MARK: Orientation Changes
    //Called when device is rotated, redraw based on new window width
    @objc func rotated(){
        //remove old uiviews & clear the scrollview
        let subViews = scrollView.subviews
        for subview in subViews{
            
            //Don't remove greyview screen or picker
            if subview.tag < 330{
                subview.removeFromSuperview()
            }
            
        }
        
        //also clear switch array
        allSwitches.removeAll()
        
        //redraw content
        drawLabelsAndSwitches(labels: pollenSources, spacing: spaces)
    }
    
    //MARK: UIPicker Required functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return years.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return years[row] as String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //Get value chosen in picker here
        buttonClicked.setTitle(years[row], for: .normal)
        yearPicker.isHidden = true
        greyView.isHidden = true
    }

    //MARK: User is Changing Values
    @objc func switchChanged(theSwitch: UISwitch){
        pollenSourceSwitches[theSwitch.tag] = theSwitch.isOn
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveButton else{
            return //save button was not pressed, cancel
        }
        
        //save info to pass in a variable
            //Make sure text of button is not nil (shouldn't be because it has default values)
        if let text = firstYearButton.titleLabel?.text {
            let trimmed = text.trimmingCharacters(in: .whitespaces)
            chosenYears.append(trimmed)
        }
        if let text = endYearButton.titleLabel?.text {
            let trimmed = text.trimmingCharacters(in: .whitespaces)
            chosenYears.append(trimmed)
        }
        
        //pollenSourceSwitches is already made
        
    }
}

