//
//  SettingsViewController.swift
//  TrainSpot
//
//  Created by Joost van den Brandt on 13/03/15.
//  Copyright (c) 2015 Joost van den Brandt. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    @IBOutlet weak var distanceValueLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var distanceStepper: UIStepper!
    
    @IBAction func onValueChangedStepper(sender: UIStepper) {
        distanceValueLabel.text =  String(format:"%.0f",sender.value);
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(sender.value, forKey: "distanceSetting")
    }
    
    @IBAction func onTouchStepper(sender: UIStepper) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        let distanceSettingValue = defaults.doubleForKey("distanceSetting")
        distanceValueLabel.text =  String(format:"%.0f",distanceSettingValue);3
        distanceStepper.value = defaults.doubleForKey("distanceSetting")
        usernameLabel.text = defaults.stringForKey("username")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
