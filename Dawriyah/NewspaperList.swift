//
//  NewspaperList.swift
//  Dawriyah
//
//  Created by Hardik Shah on 10/12/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class NewspaperList: SuperViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblNewspaper: UITableView!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var lblTotal: UILabel!
 
    var viewFilter: Filter!
    
    var arrayOfWSData = [NSDictionary]()
    var PageCount = 1
    var PageSize = Constants.ItemsPerPage
    
    var IsMoreRecordsAvailbale = true
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Title
        self.navigationItem.titleView = nil
        self.title = AppUtils.localized("NEWSPAPER", value: "")
        
        
        //For RTL - Mehul December 29, 2016
        if UIView.userInterfaceLayoutDirection(for: btnFilter.semanticContentAttribute) == UIUserInterfaceLayoutDirection.rightToLeft {
            
            btnFilter.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
            btnFilter.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10)
            btnFilter.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 18)
            
            lblTotal.textAlignment = .left
        }
        
        GetNewsPaperList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //GET DATA
    func GetNewsPaperList() -> Void{
        //Start Loading
        AppUtils.startLoading(view: self.view)
        
        NewsHandler.newsPaper(String(PageCount), PageSize: String(PageSize)) { (responseObject, success) in
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
//                    print("Response : \(self.arrayOfWSData)")
                    
                    
                    self.tblNewspaper.reloadData()
                    
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
        let cellIdentifier = "NewspaperCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! NewspaperCell
        //var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CellSignUp
        
        let dictionary = self.arrayOfWSData[indexPath.row]
        
        cell.lblNewsTitle.text = dictionary.value(forKey: "product") as? String!
        cell.lblCategory.text = dictionary.value(forKey: "classification") as? String!
        cell.lblType.text = dictionary.value(forKey: "product_type") as? String!
        cell.lblCountry.text = dictionary.value(forKey: "country") as? String!
        cell.lblFrequency.text = dictionary.value(forKey: "freq") as? String!
        cell.lblISSN.text = dictionary.value(forKey: "issn") as? String!
        cell.lblPublisher.text = dictionary.value(forKey: "publisher") as? String!
//        cell.lblFigure.text = dictionary.value(forKey: "report") as? String!
        cell.lblLanguage.text = dictionary.value(forKey: "language_ar") as? String!
        cell.lblDescription.text = dictionary.value(forKey: "productdesc") as? String!
        cell.lblSubject.text = dictionary.value(forKey: "topic") as? String!
//        cell.lblElectronic.text = dictionary.value(forKey: "report") as? String!
        
        let strImageURL = dictionary.value(forKey: "logo") as? String
        let urlImage = URL(string: strImageURL!)
        cell.imgNews.setImageWith(urlImage!, placeholderImage: UIImage(named: "DefaultImg"))
        
        if indexPath.row == self.arrayOfWSData.count - 1 && self.IsMoreRecordsAvailbale {
            PageCount = PageCount + 1
            self.GetNewsPaperList()
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
