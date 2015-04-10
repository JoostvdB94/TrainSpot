//
//  User.swift
//  TrainSpot
//
//  Created by Joost van den Brandt on 09/04/15.
//  Copyright (c) 2015 Joost van den Brandt. All rights reserved.
//

import Foundation
class User :Serializable{
    var _id :String = ""
    var username :String
    var password :String
    init(username:String,password:String){
        self.username = username;
        self.password = password;
    }
}