//
//  EditViewController.swift
//  fbxpollenfallen
//
//  Created by Laurin Fisher on 11/19/17.
//  Copyright © 2017 UAF. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var switches: [UISwitch]!
    @IBOutlet var editView: UIView!
    var pollenSources = ["Birch", "Spruce", "Poplar Aspen", "Willow", "Alder", "Other Tree", "Other Tree 2", "Weed", "Mold", "Grass", "Grass 2", "Other", "Other 2"]
    var years = ["2017", "2016", "2015", "2014", "2013"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
     
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
