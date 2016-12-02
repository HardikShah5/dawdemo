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
        arrayMenuItems = ["Home ",
                            "Advance search",
                            "News",
                            "Press kit",
                            "Twitter Tweet",
                            "Facebook Post",
                            "annual report",
                            "Newspaper",
                            "Official Magazine",
                            "the book",
                            "statistics",
                            "Favorite",
                            "about us",
                            "contact us",
                            "Help",
                            "Log out"]
        
        //Set frame and add slider menu
        self.frame = CGRect(x: 0, y: 0, width: viewCTR.view.frame.size.width, height: viewCTR.navigationController!.view.frame.size.height)
        viewCTR.view.window?.addSubview(self)
        viewCTR.view.window?.bringSubview(toFront: viewCTR.navigationController!.view)
        
        self.tableViewMenus.layoutIfNeeded()
        
        //Blur View
        /*viewVisualBlur = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        viewVisualBlur.frame = CGRect(x: self.tableViewMenus.frame.size.width, y: 0, width: self.frame.size.width - self.tableViewMenus.frame.size.width, height: (viewCTR.view.window?.frame.size.height)!)
        viewVisualBlur.alpha = 0.0
        viewCTR.view.window?.addSubview(viewVisualBlur)
        //viewVisualBlur.isHidden = true*/
        
        //Either with Tap or Swipe, for removing self
        btnToHideSelf.frame = CGRect(x: self.tableViewMenus.frame.size.width, y: 0, width: self.frame.size.width - self.tableViewMenus.frame.size.width, height: (viewCTR.view.window?.frame.size.height)!)
        btnToHideSelf.backgroundColor = UIColor.clear
        btnToHideSelf.addTarget(self, action: #selector(SliderMenu.hideSliderMenu), for: UIControlEvents.touchUpInside)
        viewCTR.view.window?.addSubview(btnToHideSelf)
        viewCTR.view.window?.bringSubview(toFront: btnToHideSelf)
        btnToHideSelf.isHidden = true
        
        
        //Swipe Gesture
        let swipeGesture: UISwipeGestureRecognizer! = UISwipeGestureRecognizer(target: self, action: #selector(SliderMenu.hideSliderMenu))
        swipeGesture.direction = .left
        btnToHideSelf.addGestureRecognizer(swipeGesture)
        
        //Detect Current Language
        let strCurrentLanguage = NSLocale.current.languageCode
        print("Current Language : \(strCurrentLanguage!)")
        
        //Animation for Parent view
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            viewCTR.navigationController!.view.frame = CGRect(x: -self.tableViewMenus.frame.size.width, y: 0, width: viewCTR.view.frame.size.width, height: viewCTR.navigationController!.view.frame.size.height)
            self.viewVisualBlur.alpha = 0.65
        }) { (isFinished) -> Void in
            self.btnToHideSelf.isHidden = false
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
            return 44
        }
        return 56
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "CellMenu"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        if indexPath.row == 0 {
            cell?.imageView?.image = UIImage(named: "ProfilePic")
            cell?.imageView?.contentMode = .scaleAspectFit
            cell?.imageView?.transform = CGAffineTransform(scaleX: 20, y: 20)
            cell?.textLabel?.textColor = UIColor.white
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
        //Hide Self
        self.hideSliderMenu()
        
        //Call Delegate method to get Selected Index
        delegate.indexSelectedFromSliderMenu(index: indexPath.row)
    }

}
