//
//  HomeScreenHandler.swift
//  Dawriyah
//
//  Created by MehulS on 07/01/17.
//  Copyright © 2017 MehulS. All rights reserved.
//

import UIKit

class HomeScreenHandler: WebServiceHandler {

    
    //MARK: - Get Twitter Latest Feeds for Home Screen
    static func getLatestTweets(completion: ((AnyObject?, Bool) -> Void)?){
        
        let manager:AFHTTPRequestOperationManager! = getRequestManager()
        
        //URL
        let strWebServiceURL: String! = String(format: "%@%@", Constants.WEBSERVICE_URL,Constants.LATEST_TWEETS)
        
        manager.get(strWebServiceURL, parameters: nil, success: { (operation: AFHTTPRequestOperation, responseObject: Any ) in
            completion!(responseObject as AnyObject?, true)
        }, failure: { (responseObject: Any, error: Error) in
            completion!(error as AnyObject?, false)
        })
    }
    
    //MARK: - Get Facebook Latest Posts for Home Screen
    static func getLatestFacebookPosts(completion: ((AnyObject?, Bool) -> Void)?){
        
        let manager:AFHTTPRequestOperationManager! = getRequestManager()
        
        //URL
        let strWebServiceURL: String! = String(format: "%@%@", Constants.WEBSERVICE_URL,Constants.LATEST_FACEBOOK_POST)
        
        manager.get(strWebServiceURL, parameters: nil, success: { (operation: AFHTTPRequestOperation, responseObject: Any ) in
            completion!(responseObject as AnyObject?, true)
        }, failure: { (responseObject: Any, error: Error) in
            completion!(error as AnyObject?, false)
        })
    }
    
    
    //MARK: - Get Ads
    static func getAds(completion: ((AnyObject?, Bool) -> Void)?){
        
        let manager:AFHTTPRequestOperationManager! = getRequestManager()
        
        //URL
        let strWebServiceURL: String! = String(format: "%@%@", Constants.WEBSERVICE_URL,Constants.LATEST_ADS)
        
        manager.get(strWebServiceURL, parameters: nil, success: { (operation: AFHTTPRequestOperation, responseObject: Any ) in
            completion!(responseObject as AnyObject?, true)
        }, failure: { (responseObject: Any, error: Error) in
            completion!(error as AnyObject?, false)
        })
    }
    
}
