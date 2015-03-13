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
    
    @IBOutlet weak var distanceStepper: UIStepper!
    
    @IBAction func onValueChangedStepper(sender: UIStepper) {
        distanceValueLabel.text =  String(format:"%.0f",sender.value);
    }
    
    @IBAction func onTouchStepper(sender: UIStepper) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        distanceValueLabel.text =  String(format:"%.0f",distanceStepper.value);

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
