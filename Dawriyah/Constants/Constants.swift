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
    static let WEBSERVICE_URL : String = "http://dawriyah.com/newsservices.aspx?cmd="
    static let IMAGE_PREFIX   : String = "http://208.67.21.15/dawriyah_images/newsimages/"
    
    //Web Services End Points
    static let LOGIN : String               = "dlogin"
    static let REG_NEWUSER : String         = "reg"
    static let REG_PARTY  : String          = "compreg"
    static let LATESTNEWS : String          = "last"
    static let PRESS_NEWS: String           = "pressfilegendetails"
    static let ANNUALREPORT : String          = "rep"
    static let NEWSPAPER : String          = "paperall"
    static let MAGAZINE : String          = "mag"
    
    static let TWITTER : String             = "twitter"
    static let TWITTERWRITER : String       = "twitternews"
    static let FACEBOOK : String            = "facebook"
    static let FACEBOOKWRITER : String      = "facebooknews"
    
    //Home Screen
    static let SLIDER_ARTICLES: String       = "homeslider"
    static let MOST_RATED_ARTICLES: String   = "homemostratedarticles"
    static let MOST_RATED_NEWS: String       = "homemostratednews"
    static let MOST_VIEWED_NEWS: String      = "homemostviewednews"
    static let ELECTRONIC_PRESS: String      = "homecategory1"
    static let HOME_CATEGORY1: String       = "homecategory1"
    static let HOME_CATEGORY2: String       = "homecategory2"
    
    static let LATEST_TWEETS: String        = "homelasttweets"
    static let LATEST_FACEBOOK_POST: String = "homelastfacebookposts"
    
    static let CLUB:    String = "gethomeclubsnews"
    static let PLAYERS: String = "gethomeplayersnews"
    
    static let LATEST_ADS: String           = "ads"
    
    
    //Static Value to Comonly Use
    static let CornerRaius:CGFloat = 5.0;
    static let ItemsPerPage:Int = 10;
    
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
        static let PRESS_KIT                = "PressKit"
        static let ANNUAL_REPORT_LIST       = "AnnualReportList"
        static let NEWS_PAPER_LIST          = "NewspaperList"
        static let OFFICIAL_MAGAGINE_LIST   = "OfficialMagazineListing"
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
