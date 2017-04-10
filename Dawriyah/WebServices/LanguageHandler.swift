//
//  LanguageHandler.swift
//  Dawriyah
//
//  Created by Hardik Shah on 09/04/17.
//  Copyright © 2017 MehulS. All rights reserved.
//

import UIKit

class LanguageHandler: WebServiceHandler {
    
    //MARK: -  LanguageText Call
    static func GetTitleData(_ CurrentLang: String!, completion: ((AnyObject?, Bool) -> Void)?){
        
        let manager:AFHTTPRequestOperationManager! = getRequestManager()
        
        //URL
        let strWebServiceURL: String! = String(format: "%@%@&lang=%@", Constants.WEBSERVICE_URL,Constants.LANGUAGE,CurrentLang)
        
        //Params
        let params : NSMutableDictionary! = NSMutableDictionary()
//        params.setValue(CurrentPage, forKey: "currentpage")
//        params.setValue(PageSize, forKey: "pagesize")
        
        manager.get(strWebServiceURL, parameters: params, success: { (operation: AFHTTPRequestOperation, responseObject: Any ) in
            completion!(responseObject as AnyObject?, true)
        }, failure: { (responseObject: Any, error: Error) in
            completion!(error as AnyObject?, false)
        })
        
    }
}
