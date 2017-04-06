//
//  SliderMenu.swift
//  AirStreamJets
//
//  Created by MehulS on 29/10/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

//Delegate for Selected Index
protocol SliderMenuDelegate {
    func indexSelectedFromSliderMenu(index: Int)
}

class SliderMenu: UIView, UITableViewDataSource, UITableViewDelegate {
    
    var delegate: SliderMenuDelegate!
    
    let viewStatusBarBG: UIView! = UIView()
    let btnToHideSelf: UIButton! = UIButton()
    var viewVisualBlur = UIVisualEffectView()
    
    var viewCTRParent: UIViewController!
    var arrayMenuItems = [String]()
    
    var isSelectedLanguageCell: Bool = false
    
    @IBOutlet weak var tableViewMenus: UITableView!

    class func getSliderMenuView() -> SliderMenu {
        let arrayNIBs: NSArray! = Bundle.main.loadNibNamed("SliderMenu", owner: self, options: nil) as NSArray!
        for object in arrayNIBs {
            if (object as AnyObject).isKind(of: SliderMenu.self) {
                return object as! SliderMenu
            }
        }
        return ((Bundle.main.loadNibNamed("SliderMenu", owner: self, options: nil) as AnyObject) as? SliderMenu)!
    }
    
    func showSliderMenu(viewCTR: UIViewController) {
        
        viewCTRParent = viewCTR
        
        //For Showing Status Bar with BLUE Background Color
        viewStatusBarBG.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 20)
        viewStatusBarBG.backgroundColor = UIColor(white: 0.4, alpha: 0.6)
        viewCTR.view.window?.addSubview(viewStatusBarBG)
        
        //Delegate and Data source to Table view
        tableViewMenus.delegate = self
        tableViewMenus.dataSource = self
        tableViewMenus.tableFooterView = UIView(frame: CGRect.zero)
        
        //Set Menu Items in ARRAY
        arrayMenuItems = [AppUtils.localized("HOME", value: ""),
                            AppUtils.localized("SELECT_LANGUAGE", value: ""),
                            AppUtils.localized("NEWS", value: ""),
                            AppUtils.localized("PRESS_KIT", value: ""),
                            AppUtils.localized("TWITTER_TWEET", value: ""),
                            AppUtils.localized("FACEBOOK_POST", value: ""),
                            AppUtils.localized("ANNUAL_REPORT", value: ""),
                            AppUtils.localized("NEWSPAPER", value: ""),
                            AppUtils.localized("OFFICAIL_MAGAZINE", value: ""),
                            AppUtils.localized("THE_BOOK", value: ""),
                            AppUtils.localized("STATTISTICS", value: ""),
                            AppUtils.localized("FAVORITE", value: ""),
                            AppUtils.localized("ABOUT_US", value: ""),
                            AppUtils.localized("CONTACT_US", value: ""),
                            AppUtils.localized("HELP", value: ""),
                            AppUtils.localized("LOGOUT", value: "")]
        
        //Set frame and add slider menu
        self.frame = CGRect(x: 0, y: 0, width: viewCTR.view.frame.size.width, height: viewCTR.navigationController!.view.frame.size.height)
        viewCTR.view.window?.addSubview(self)
        viewCTR.view.window?.bringSubview(toFront: self)
        viewCTR.view.window?.bringSubview(toFront: viewCTR.navigationController!.view)
        viewCTR.view.window?.bringSubview(toFront: tableViewMenus)
        
        self.tableViewMenus.layoutIfNeeded()
        
        //Register Cell
        self.tableViewMenus.register(UINib(nibName: "CellLanguage", bundle: nil), forCellReuseIdentifier: "CellLanguage")

        
        
        
        //Blur View
        /*viewVisualBlur = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        viewVisualBlur.frame = CGRect(x: self.tableViewMenus.frame.size.width, y: 0, width: self.frame.size.width - self.tableViewMenus.frame.size.width, height: (viewCTR.view.window?.frame.size.height)!)
        viewVisualBlur.alpha = 0.0
        viewCTR.view.window?.addSubview(viewVisualBlur)
        //viewVisualBlur.isHidden = true*/
        
        //Either with Tap or Swipe, for removing self
        if AppUtils.isArabicLayout == true {
            btnToHideSelf.frame = CGRect(x: 0, y: 0, width: self.frame.size.width - self.tableViewMenus.frame.size.width, height: (viewCTR.view.window?.frame.size.height)!)
        }else {
            btnToHideSelf.frame = CGRect(x: self.tableViewMenus.frame.size.width, y: 0, width: self.frame.size.width - self.tableViewMenus.frame.size.width, height: (viewCTR.view.window?.frame.size.height)!)
        }
        
        btnToHideSelf.backgroundColor = UIColor.clear
        btnToHideSelf.addTarget(self, action: #selector(SliderMenu.hideSliderMenu), for: UIControlEvents.touchUpInside)
        viewCTR.view.window?.addSubview(btnToHideSelf)
        viewCTR.view.window?.bringSubview(toFront: btnToHideSelf)
        btnToHideSelf.isHidden = true
        
        
        //Swipe Gesture
        let swipeGesture: UISwipeGestureRecognizer! = UISwipeGestureRecognizer(target: self, action: #selector(SliderMenu.hideSliderMenu))
        swipeGesture.direction = .right
        btnToHideSelf.addGestureRecognizer(swipeGesture)
        
        //Detect Current Language
        let strCurrentLanguage = NSLocale.current.languageCode
        print("Current Language : \(strCurrentLanguage!)")
        
        //Animation for Parent view
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            
            if AppUtils.isArabicLayout == true {
            viewCTR.navigationController!.view.frame = CGRect(x: -self.tableViewMenus.frame.size.width, y: 0, width: viewCTR.view.frame.size.width, height: viewCTR.navigationController!.view.frame.size.height)
            }else {
                viewCTR.navigationController!.view.frame = CGRect(x: self.tableViewMenus.frame.size.width, y: 0, width: viewCTR.view.frame.size.width, height: viewCTR.navigationController!.view.frame.size.height)
            }
            self.viewVisualBlur.alpha = 0.65
        }) { (isFinished) -> Void in
            self.btnToHideSelf.isHidden = false
            self.viewCTRParent.view.window?.bringSubview(toFront: self.btnToHideSelf)
        }
    }
    
    
    //MARK: - Hide Slider Menu
    func hideSliderMenu() {
        UIView.animate(withDuration: 0.05, animations: {
            self.viewVisualBlur.alpha = 0.0
        }) { (isFinished) in
            self.btnToHideSelf.isHidden = true
        }
        
        //Animation for Parent view
        /*UIView.animate(withDuration: 0.0005, animations: { () -> Void in
            self.viewCTRParent.navigationController!.view.frame = CGRect(x: self.tableViewMenus.frame.size.width + 20, y: 0, width: self.viewCTRParent.view.frame.size.width, height: self.viewCTRParent.navigationController!.view.frame.size.height)
        }) { (isFinished) -> Void in
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                self.viewCTRParent.navigationController!.view.frame = CGRect(x: 0, y: 0, width: self.viewCTRParent.view.frame.size.width, height: self.viewCTRParent.navigationController!.view.frame.size.height)
            }) { (isFinished) -> Void in
                //On Hiding remove all objects
                self.deallocAllObjects()
            }
        }*/
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.viewCTRParent.navigationController!.view.frame = CGRect(x: 0, y: 0, width: self.viewCTRParent.view.frame.size.width, height: self.viewCTRParent.navigationController!.view.frame.size.height)
        }) { (isFinished) -> Void in
            //On Hiding remove all objects
            self.deallocAllObjects()
        }
    }
    
    func deallocAllObjects() {
        btnToHideSelf.removeFromSuperview()
        viewVisualBlur.removeFromSuperview()
        viewStatusBarBG.removeFromSuperview()
        tableViewMenus.removeFromSuperview()
        self.removeFromSuperview()
    }
    
    
    //MARK: - UITableView Delegates
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 64
        }else if indexPath.row == 1 && isSelectedLanguageCell == true {
            return 145
        }
        return 56
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Language Cell
        if indexPath.row == 1 && isSelectedLanguageCell == true {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellLanguage") as! CellLanguage
            
            //For RTL - Mehul April 06, 2017
            if UIView.userInterfaceLayoutDirection(for: cell.btnSelectLanguage.semanticContentAttribute) == UIUserInterfaceLayoutDirection.rightToLeft {
                
                cell.btnSelectLanguage.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
                cell.btnArabic.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
                cell.btnEnglish.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
                
                cell.btnArabic.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15)
                cell.btnArabic.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 25)
                
                cell.btnEnglish.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15)
                cell.btnEnglish.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 25)
            }
            
            //Set Selected Button
            if AppUtils.isArabicLayout == true {
                cell.btnArabic.isSelected  = true
                cell.btnEnglish.isSelected = false
            }else {
                cell.btnArabic.isSelected  = false
                cell.btnEnglish.isSelected = true
            }
            
            //Add Target
            cell.btnSelectLanguage.addTarget(self, action: #selector(btnSelectLanguageClicked), for: .touchUpInside)
            cell.btnEnglish.addTarget(self, action: #selector(btnEnglishLanguageClicked), for: .touchUpInside)
            cell.btnArabic.addTarget(self, action: #selector(btnArabicLanguageClicked), for: .touchUpInside)
            
            //Set Langauge Text
            cell.btnSelectLanguage.setTitle(AppUtils.localized("SELECT_LANGUAGE", value: ""), for: .normal)
            cell.btnEnglish.setTitle(AppUtils.localized("LANGUAGE_ENGLISH", value: ""), for: .normal)
            cell.btnArabic.setTitle(AppUtils.localized("LANGUAGE_ARABIC", value: ""), for: .normal)
            
            //Font
            let font = UIFont(name: "HelveticaNeue-Light", size: 17.0)
            cell.btnSelectLanguage.titleLabel?.font = font
            cell.btnEnglish.titleLabel?.font = font
            cell.btnArabic.titleLabel?.font = font
            
            return cell
        }
        
        let identifier = "CellMenu"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        if indexPath.row == 0 {
            cell?.imageView?.image = UIImage(named: "ProfilePic")
            cell?.imageView?.contentMode = .center
            cell?.textLabel?.textColor = UIColor.black
        }else {
            cell?.imageView?.image = nil
            cell?.backgroundColor = UIColor.white
            cell?.textLabel?.textColor = UIColor.black
        }
        cell?.textLabel?.text = arrayMenuItems[indexPath.row]
        cell?.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 17.0)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Select Language
        if indexPath.row == 1 {
            if isSelectedLanguageCell == false {
                isSelectedLanguageCell = true
            }else {
                isSelectedLanguageCell = false
            }
            
            //Reload First Cell
            self.tableViewMenus.reloadRows(at: [indexPath], with: .fade)
            
        }else {
            //Hide Self
            self.hideSliderMenu()
            
            //Call Delegate method to get Selected Index
            delegate.indexSelectedFromSliderMenu(index: indexPath.row)
        }
    }
    
    //MARK: - Select Language Button to Collapse
    func btnSelectLanguageClicked() -> Void {
        isSelectedLanguageCell = false
        
        //Reload First Cell
        let indexPath = IndexPath(row: 1, section: 0)
        self.tableViewMenus.reloadRows(at: [indexPath], with: .fade)
    }
    
    //MARK: - English Language
    func btnEnglishLanguageClicked() -> Void {
        //Hide Self
        self.hideSliderMenu()
        
        //Call Delegate method to get Selected Index
        delegate.indexSelectedFromSliderMenu(index: SliderMenuOption.LANGUAGE_ENGLISH)
    }
    
    //MARK: - Arabic Language
    func btnArabicLanguageClicked() -> Void {
        //Hide Self
        self.hideSliderMenu()
        
        //Call Delegate method to get Selected Index
        delegate.indexSelectedFromSliderMenu(index: SliderMenuOption.LANGUAGE_ARABIC)
    }

}
