//
//  ViewNewsInfo.swift
//  Dawriyah
//
//  Created by MehulS on 16/12/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

struct FilterType {
    static let CATEGORY     = 11
    static let COUNTRY      = 12
    static let PUBLISHER    = 13
}

class Filter: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var btnCategory: UIButton!
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var btnPublisher: UIButton!
    @IBOutlet weak var btnFilter: UIButton!
    
    //Picker View
    @IBOutlet weak var viewPickerViewContainer: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var arrayCategory   = [String]()
    var arrayCountry    = [String]()
    var arrayPublisher  = [String]()
    
    var selectedIndexForCategorty   = 0
    var selectedIndexForCountries     = 0
    var selectedIndexForPublisher   = 0
    
    //MARK: - Set Layout
    func setLayout() -> Void {
        //For RTL - Mehul December 29, 2016
        if UIView.userInterfaceLayoutDirection(for: btnCategory.semanticContentAttribute) == UIUserInterfaceLayoutDirection.rightToLeft {
            
            btnCategory.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
            btnCategory.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10)
        
            btnCountry.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
            btnCountry.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10)
            
            btnPublisher.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
            btnPublisher.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10)
        }
        
        //Set Frame
        self.frame = CGRect(x: 0, y: 0, width: (AppUtils.APPDELEGATE().window?.frame.size.width)!, height: (AppUtils.APPDELEGATE().window?.frame.size.height)!)
        
        //Layer Properties
        viewContainer.layer.cornerRadius = 3.0
        viewContainer.layer.masksToBounds = true
        
        //Add tap gesture to close SELF
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideSelf))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tapGesture)
        
        //Hide Picker View At Starting
        viewPickerViewContainer.isHidden = true
        
        //Assign Picker View
        pickerView.tag = FilterType.CATEGORY
        
        //Initialise ARRAYs
        arrayCategory = ["Artificial Intelligence",
                         "Computer Vision",
                         "Machine Learning",
                         "Neural Networks",
                         "Coding Theory",
                         "Information Security",
                         "Image Processing",
                         "Data Mining",
                         "Big Data",
                         "Data Science",
                         "Functional Programming",
                         "Compiler Design and Construction",
                         "Object Oriented Programming",
                         "Software Engineering",
                         "Cryptography"]
        
        arrayCountry = ["France",
                         "United States",
                         "China",
                         "Spain",
                         "Italy",
                         "Turkey",
                         "United Kingdom",
                         "Germany",
                         "Russian Federation",
                         "Malaysia",
                         "Mexico",
                         "Austria"]
        
        arrayPublisher = ["Pearson",
                        "ThomsonReuters",
                        "RELX Group",
                        "Wolters Kluwer",
                        "Penguin Random House",
                        "China South Publishing & Media Group Co., Ltd",
                        "Hachette Livre",
                        "McGraw-Hill Education",
                        "Holtzbrinck"]
    }
    
    func hideSelf() -> Void {
        self.isHidden = true
    }
    
    //MARK: - Category
    @IBAction func btnCategoryClicked(_ sender: Any) {
        //Show Picker View
        viewPickerViewContainer.isHidden = false
        
        //Reload Picker View
        pickerView.tag = FilterType.CATEGORY
        pickerView.reloadAllComponents()
    }
    
    //MARK: - Country
    @IBAction func btnCountryClicked(_ sender: Any) {
        //Show Picker View
        viewPickerViewContainer.isHidden = false
        
        //Reload Picker View
        pickerView.tag = FilterType.COUNTRY
        pickerView.reloadAllComponents()
    }
    
    //MARK: - Publisher
    @IBAction func btnPublisherClicked(_ sender: Any) {
        //Show Picker View
        viewPickerViewContainer.isHidden = false
        
        //Reload Picker View
        pickerView.tag = FilterType.PUBLISHER
        pickerView.reloadAllComponents()
    }
    
    //MARK: - Filter
    @IBAction func btnFilterClicked(_ sender: Any) {
        //Hide View
        hideSelf()
    }
    
    
    
    //MARK: - Picker View
    //MARK: - UIPickerView Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == FilterType.CATEGORY {
            return arrayCategory.count
        }else if pickerView.tag == FilterType.COUNTRY {
            return arrayCountry.count
        }else {
            return arrayPublisher.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == FilterType.CATEGORY {
            return arrayCategory[row]
        }else if pickerView.tag == FilterType.COUNTRY {
            return arrayCountry[row]
        }else {
            return arrayPublisher[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == FilterType.CATEGORY {
            selectedIndexForCategorty = row
        }else if pickerView.tag == FilterType.COUNTRY {
            selectedIndexForCountries = row
        }else {
            selectedIndexForPublisher = row
        }
    }
    
    //MARK: - Cancel
    @IBAction func btnCancel_PickerViewClicked(_ sender: Any) {
        viewPickerViewContainer.isHidden = true
    }
    
    //MARK: - Done
    @IBAction func btnDone_PickerViewClicked(_ sender: Any) {
        viewPickerViewContainer.isHidden = true
        
        if pickerView.tag == FilterType.CATEGORY {
            self.btnCategory.setTitle(arrayCategory[selectedIndexForCategorty], for: .normal)
        }else if pickerView.tag == FilterType.COUNTRY {
            self.btnCountry.setTitle(arrayCategory[selectedIndexForCountries], for: .normal)
        }else {
            self.btnPublisher.setTitle(arrayCategory[selectedIndexForPublisher], for: .normal)
        }
    }
    
    
    
}
