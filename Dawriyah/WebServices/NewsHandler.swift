//
//  NewsHandler.swift
//  Dawriyah
//
//  Created by Hardik Shah on 25/12/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class NewsHandler: WebServiceHandler {
    
    //MARK: - Latest News
    static func latestNews(_ CurrentPage: String!, PageSize: String!, completion: ((AnyObject?, Bool) -> Void)?) {
        
        let manager:AFHTTPRequestOperationManager! = getRequestManager()
        
        //URL
        var strWebServiceURL: String! = String(format: "%@%@", Constants.WEBSERVICE_URL, Constants.LATESTNEWS)
        
        strWebServiceURL = strWebServiceURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        //print(strWebServiceURL)
        
        //Params
        let params: NSMutableDictionary! = NSMutableDictionary()
        params.setValue(CurrentPage, forKey: "currentpage")
        params.setValue(PageSize, forKey: "pagesize")
        
        manager.get(strWebServiceURL, parameters: params, success: { (operation: AFHTTPRequestOperation, responseObject: Any) in
            completion!(responseObject as AnyObject?, true)
        }, failure: { (responseObject: Any, error: Error) in
            
            completion!(error as AnyObject?, false)
        })
    }
    
    
    //MARK: - Press (General Press Kit)
    static func getPressNews(_ CurrentPage: String!, PageSize: String!, completion: ((AnyObject?, Bool) -> Void)?) {
        
        let manager:AFHTTPRequestOperationManager! = getRequestManager()
        
        //URL
        var strWebServiceURL: String! = String(format: "%@%@", Constants.WEBSERVICE_URL, Constants.PRESS_NEWS)
        
        strWebServiceURL = strWebServiceURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        //print(strWebServiceURL)
        
        //Params
        let params: NSMutableDictionary! = NSMutableDictionary()
        params.setValue(CurrentPage, forKey: "currentpage")
        params.setValue(PageSize, forKey: "pagesize")
        params.setValue("69", forKey: "id") //Static ID for Press News
        
        manager.get(strWebServiceURL, parameters: params, success: { (operation: AFHTTPRequestOperation, responseObject: Any) in
            completion!(responseObject as AnyObject?, true)
        }, failure: { (responseObject: Any, error: Error) in
            
            completion!(error as AnyObject?, false)
        })
    }

    
}
