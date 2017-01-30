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
    
    //MARK: - Sign Up New User
    static func registerNewUserWith(_ fullName: String!, address: String!, email: String!, cellPhone: String!, country: String!, IDNumber: String!, userName: String!, password: String!, completion: ((AnyObject?, Bool) -> Void)?) {
        
        //URL
        var strWebServiceURL: String! = String(format: "%@%@", Constants.WEBSERVICE_URL, Constants.REG_NEWUSER)
        strWebServiceURL = strWebServiceURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        let url:URL = URL(string: strWebServiceURL)!
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        //CountryId,FullName,Address,Phone,Mail,UserName,Password
        
        var paramString = "FullName=\(fullName!)&"
        paramString = paramString + "Address=\(address!)&"
        paramString = paramString + "Mail=\(email!)&"
        paramString = paramString + "Phone=\(cellPhone!)&"
        paramString = paramString + "CountryId=\(country!)&"
        paramString = paramString + "UserName=\(userName!)&"
        paramString = paramString + "Password=\(password!)&"
        
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
            
            if dict == nil {
                completion!("Some error occured." as AnyObject?, false)
                return
            }
            print(dict!)
            
            //SUCCESS
            completion!(dict! as AnyObject?, true)
        }
        
        task.resume()
    }
    
    
    
    //MARK: - Sign Up Party
    static func registerPartyWith(_ companyName: String!, companyDesc: String!, organization_id: String!, countryCode: String!, address: String!, district: String!, postalcode: String!, tele1: String!, tele2: String!, fax: String!, email1: String!, username: String!, password: String!, completion: ((AnyObject?, Bool) -> Void)?) {
        
        //URL
        var strWebServiceURL: String! = String(format: "%@%@", Constants.WEBSERVICE_URL, Constants.REG_PARTY)
        strWebServiceURL = strWebServiceURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        let url:URL = URL(string: strWebServiceURL)!
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        //CountryId,FullName,Address,Phone,Mail,UserName,Password
        
        var paramString = "companyname=\(companyName!)&"
        paramString = paramString + "companydesc=\(companyDesc!)&"
        paramString = paramString + "organization_id=\(organization_id!)&"
        paramString = paramString + "countrycode=\(countryCode!)&"
        paramString = paramString + "address=\(address!)&"
        paramString = paramString + "district=\(district!)&"
        paramString = paramString + "postalcode=\(postalcode!)&"
        paramString = paramString + "tele1=\(tele1!)&"
        paramString = paramString + "tele2=\(tele2!)&"
        paramString = paramString + "fax=\(fax!)&"
        paramString = paramString + "email1=\(email1!)&"
        paramString = paramString + "username=\(username!)&"
        paramString = paramString + "password=\(password!)&"
        
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
            
            if dict == nil {
                completion!("Some error occured." as AnyObject?, false)
                return
            }
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
