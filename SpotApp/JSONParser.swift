//
//  JSONParser.swift
//  TrainSpot
//
//  Created by Joost van den Brandt on 08/04/15.
//  Copyright (c) 2015 Joost van den Brandt. All rights reserved.
//

import Foundation
struct JSONParser{
    static func JSONParseDict(jsonString:String) -> Dictionary<String, AnyObject> {
        var e: NSError?
        var data: NSData = jsonString.dataUsingEncoding(
            NSUTF8StringEncoding)!
        var jsonObj = NSJSONSerialization.JSONObjectWithData(
            data,
            options: NSJSONReadingOptions(0),
            error: &e) as Dictionary<String, AnyObject>
        if (e != nil) {
            return Dictionary<String, AnyObject>()
        } else {
            return jsonObj
        }
    }
    
    static func JSONStringify(value: AnyObject, prettyPrinted: Bool = false) -> String {
        var options = prettyPrinted ? NSJSONWritingOptions.PrettyPrinted : nil
        if NSJSONSerialization.isValidJSONObject(value) {
            if let data = NSJSONSerialization.dataWithJSONObject(value, options: options, error: nil) {
                if let string = NSString(data: data, encoding: NSUTF8StringEncoding) {
                    return string
                }
            }
        }
        return ""
    }
    
    
    static func JSONParseArray(jsonString: String) -> [AnyObject] {
        if let data = jsonString.dataUsingEncoding(NSUTF8StringEncoding) {
            if let array = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: nil)  as? [AnyObject] {
                return array
            }
        }
        return [AnyObject]()
    }
}