//
//  MenuViewController.swift
//  SpotApp
//
//  Created by Joost van den Brandt on 13/03/15.
//  Copyright (c) 2015 Joost van den Brandt. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController,UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self;
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if var vc = viewController as? LoginController{
            GetRequest.HTTPGet("http://trainspot.herokuapp.com/logout", callback: { (data: String, error: String?) -> Void in
                defaults.removeObjectForKey("userKey");
                defaults.removeObjectForKey("username");
                defaults.removeObjectForKey("password");
                let alertController = UIAlertController(title: "Uitgelogd", message:"U bent succesvol uitgelogd", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Oke", style: .Default, handler: { (action: UIAlertAction!) in
                    
                }))
                dispatch_async(dispatch_get_main_queue(),{
                    viewController.presentViewController(alertController, animated: true, completion: nil)
                });
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
