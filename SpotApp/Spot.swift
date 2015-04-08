//
//  Spot.swift
//  TrainSpot
//
//  Created by Joost van den Brandt on 08/04/15.
//  Copyright (c) 2015 Joost van den Brandt. All rights reserved.
//

import Foundation
class Spot {
    var name:NSString = "";
    var description:NSString = "";
    var latitude:Double = 0;
    var longitude:Double = 0;
    var image:Image;
    
    init(newName:NSString,newDescription:NSString,newLatitude:Double,newLongitude:Double,newImage:Image){
        self.name = newName;
        self.description = newDescription;
        self.latitude = newLatitude;
        self.longitude = newLongitude;
        self.image = newImage;
    }
}