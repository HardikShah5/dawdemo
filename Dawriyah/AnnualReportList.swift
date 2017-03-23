//
//  AnnualReportList.swift
//  Dawriyah
//
//  Created by Hardik Shah on 14/12/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class AnnualReportList: SuperViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var tableViewAnnualReport: UITableView!
    
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
        self.title = AppUtils.localized("ANNUAL_REPORT", value: "")
        
        //For RTL - Mehul December 29, 2016
        if UIView.userInterfaceLayoutDirection(for: btnFilter.semanticContentAttribute) == UIUserInterfaceLayoutDirection.rightToLeft {
            
            btnFilter.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
            btnFilter.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10)
            btnFilter.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 18)
            
            lblTotal.textAlignment = .left
        }
        
        GetAnnualReportList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //GET DATA
    func GetAnnualReportList() -> Void{
        //Start Loading
        AppUtils.startLoading(view: self.view)
        
        NewsHandler.annualRport(String(PageCount), PageSize: String(PageSize)) { (responseObject, success) in
            print("Response : \(responseObject)")
            
            if(success){
                let issuccess = responseObject?.value(forKey: "success") as! Bool
                if issuccess{
                    let dicsData = responseObject?.value(forKey: "data") as! NSDictionary
                    if(self.PageCount >= dicsData.value(forKey: "last_page") as! Int){
                        self.IsMoreRecordsAvailbale = false
                    }
                    
//                    self.lblTotal.text = dicsData.value(forKey: "total") as? String
                    
                    if self.arrayOfWSData.count <= 0 {
                        self.arrayOfWSData = dicsData.value(forKey: "reports") as! [NSDictionary]
                    }else {
                        self.arrayOfWSData.append(contentsOf: dicsData.value(forKey: "reports") as! [NSDictionary])
                    }
                    print("Response : \(self.arrayOfWSData)")
                    
                    
                    self.tableViewAnnualReport.reloadData()
                    
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
        let cellIdentifier = "AnnualReportCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! AnnualReportCell
        
        let dictionary = self.arrayOfWSData[indexPath.row]
        
        cell.lblReportTitle.text = dictionary.value(forKey: "report") as? String!
        cell.lblLanguage.text = dictionary.value(forKey: "language_ar") as? String!
        cell.lblCountry.text = dictionary.value(forKey: "country") as? String!
        cell.lblClassification.text = dictionary.value(forKey: "classification") as? String!
        cell.lblFreq.text = dictionary.value(forKey: "freq") as? String!
        
        cell.lblDatePublish.text = dictionary.value(forKey: "publishdate") as? String!
        cell.lblDateHistory.text = dictionary.value(forKey: "dateto") as? String!
        
        if indexPath.row == self.arrayOfWSData.count - 1 && self.IsMoreRecordsAvailbale {
            PageCount = PageCount + 1
            self.GetAnnualReportList()
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
