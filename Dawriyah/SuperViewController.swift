//
//  SuperViewController.swift
//  Dawriyah
//
//  Created by MehulS on 24/11/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

//UITextField Extenstion
extension UITextField{
    //Placeholder text Color
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSForegroundColorAttributeName: newValue!])
        }
    }
}

class SuperViewController: UIViewController, SliderMenuDelegate {

    var sliderMenu: SliderMenu! = nil
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ////Back Button for Specific Controller
        if self is Login || self is SignUp || self is FBTWProfile || self is NewsDetail {
            self.backButton()
        }else {
            //Set Up Navigation Bar Buttons
            self.setupNavigationBar()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - Back Button
    func backButton() -> Void {
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "BackButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(btnBackClicked))
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    func btnBackClicked() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Set Up Navigation Bar Buttons
    func setupNavigationBar() -> Void {
        //Left Buttons
        let leftMenu = UIBarButtonItem(image: UIImage(named: "Menu")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(btnMenuClicked))
        
        let leftSearch = UIBarButtonItem(image: UIImage(named: "Search")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(btnSearchClicked))
        
        self.navigationItem.leftBarButtonItems = [leftMenu, leftSearch]
        
        //Right bar item only for Home Screen
        if self is Home {
            //Right Button
            let rightMore = UIBarButtonItem(image: UIImage(named: "More")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(btnMoreClicked))
            self.navigationItem.rightBarButtonItem = rightMore
        }
        
        let imageView = UIImageView(image: UIImage(named: "logo_nav")?.withRenderingMode(.alwaysOriginal))
        self.navigationItem.titleView = imageView
    }
    
    
    //MARK: - Open Slider Menu
    func btnMenuClicked() -> Void {
        print("Menu Clicked.")
        
        sliderMenu = SliderMenu.getSliderMenuView()
        sliderMenu.delegate = self
        sliderMenu.showSliderMenu(viewCTR: self)
    }
    
    //MARK: - Slider Menu Delegate
    func indexSelectedFromSliderMenu(index: Int) {
        self.view.endEditing(true)
        
        print("Selected Index : \(index)")
        
        if index == SliderMenuOption.PROFILE {
            //Profile
            navigateToHomeScreen()
        }else if index == SliderMenuOption.ADVANCED_SEARCH {
            //Advanced Search
        }else if index == SliderMenuOption.NEWS {
            //News
            navigateToNews()
        }else if index == SliderMenuOption.PRESS_KIT {
            //Press Kit
            navigateToPressKit()
        }else if index == SliderMenuOption.TWITTER {
            //Twitter
            navigateToTwitter()
        }else if index == SliderMenuOption.FACEBOOK {
            //Facebook
            navigateToFacebook()
        }else if index == SliderMenuOption.ANNUAL_REPORT {
            //Annual Report
            navigateToAnnualReport()
        }else if index == SliderMenuOption.NEWS_PAPER {
            //News Paper
            navigateToNewsPaper()
        }else if index == SliderMenuOption.OFFICIAL_MAGAZINE {
            //Official Magazine
            navigateToOfficialMagagize()
        }else if index == SliderMenuOption.THE_BOOK {
            //The Book
        }else if index == SliderMenuOption.STATISTICS {
            //Statistics
        }else if index == SliderMenuOption.FAVORITE {
            //Favorite
        }else if index == SliderMenuOption.ABOUT_US {
            //About Us
        }else if index == SliderMenuOption.CONTACT_US {
            //Contact Us
        }else if index == SliderMenuOption.HELP {
            //Help
        }else if index == SliderMenuOption.LOGOUT {
            //Logout
            doLogout()
        }else if index == SliderMenuOption.LANGUAGE_ENGLISH {
            //Show Alert for Language Change
            self.changeLanguageToEnglish()
        }else if index == SliderMenuOption.LANGUAGE_ARABIC {
            //Show Alert for Language Change
            self.changeLanguageToArabic()
        }
    }
    
    
    //MARK: - Navigate To Home
    func navigateToHomeScreen() -> Void {
        var isAlreadyExist: Bool = false
        for viewCTR in (self.navigationController?.viewControllers)! {
            if viewCTR is Home {
                isAlreadyExist = true
                self.navigationController?.popToViewController(viewCTR, animated: true)
                break
            }
        }
        
        if isAlreadyExist == false {
            let homeVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.HOME) as! Home
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
    }
    
    //MARK: - Navigate To News
    func navigateToNews() -> Void {
        let newsVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.NEWS_LISTING) as! NewsListing
        
        self.navigationController?.pushViewController(newsVC, animated: true)
    }
    
    //MARK: - Navigate To PressKit
    func navigateToPressKit() -> Void {
        let pressVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.PRESS_KIT) as! PressKit
        
        self.navigationController?.pushViewController(pressVC, animated: true)
    }
    
    //MARK: - Navigate To Twitter
    func navigateToTwitter() -> Void {
        let twitterVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.TWITTER) as! FBTwitterPost
        
        twitterVC.isForTwitter = true
        
        self.navigationController?.pushViewController(twitterVC, animated: true)
    }
    
    //MARK: - Navigate To Facebook
    func navigateToFacebook() -> Void {
        let facebookVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.FACEBOOK) as! FBTwitterPost
        
        facebookVC.isForTwitter = false
        
        self.navigationController?.pushViewController(facebookVC, animated: true)
    }
    
    
    //MARK: - Navigate To Annual Report
    func navigateToAnnualReport() -> Void {
        let annualReportVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.ANNUAL_REPORT_LIST) as! AnnualReportList
        
        self.navigationController?.pushViewController(annualReportVC, animated: true)
    }
    
    
    //MARK: - Navigate To News Paper
    func navigateToNewsPaper() -> Void {
        let newsPaperVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.NEWS_PAPER_LIST) as! NewspaperList
        
        self.navigationController?.pushViewController(newsPaperVC, animated: true)
    }
    
    
    //MARK: - Navigate To Official Magagize
    func navigateToOfficialMagagize() -> Void {
        let officialMagazineVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.OFFICIAL_MAGAGINE_LIST) as! OfficialMagazineListing
        
        self.navigationController?.pushViewController(officialMagazineVC, animated: true)
    }
    
    
    
    //MARK: - Logout
    func doLogout() -> Void {
        let alert = UIAlertController(title: AppUtils.localized("LOGOUT", value: ""), message: AppUtils.localized("LOGOUT_ALERT", value: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: AppUtils.localized("NO", value: ""), style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: AppUtils.localized("LOGOUT", value: ""), style: .default, handler: { (action) in
            //Pop to landing page : Login
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - Search Button
    func btnSearchClicked() -> Void {
        print("Search Clicked.")
    }
    
    //MARK: - More Button
    func btnMoreClicked() -> Void {
        print("More Clicked.")
    }
    
    
    //MARK: - English Language Alert
    func changeLanguageToEnglish() -> Void {
        if AppUtils.isArabicLayout == false {
            //Already English language, no need to do anything
            return
        }
        
        
        let actionSheetController = UIAlertController(title: "Change Language", message: "By selecting change option, it will quit from application. You need to re-open from home screen. Do you want to change language?", preferredStyle: .actionSheet)
        
        //Cancel
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
        }
        actionSheetController.addAction(cancelActionButton)
        
        //Change
        let saveActionButton = UIAlertAction(title: "Change to English", style: .default) { action -> Void in
            //Change System Language
            self.changeLanguageToArabic(false)
            
            //Quit App
            exit(0)
        }
        actionSheetController.addAction(saveActionButton)
        
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    //MARK: - Arabic Language Alert
    func changeLanguageToArabic() -> Void {
        if AppUtils.isArabicLayout == true {
            //Already English language, no need to do anything
            return
        }
        
        
        let actionSheetController = UIAlertController(title: AppUtils.localized("SELECT_LANGUAGE", value: ""), message: AppUtils.localized("CHANGE_LANGUAGE_TEXT", value: ""), preferredStyle: .actionSheet)
        
        //Cancel
        let cancelActionButton = UIAlertAction(title: AppUtils.localized("CANCEL", value: ""), style: .cancel) { action -> Void in
        }
        actionSheetController.addAction(cancelActionButton)
        
        //Change
        let saveActionButton = UIAlertAction(title: AppUtils.localized("CHANGE_ARABIC", value: ""), style: .default) { action -> Void in
            //Change System Language
            self.changeLanguageToArabic(true)
            
            //Quit App
            exit(0)
        }
        actionSheetController.addAction(saveActionButton)
        
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    func changeLanguageToArabic(_ isArabic: Bool) -> Void {
        var language = "ar"
        
        if isArabic == true {
            language = "ar"
            AppUtils.isArabicLayout = true
        }else {
            language = "en"
            AppUtils.isArabicLayout = false
        }
        
        UserDefaults.standard.set([language], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }

}
