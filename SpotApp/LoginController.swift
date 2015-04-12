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
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        if(defaults.stringForKey("userKey") != nil){
            var loginUser = User(username: defaults.stringForKey("username")!,password: defaults.stringForKey("password")!)
            self.loginWithUser(loginUser)
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginWithUser(user:User){
        let loginURL = "http://trainspot.herokuapp.com/login"
        
        var alert: UIAlertView = UIAlertView(title: "Login", message: "Bezig met inloggen...", delegate: nil, cancelButtonTitle: nil);
        
        var loadingIndicator : UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(50, 0, 37, 28)) as UIActivityIndicatorView
        loadingIndicator.center = self.view.center;
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        loadingIndicator.startAnimating();
        
        alert.setValue(loadingIndicator, forKey: "accessoryView")
        loadingIndicator.startAnimating()
        
        alert.show()
        
        PostRequest.HTTPPostJSON(loginURL, jsonObj: user.toDictionary(), callback: {
            (data:AnyObject, error: String?) -> Void in
            if(error == nil){
                var auth = data["authenticated"]! as! NSNumber
                if (auth == 1){
                    var userData = data["user"] as! [String:AnyObject]
                    let defaults = NSUserDefaults.standardUserDefaults()
                    var localData = userData["local"] as! [String:AnyObject]
                    defaults.setValue(userData["_id"], forKey: "userKey")
                    defaults.setValue(user.username, forKey: "username")
                    defaults.setValue(user.password, forKey: "password")
                    dispatch_async(dispatch_get_main_queue(),{
                        self.performSegueWithIdentifier("loginSegue", sender: UIButton())
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
                alert.dismissWithClickedButtonIndex(0, animated: true)
            }else{
                println("Got an error logging in \(error)");
            }
            }
        )
    }
    
    @IBAction func loginButtonClick(sender: AnyObject) {
        if(usernameField.text != "" && passwordField.text != ""){
            var user = User(username: usernameField.text,password: passwordField.text)
            self.loginWithUser(user)
        }
    }
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        let defaults = NSUserDefaults.standardUserDefaults()
        if(defaults.stringForKey("userKey") != nil){
            return true;
        }
        return false;
    }
}
