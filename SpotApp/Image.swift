//
//  Image.swift
//  TrainSpot
//
//  Created by Joost van den Brandt on 08/04/15.
//  Copyright (c) 2015 Joost van den Brandt. All rights reserved.
//

import Foundation

class Image{
    var data : NSString = "";
    var fileExtension : NSString = "";
    
    init(newData:NSString,newFileExtension:NSString){
        self.data = newData;
        self.fileExtension = newFileExtension;
    }
}