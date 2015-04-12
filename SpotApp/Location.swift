	//
//  Location.swift
//  TrainSpot
//
//  Created by User on 12/04/15.
//  Copyright (c) 2015 Joost van den Brandt. All rights reserved.
//

import Foundation
import CoreLocation
class Location:Serializable{
    var id : String
    var name : String
    var type : String
    var latitude : CLLocationDegrees
    var longitude : CLLocationDegrees
    var distance : Double
    
    init(newId : String, newName:String, newType : String, newLatitude : Double, newLongitude : Double)
    {
        self.id = newId
        self.name = newName
        self.type = newType
        self.latitude = CLLocationDegrees(newLatitude)
        self.longitude = CLLocationDegrees(newLongitude)
        self.distance = 0
    }
    
    func getLocation() -> CLLocation{
        return CLLocation(latitude: self.latitude, longitude: self.longitude)
    }
}
