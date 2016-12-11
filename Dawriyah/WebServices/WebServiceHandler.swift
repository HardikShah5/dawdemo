//
//  BaseModel.swift
//  WhiteLeafBooks
//
//  Created by MehulS on 08/07/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class WebServiceHandler: NSObject {
    
    //Get Instance of AFNetworkingManager
    class func getRequestManager() -> AFHTTPRequestOperationManager {
        let manager: AFHTTPRequestOperationManager = WebServiceHandler.getManager()!
        //manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/plain") as? Set<String>
        return manager
    }
    
    class func getManager() -> AFHTTPRequestOperationManager? {
        let manager: AFHTTPRequestOperationManager! = AFHTTPRequestOperationManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as? Set<String>
        //application/json
        return manager
    }
}
