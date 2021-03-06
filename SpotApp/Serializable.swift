//
//  Serializable.swift
//  TrainSpot
//
//  Created by Joost van den Brandt on 10/04/15.
//  Copyright (c) 2015 Joost van den Brandt. All rights reserved.
//

import Foundation
class Serializable : NSObject{
    
    func toDictionary() -> NSDictionary {
        var aClass : AnyClass? = self.dynamicType
        var propertiesCount : CUnsignedInt = 0
        let propertiesInAClass : UnsafeMutablePointer<objc_property_t> = class_copyPropertyList(aClass, &propertiesCount)
        var propertiesDictionary : NSMutableDictionary = NSMutableDictionary()
        
        for var i = 0; i < Int(propertiesCount); i++ {
            var property = propertiesInAClass[i]
            var propName = NSString(CString: property_getName(property), encoding: NSUTF8StringEncoding)!
            
            propName = propName as! String
            var propType = property_getAttributes(property)
            var propValue : AnyObject! = self.valueForKey(propName as! String);
            if propName == "_description" {
                propName = "description"
            }
            if propName == "_extension" {
                propName = "extension"
            }
            if propValue is Serializable {
                propertiesDictionary.setValue((propValue as! Serializable).toDictionary(), forKey: propName  as! String)
            } else if propValue is Array<Serializable> {
                var subArray = Array<NSDictionary>()
                for item in (propValue as! Array<Serializable>) {
                    subArray.append(item.toDictionary())
                }
                propertiesDictionary.setValue(subArray, forKey: propName  as! String)
            } else if propValue is NSData {
                propertiesDictionary.setValue((propValue as! NSData).base64EncodedStringWithOptions(nil), forKey: propName as! String)
            } else {
                propertiesDictionary.setValue("\(propValue)", forKey: propName as! String)
            }
        }
        
        // class_copyPropertyList retaints all the
        propertiesInAClass.dealloc(Int(propertiesCount))
        
        return propertiesDictionary
    }
}