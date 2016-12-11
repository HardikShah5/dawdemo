//
//  WebViewDataHandler.swift
//  UVoices
//
//  Created by MehulS on 24/09/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class UserHandler: WebServiceHandler {

    //MARK: Login
    static func loginWith(_ email: String!, password: String!, completion: ((AnyObject?, Bool) -> Void)?) {
        
        let manager:AFHTTPRequestOperationManager! = getRequestManager()
       
        //URL
        var strWebServiceURL: String! = String(format: "%@%@", Constants.WEBSERVICE_URL, Constants.LOGIN)
        
        strWebServiceURL = strWebServiceURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        //print(strWebServiceURL)
        
        //Params
        let params: NSMutableDictionary! = NSMutableDictionary()
        params.setValue(email, forKey: "email")
        params.setValue(password, forKey: "password")
        
        manager.post(strWebServiceURL, parameters: params, success: { (operation: AFHTTPRequestOperation, responseObject: Any) in
            completion!(responseObject as AnyObject?, true)
        }) { (responseObject: Any, error: Error) in
            
            completion!(error as AnyObject?, false)
        }
    }
}
