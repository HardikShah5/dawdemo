//
//  FBTWProfile.swift
//  Dawriyah
//
//  Created by Hardik Shah on 02/12/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class FBTWProfile: SuperViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tblComment: UITableView!
    @IBOutlet weak var ProfileTitle: UILabel!
    @IBOutlet weak var ProfileImage: UIImageView!
    
    //var WritterId: Int = 31
    var isForTwitter: Bool = false
    var arrayOfWSData = [NSDictionary]()
    var PageCount = 1
    var IsMoreRecordsAvailbale = true
    var dicsOfSelectedData = [NSDictionary]()
    var PageSize = Constants.ItemsPerPage
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Title View
        if AppUtils.isArabicLayout == true {
            titleViewForArabic()
        }else {
            titleViewForEnglish()
        }
        
        if isForTwitter == true {
            GetTwitterWritter()
        }else {
            GetFacebookWritter();
        }
        
        tblComment.estimatedRowHeight = 68
        tblComment.rowHeight = UITableViewAutomaticDimension
        
        ProfileTitle.text = dicsOfSelectedData[0].value(forKey: "Name") as? String
        
        let strImageURL = dicsOfSelectedData[0].value(forKey: "Img") as? String
        if (strImageURL != nil) {
            let urlImage = URL(string: strImageURL!)
            self.ProfileImage.setImageWith(urlImage!, placeholderImage: UIImage(named: "DefaultImg"))
        }
        
        self.ProfileImage.layer.cornerRadius = Constants.CornerRaius;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func titleViewForEnglish() -> Void {
        let viewTitle = UIView()
        viewTitle.backgroundColor = UIColor.clear
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 7, width: 30, height: 30))
        if isForTwitter == true {
            imageView.image = UIImage(named: "icn_twitter")?.withRenderingMode(.alwaysOriginal)
        }else {
            imageView.image = UIImage(named: "icn_facebook")?.withRenderingMode(.alwaysOriginal)
        }
        imageView.contentMode = .center
        viewTitle.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = true
        
        let lblTitle = UILabel(frame: CGRect(x: 30, y: 0, width: 150, height: 44))
        lblTitle.textAlignment = .left
        lblTitle.textColor = UIColor.white
        lblTitle.font = UIFont(name: "HelveticaNeue", size: 17.0)
        
        if isForTwitter == true {
            lblTitle.text = AppUtils.localized("TWITTER_TWEETS", value: "")
        }else {
            lblTitle.text = AppUtils.localized("FACEBOOK_POSTS", value: "")
        }
        lblTitle.sizeToFit()
        
        var rect = lblTitle.frame
        rect.size.height = 44
        lblTitle.frame = rect
        
        viewTitle.addSubview(lblTitle)
        lblTitle.translatesAutoresizingMaskIntoConstraints = true
        
        viewTitle.frame = CGRect(x: 0, y: 0, width: 30 + lblTitle.frame.size.width, height: 44)
        viewTitle.translatesAutoresizingMaskIntoConstraints = true
        
        self.navigationItem.titleView = viewTitle
    }
    
    func titleViewForArabic() -> Void {
        let viewTitle = UIView()
        viewTitle.backgroundColor = UIColor.clear
        
        let lblTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 44))
        lblTitle.textAlignment = .left
        lblTitle.textColor = UIColor.white
        lblTitle.font = UIFont(name: "HelveticaNeue", size: 17.0)
        
        if isForTwitter == true {
            lblTitle.text = AppUtils.localized("TWITTER_TWEETS", value: "")
        }else {
            lblTitle.text = AppUtils.localized("FACEBOOK_POSTS", value: "")
        }
        lblTitle.sizeToFit()
        
        var rect = lblTitle.frame
        rect.size.height = 44
        lblTitle.frame = rect
        
        viewTitle.addSubview(lblTitle)
        lblTitle.translatesAutoresizingMaskIntoConstraints = true
        
        
        let imageView = UIImageView(frame: CGRect(x: lblTitle.frame.size.width, y: 7, width: 30, height: 30))
        if isForTwitter == true {
            imageView.image = UIImage(named: "icn_twitter")?.withRenderingMode(.alwaysOriginal)
        }else {
            imageView.image = UIImage(named: "icn_facebook")?.withRenderingMode(.alwaysOriginal)
        }
        imageView.contentMode = .center
        viewTitle.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = true
        
        viewTitle.frame = CGRect(x: 0, y: 0, width: 30 + lblTitle.frame.size.width, height: 44)
        viewTitle.translatesAutoresizingMaskIntoConstraints = true
        
        self.navigationItem.titleView = viewTitle
    }
    func GetFacebookWritter() -> Void{
        //Start Loading
        AppUtils.startLoading(view: self.view)
        
        FBTwitterHandler.GetFacebookWriterPost(dicsOfSelectedData[0].value(forKey: "ID") as! String, CurrentPage: String(PageCount), PageSize: String(PageSize))
        { (responseObject, success) in
            print("Response : \(responseObject)")
            
            if(success){
                let issuccess = responseObject?.value(forKey: "success") as! Bool
                if issuccess{
                    let dicsData = responseObject?.value(forKey: "data") as! NSDictionary
                    if(self.PageCount >= dicsData.value(forKey: "last_page") as! Int){
                        self.IsMoreRecordsAvailbale = false
                    }
                    //                    self.arrayOfWSData = dicsData.value(forKey: "news") as! [NSDictionary]
                    if self.arrayOfWSData.count <= 0 {
                        self.arrayOfWSData = dicsData.value(forKey: "news") as! [NSDictionary]
                    }else {
                        self.arrayOfWSData.append(contentsOf: dicsData.value(forKey: "news") as! [NSDictionary])
                    }
                    print("Response : \(self.arrayOfWSData)")
                    
                    self.tblComment.reloadData()
                    
                }
            }
            //Stop Loading
            AppUtils.stopLoading()
        }
        
    }
    
    func GetTwitterWritter() -> Void{
        //Start Loading
        AppUtils.startLoading(view: self.view)
        
        FBTwitterHandler.GetTwitterWriterPost(dicsOfSelectedData[0].value(forKey: "ID") as! String, CurrentPage: String(PageCount), PageSize: String(PageSize))
        { (responseObject, success) in
            print("Response : \(responseObject)")
            
            if(success){
                let issuccess = responseObject?.value(forKey: "success") as! Bool
                if issuccess{
                    let dicsData = responseObject?.value(forKey: "data") as! NSDictionary
                    if(self.PageCount >= dicsData.value(forKey: "last_page") as! Int){
                        self.IsMoreRecordsAvailbale = false
                    }
//                    self.arrayOfWSData = dicsData.value(forKey: "news") as! [NSDictionary]
                    if self.arrayOfWSData.count <= 0 {
                        self.arrayOfWSData = dicsData.value(forKey: "news") as! [NSDictionary]
                    }else {
                        self.arrayOfWSData.append(contentsOf: dicsData.value(forKey: "news") as! [NSDictionary])
                    }
                    print("Response : \(self.arrayOfWSData)")
                    
                    self.tblComment.reloadData()
                    
                }
            }
            //Stop Loading
            AppUtils.stopLoading()
        }
        
    }
    
    //MARK: - UITableView Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfWSData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CellComments"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CellComments
        
        let dictionary = self.arrayOfWSData[indexPath.row]
        
        cell.lblComment.text = dictionary.value(forKey: "message") as? String
        cell.lblDate.text = dictionary.value(forKey: "created_time") as? String
        
        cell.selectionStyle = .none
        
        if indexPath.row == self.arrayOfWSData.count - 1 && self.IsMoreRecordsAvailbale {
            PageCount = PageCount + 1
            if (self.isForTwitter){
                self.GetTwitterWritter()
            }
            else{
                self.GetFacebookWritter()
            }
        }
        
        return cell
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
