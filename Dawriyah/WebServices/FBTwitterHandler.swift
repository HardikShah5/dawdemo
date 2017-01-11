//
//  FBTwitterHandler.swift
//  Dawriyah
//
//  Created by Hardik Shah on 30/12/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class FBTwitterHandler: WebServiceHandler {
    
    //MARK: -  Twitt Call
    static func GetTwittsData(_ CurrentPage: String!, PageSize: String!, completion: ((AnyObject?, Bool) -> Void)?){
        
        let manager:AFHTTPRequestOperationManager! = getRequestManager()
        
        //URL
        let strWebServiceURL: String! = String(format: "%@%@", Constants.WEBSERVICE_URL,Constants.TWITTER)
        
        //Params
        let params : NSMutableDictionary! = NSMutableDictionary()
        params.setValue(CurrentPage, forKey: "currentpage")
        params.setValue(PageSize, forKey: "pagesize")
        
        manager.get(strWebServiceURL, parameters: params, success: { (operation: AFHTTPRequestOperation, responseObject: Any ) in
            completion!(responseObject as AnyObject?, true)
        }, failure: { (responseObject: Any, error: Error) in
            completion!(error as AnyObject?, false)
        })
        
    }
    
    //MARK: -  Facebook Call
    static func GetFacebookData(_ CurrentPage: String!, PageSize: String!, completion: ((AnyObject?, Bool) -> Void)?){
        
        let manager:AFHTTPRequestOperationManager! = getRequestManager()
        
        //URL
        let strWebServiceURL: String! = String(format: "%@%@", Constants.WEBSERVICE_URL,Constants.FACEBOOK)
        
        //Params
        let params : NSMutableDictionary! = NSMutableDictionary()
                params.setValue(CurrentPage, forKey: "currentpage")
                params.setValue(PageSize, forKey: "pagesize")
        
        manager.get(strWebServiceURL, parameters: params, success: { (operation: AFHTTPRequestOperation, responseObject: Any ) in
            completion!(responseObject as AnyObject?, true)
        }, failure: { (responseObject: Any, error: Error) in
            completion!(error as AnyObject?, false)
        })
        
    }
    
    //MARK: -  Facebook Writer Post Call
    static func GetFacebookWriterPost(_ WriterId: String!, CurrentPage: String!, PageSize: String!, completion: ((AnyObject?, Bool) -> Void)?){
        
        let manager:AFHTTPRequestOperationManager! = getRequestManager()
        
        //URL
        let strWebServiceURL: String! = String(format: "%@%@", Constants.WEBSERVICE_URL,Constants.FACEBOOKWRITER)
        
        //Params
        let params : NSMutableDictionary! = NSMutableDictionary()
                params.setValue(CurrentPage, forKey: "currentpage")
                params.setValue(PageSize, forKey: "pagesize")
        params.setValue(WriterId, forKey: "id")
        
        manager.get(strWebServiceURL, parameters: params, success: { (operation: AFHTTPRequestOperation, responseObject: Any ) in
            completion!(responseObject as AnyObject?, true)
        }, failure: { (responseObject: Any, error: Error) in
            completion!(error as AnyObject?, false)
        })
        
    }
    
    //MARK: - Twitter Writer Twitts Call
    static func GetTwitterWriterPost(_ WriterId: String!, CurrentPage: String!, PageSize: String!, completion: ((AnyObject?, Bool) -> Void)?){
        
        let manager:AFHTTPRequestOperationManager! = getRequestManager()
        
        //URL
        let strWebServiceURL: String! = String(format: "%@%@", Constants.WEBSERVICE_URL,Constants.TWITTERWRITER)
        
        //Params
        let params : NSMutableDictionary! = NSMutableDictionary()
        params.setValue(CurrentPage, forKey: "currentpage")
        params.setValue(PageSize, forKey: "pagesize")
        params.setValue(WriterId, forKey: "id")
        
        manager.get(strWebServiceURL, parameters: params, success: { (operation: AFHTTPRequestOperation, responseObject: Any ) in
            completion!(responseObject as AnyObject?, true)
        }, failure: { (responseObject: Any, error: Error) in
            completion!(error as AnyObject?, false)
        })
    }
    
    
    
}
