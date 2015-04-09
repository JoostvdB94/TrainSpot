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
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
        let loginURL = "http://trainspot.herokuapp.com/login"
        var user = User(username: usernameField.text,password: passwordField.text)
        
        PostRequest.HTTPPostJSON(loginURL, jsonObj: user, callback: {
            (data:AnyObject, error: String?) -> Void in
            if(error != nil){
                if (data["athenticated"]! === "true"){
                    println("Juiste login")
                }else{
                    println("Onjuiste login")
                }
            }else{
                println(error);
            }
            }
        )
        
        return false;
    }
    
}
