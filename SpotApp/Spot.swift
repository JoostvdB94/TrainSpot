//
//  Spot.swift
//  TrainSpot
//
//  Created by Joost van den Brandt on 08/04/15.
//  Copyright (c) 2015 Joost van den Brandt. All rights reserved.
//

import Foundation
import CoreLocation
class Spot : Serializable {
    var name:NSString = "";
    var _description:NSString = "";
    var latitude:CLLocationDegrees = 0;
    var longitude:CLLocationDegrees = 0;
    var creationDate : Int64
    var image:Image;
    
    init(newName:NSString,newDescription:NSString,newLatitude:CLLocationDegrees,newLongitude:CLLocationDegrees,newImage:Image){
        self.name = newName;
        self._description = newDescription;
        self.latitude = newLatitude;
        self.longitude = newLongitude;
        self.image = newImage;
        self.creationDate = Int64(NSDate().timeIntervalSince1970 * 1000)
    }
}