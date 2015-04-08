//
//  PostRequest.swift
//  TrainSpot
//
//  Created by Joost van den Brandt on 08/04/15.
//  Copyright (c) 2015 Joost van den Brandt. All rights reserved.
//

import Foundation
struct PostRequest{
    static func HTTPPostJSON(url: String,
        jsonObj: AnyObject,
        callback: (String, String?) -> Void) {
            var request = NSMutableURLRequest(URL: NSURL(string: url)!)
            request.HTTPMethod = "POST";
            request.addValue("application/json", forHTTPHeaderField: "Content-Type");
            let jsonString = JSONParser.JSONStringify(jsonObj)
            let data: NSData = jsonString.dataUsingEncoding(NSUTF8StringEncoding)!
            request.HTTPBody = data
            HTTPsendRequest(request, callback)
    }
}