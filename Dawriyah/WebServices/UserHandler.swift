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
        
        //URL
        var strWebServiceURL: String! = String(format: "%@%@", Constants.WEBSERVICE_URL, Constants.LOGIN)
        strWebServiceURL = strWebServiceURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        let url:URL = URL(string: strWebServiceURL)!
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let paramString = "email=\(email!)&password=\(password!)"
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest) {
            (data, response, error) in
            
            guard let data = data, let _:URLResponse = response, error == nil else {
                print("error")
                completion!(error?.localizedDescription as AnyObject?, false)
                return
            }
            
            let dataString =  String(data: data, encoding: String.Encoding.utf8)
            let dict = self.convertToDictionary(text: dataString!)
            print(dict!)
            
            //SUCCESS
            completion!(dict! as AnyObject?, true)
        }
        
        task.resume()
    }
    
    static func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
