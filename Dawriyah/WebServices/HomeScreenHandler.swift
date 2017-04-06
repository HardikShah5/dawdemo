//
//  HomeScreenHandler.swift
//  Dawriyah
//
//  Created by MehulS on 07/01/17.
//  Copyright © 2017 MehulS. All rights reserved.
//

import UIKit

class HomeScreenHandler: WebServiceHandler {
    
    //MARK: - Get Slider Articles
    static func getSliderArticles(completion: ((AnyObject?, Bool) -> Void)?) {
        
        let manager:AFHTTPRequestOperationManager! = getRequestManager()
        
        //URL
        let strWebServiceURL: String! = String(format: "%@%@", Constants.WEBSERVICE_URL,Constants.SLIDER_ARTICLES)
        
        manager.get(strWebServiceURL, parameters: nil, success: { (operation: AFHTTPRequestOperation, responseObject: Any ) in
            completion!(responseObject as AnyObject?, true)
        }, failure: { (responseObject: Any, error: Error) in
            completion!(error as AnyObject?, false)
        })
    }
    
    
    //MARK: - Get Most Rated Articles
    static func getMostRatedArticles(completion: ((AnyObject?, Bool) -> Void)?) {
        
        let manager:AFHTTPRequestOperationManager! = getRequestManager()
        
        //URL
        let strWebServiceURL: String! = String(format: "%@%@", Constants.WEBSERVICE_URL,Constants.MOST_RATED_ARTICLES)
        
        manager.get(strWebServiceURL, parameters: nil, success: { (operation: AFHTTPRequestOperation, responseObject: Any ) in
            completion!(responseObject as AnyObject?, true)
        }, failure: { (responseObject: Any, error: Error) in
            completion!(error as AnyObject?, false)
        })
    }
    
    
    //MARK: - Get Home Cate1
    static func getHomeCate1(completion: ((AnyObject?, Bool) -> Void)?) {
        
        let manager:AFHTTPRequestOperationManager! = getRequestManager()
        
        //URL
        let strWebServiceURL: String! = String(format: "%@%@", Constants.WEBSERVICE_URL,Constants.HOME_CATEGORY1)
        
        manager.get(strWebServiceURL, parameters: nil, success: { (operation: AFHTTPRequestOperation, responseObject: Any ) in
            completion!(responseObject as AnyObject?, true)
        }, failure: { (responseObject: Any, error: Error) in
            completion!(error as AnyObject?, false)
        })
    }
    
    //MARK: - Get Home Cate2
    static func getHomeCate2(completion: ((AnyObject?, Bool) -> Void)?) {
        
        let manager:AFHTTPRequestOperationManager! = getRequestManager()
        
        //URL
        let strWebServiceURL: String! = String(format: "%@%@", Constants.WEBSERVICE_URL,Constants.HOME_CATEGORY2)
        
        manager.get(strWebServiceURL, parameters: nil, success: { (operation: AFHTTPRequestOperation, responseObject: Any ) in
            completion!(responseObject as AnyObject?, true)
        }, failure: { (responseObject: Any, error: Error) in
            completion!(error as AnyObject?, false)
        })
    }
    
    //MARK: - Get Most Viewed News
    static func getMostViewedNews(completion: ((AnyObject?, Bool) -> Void)?) {
        
        let manager:AFHTTPRequestOperationManager! = getRequestManager()
        
        //URL
        let strWebServiceURL: String! = String(format: "%@%@", Constants.WEBSERVICE_URL, Constants.MOST_VIEWED_NEWS)
        
        manager.get(strWebServiceURL, parameters: nil, success: { (operation: AFHTTPRequestOperation, responseObject: Any ) in
            completion!(responseObject as AnyObject?, true)
        }, failure: { (responseObject: Any, error: Error) in
            completion!(error as AnyObject?, false)
        })
    }
    
    //MARK: - Get Electronic Press
    static func getElectronicPress(completion: ((AnyObject?, Bool) -> Void)?) {
        
        let manager:AFHTTPRequestOperationManager! = getRequestManager()
        
        //URL
        let strWebServiceURL: String! = String(format: "%@%@", Constants.WEBSERVICE_URL, Constants.ELECTRONIC_PRESS)
        
        manager.get(strWebServiceURL, parameters: nil, success: { (operation: AFHTTPRequestOperation, responseObject: Any ) in
            completion!(responseObject as AnyObject?, true)
        }, failure: { (responseObject: Any, error: Error) in
            completion!(error as AnyObject?, false)
        })
    }
    
    
    //MARK: - Get Twitter Latest Feeds for Home Screen
    static func getLatestTweets(completion: ((AnyObject?, Bool) -> Void)?) {
        
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
    
    
    //MARK: - Get Club News
    static func getClubNews(completion: ((AnyObject?, Bool) -> Void)?){
        
        let manager:AFHTTPRequestOperationManager! = getRequestManager()
        
        //URL
        let strWebServiceURL: String! = String(format: "%@%@", Constants.WEBSERVICE_URL,Constants.CLUB)
        
        manager.get(strWebServiceURL, parameters: nil, success: { (operation: AFHTTPRequestOperation, responseObject: Any ) in
            completion!(responseObject as AnyObject?, true)
        }, failure: { (responseObject: Any, error: Error) in
            completion!(error as AnyObject?, false)
        })
    }
    
    
    //MARK: - Get Players News
    static func getPlayersNews(completion: ((AnyObject?, Bool) -> Void)?){
        
        let manager:AFHTTPRequestOperationManager! = getRequestManager()
        
        //URL
        let strWebServiceURL: String! = String(format: "%@%@", Constants.WEBSERVICE_URL,Constants.PLAYERS)
        
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
