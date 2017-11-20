//
//  EditViewController.swift
//  fbxpollenfallen
//
//  Created by Laurin Fisher on 11/19/17.
//  Copyright © 2017 UAF. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var yearPicker: UIPickerView!
    @IBOutlet var switches: [UISwitch]!
    var pollenSources = ["Birch", "Spruce", "Poplar Aspen", "Willow", "Alder", "Other Tree", "Other Tree 2", "Weed", "Mold", "Grass", "Grass 2", "Other", "Other 2"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //draw switches and pollen source labels to the screen
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Populating Switches
    func populateSwitches(){
        
        //Make a new Switch
        let newSwitch = UISwitch(frame: CGRect(x: 8, y: 20, width: 0, height: 0))
        newSwitch.isOn = true
        newSwitch.setOn(true, animated: false)
        newSwitch.addTarget(self, action: Selector(("switchValueDidChange:")), for: UIControlEvents.valueChanged)

    }
    
    func switchValueDidChange(_ sender: UISwitch){
        
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
