//
//  Location.swift
//  TrainSpot
//
//  Created by User on 12/04/15.
//  Copyright (c) 2015 Joost van den Brandt. All rights reserved.
//

import Foundation
class Location:Serializable{
    var id : String
    var name : String
    var type : String
    var latitude : Double
    var longitude : Double
    var distance : Double
    
    init(newId : String, newName:String, newType : String, newLatitude : Double, newLongitude : Double)
    {
        self.id = newId
        self.name = newName
        self.type = newType
        self.latitude = newLatitude
        self.longitude = newLongitude
        self.distance = 0
    }
}
