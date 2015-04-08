//
//  HttpsendRequest.swift
//  TrainSpot
//
//  Created by Joost van den Brandt on 08/04/15.
//  Copyright (c) 2015 Joost van den Brandt. All rights reserved.
//

import Foundation
func HTTPsendRequest(request: NSMutableURLRequest,
    callback: (String, String?) -> Void) {
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(
            request,
            {
                data, response, error in
                if error != nil {
                    callback("", error.localizedDescription)
                } else {
                    callback(
                        NSString(data: data, encoding: NSUTF8StringEncoding)!,
                        nil
                    )
                }
        })
        
        task.resume()
        
}