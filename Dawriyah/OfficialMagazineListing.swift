//
//  OfficialMagazineListing.swift
//  Dawriyah
//
//  Created by Hardik Shah on 07/12/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class OfficialMagazineListing: SuperViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var tblMagazine: UITableView!
    
    var viewFilter: Filter!
    
    var arrayOfWSData = [NSDictionary]()
    var PageCount = 1
    var PageSize = Constants.ItemsPerPage
    var IsMoreRecordsAvailbale = true;
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Title
        self.navigationItem.titleView = nil
        self.title = AppUtils.localized("OFFICAIL_MAGAZINE", value: "")
        
        
        //For RTL - Mehul December 29, 2016
        if UIView.userInterfaceLayoutDirection(for: btnFilter.semanticContentAttribute) == UIUserInterfaceLayoutDirection.rightToLeft {
            
            btnFilter.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
            btnFilter.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10)
            btnFilter.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 18)
            
            lblTotal.textAlignment = .left
        }
        
        magazinWS()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    //MARK: - magazine WS
    func magazinWS() -> Void {
        //Start Loading
        AppUtils.startLoading(view: self.view)
        
        NewsHandler.magazineList(String(PageCount), PageSize: String(self.PageSize)) { (responseObject, success) in
            print("Response : \(responseObject)")
            
            if(success){
                let issuccess = responseObject?.value(forKey: "success") as! Bool
                if(issuccess) {
                    let dicsData = responseObject?.value(forKey: "data") as! NSDictionary
                    
                    if(self.PageCount >= dicsData.value(forKey: "last_page") as! Int){
                        self.IsMoreRecordsAvailbale = false
                    }
                    
                    //Set Total Records Label
                    let strTotalRecords = dicsData.value(forKey: "total")
                    let strTotalStatic = AppUtils.localized("TOTAL", value: "")
                    
                    self.lblTotal.text = "\(strTotalStatic) \(strTotalRecords!)"
                    
                    
                    if self.arrayOfWSData.count <= 0 {
                        self.arrayOfWSData = dicsData.value(forKey: "freeMag") as! [NSDictionary]
                    }else {
                        self.arrayOfWSData.append(contentsOf: dicsData.value(forKey: "freeMag") as! [NSDictionary])
                    }
                    print("Response : \(self.arrayOfWSData)")
                    
                    self.tblMagazine.reloadData()
                }
            }
            //Stop Loading
            AppUtils.stopLoading()
        }
    }
    
    
    //MARK: - UITableView Delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfWSData.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "OfficialMagazineCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! OfficialMagazineCell
        //var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CellSignUp
        
        let dictionary = self.arrayOfWSData[indexPath.row]
        
        //Image
        let strImageURL = dictionary.value(forKey: "image") as? String
        let urlImage = URL(string: strImageURL!)
        cell.imageViewMagazine.setImageWith(urlImage!, placeholderImage: UIImage(named: "DefaultImg"))
        
        cell.lblTitle.text = dictionary.value(forKey: "title") as? String!
        cell.lblCategory.text = dictionary.value(forKey: "classification") as? String!
        cell.lblDate.text = dictionary.value(forKey: "publishingdate") as? String!
        cell.lblCountry.text = dictionary.value(forKey: "country") as? String!
        cell.lblLanguage.text = dictionary.value(forKey: "language_ar") as? String!
        cell.lblPublisher.text = dictionary.value(forKey: "publisher") as? String!
        
        if let rate = Int(dictionary.value(forKey: "rate") as! String) {
            cell.imgRating.image = UIImage(named: "Star\(rate)")
        }else {
            cell.imgRating.image = UIImage(named: "Star0")
        }
       
       
        if indexPath.row == self.arrayOfWSData.count - 1 && self.IsMoreRecordsAvailbale {
            PageCount = PageCount + 1
            self.magazinWS()
        }
        
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    //MARK: - Filter
    @IBAction func btnFilterClicked(_ sender: Any) {
        if viewFilter == nil {
            viewFilter = Bundle.main.loadNibNamed("Filter", owner: self, options: nil)?.first as! Filter
            AppUtils.APPDELEGATE().window?.addSubview(viewFilter)
        }
        viewFilter.isHidden = false
        
        viewFilter.setLayout()
        AppUtils.APPDELEGATE().window?.bringSubview(toFront: viewFilter)
    }
    
}
