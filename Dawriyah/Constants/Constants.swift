//
//  Constants.swift
//  Dawriyah
//
//  Created by MehulS on 03/12/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class Constants: NSObject {
    
    //Web Service Pre URL
    static let WEBSERVICE_URL : String = ""
    
    //Web Services End Points
    static let LOGIN : String           = ""
    
    
    
    //Static Value to Comonly Use
    static let CornerRaius:CGFloat = 5.0;
    
    //Colors
    struct Color {
        static let BLUE_UNDERLINE   =   UIColor(colorLiteralRed: 30/255.0, green: 126/255.0, blue: 233/255.0, alpha: 1.0)
    }

    //Storyboard Identifier
    struct StoryboardIdentifier {
        static let HOME                     = "Home"
        static let FACEBOOK                 = "FBTwitterPost"
        static let TWITTER                  = "FBTwitterPost"
        static let FACEBOOK_DETAILS         = "FBTWProfile"
        static let TWITTER_DETAILS          = "FBTWProfile"
        static let NEWS_LISTING             = "NewsListing"
        static let NEWS_DETAILS             = "NewsDetail"
    }
}

//Slider Menu Options
struct SliderMenuOption {
    static let PROFILE              = 0
    static let ADVANCED_SEARCH      = 1
    static let NEWS                 = 2
    static let PRESS_KIT            = 3
    static let TWITTER              = 4
    static let FACEBOOK             = 5
    static let ANNUAL_REPORT        = 6
    static let NEWS_PAPER           = 7
    static let OFFICIAL_MAGAZINE    = 8
    static let THE_BOOK             = 9
    static let STATISTICS           = 10
    static let FAVORITE             = 11
    static let ABOUT_US             = 12
    static let CONTACT_US           = 13
    static let HELP                 = 14
    static let LOGOUT               = 15
}

//Current Language
struct CurrentLanguage {
    static let ENGLISH  =   "en"
    static let ARABIC   =   "ar"
}
