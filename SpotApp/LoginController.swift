//
//  LoginController.swift
//  TrainSpot
//
//  Created by Joost van den Brandt on 09/04/15.
//  Copyright (c) 2015 Joost van den Brandt. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    var loggedIn:BooleanType = false;
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        if(defaults.stringForKey("userKey") != nil){
            loggedIn = true;
            dispatch_async(dispatch_get_main_queue(),{
                self.performSegueWithIdentifier("loginSegue", sender: UIButton())
            });
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonClick(sender: AnyObject) {
        let loginURL = "http://trainspot.herokuapp.com/login"
        if(usernameField.text != "" && passwordField.text != ""){
            var user = User(username: usernameField.text,password: passwordField.text)
            
            PostRequest.HTTPPostJSON(loginURL, jsonObj: user.toDictionary(), callback: {
                (data:AnyObject, error: String?) -> Void in
                if(error == nil){
                    var auth = data["authenticated"]! as! NSNumber
                    if (auth == 1){
                        var userData = data["user"] as! [String:AnyObject]
                        let defaults = NSUserDefaults.standardUserDefaults()
                        defaults.setValue(userData["_id"], forKey: "userKey")
                        dispatch_async(dispatch_get_main_queue(),{
                            self.performSegueWithIdentifier("loginSegue", sender: sender)
                        });
                        println(defaults.stringForKey("userKey"))
                    }else{
                        let alertController = UIAlertController(title: "Oh you hacker..", message:"Ongeldige inloggegevens", preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "Sorry!", style: .Default, handler: { (action: UIAlertAction!) in
                            
                        }))
                        dispatch_async(dispatch_get_main_queue(),{
                            self.presentViewController(alertController, animated: true, completion: nil)
                        });
                        
                    }
                }else{
                    println("Got an error logging in \(error)");
                }
                }
            )
        }

    }
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if(loggedIn){
            return true;
        }
        return false;
    }
}
