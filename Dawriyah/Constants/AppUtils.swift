//
//  AppUtils.swift
//  WhiteLeafBooks
//
//  Created by MehulS on 10/07/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit
import AVFoundation

class AppUtils: NSObject {
    
    static var progressView : MBProgressHUD?
    
    
    //MARK: App Delegate Object
    static func APPDELEGATE() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    
    //MARK: Validations For Email
    static func validateEmail(_ strEmail : String)-> Bool {
        let emailRegex : String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        
        return emailTest.evaluate(with: strEmail)
    }
    
        
    //For language text
    static func localized(_ key: String, value: String) -> String {
        var lang: String! = "en"
        
        let arrLang: NSArray! = UserDefaults.standard.value(forKey: "AppleLanguages") as! NSArray
        if arrLang.count > 0 {
            lang = arrLang.firstObject as! String
            
            if lang.contains("-") {
                lang = lang.components(separatedBy: "-").first
            }
        }
        
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        
        return NSLocalizedString(key, tableName: nil, bundle: bundle!, value: value, comment: "")
    }
    
    
    //Current Language
    static func currentLanguage() -> String {
        let langStr = Locale.current.languageCode
        return langStr!
    }
    
    //MARK: Loading View
    static func startLoading(view : UIView) {
        progressView = MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    static func startLoadingWithText(strText: String, view : UIView) {
        progressView = MBProgressHUD.showAdded(to: view, animated: true)
        progressView?.labelText = strText
    }
    
    static func stopLoading() {
        self.progressView!.hide(true)
    }
    
    static func hudWasHidden() {
    }
}
