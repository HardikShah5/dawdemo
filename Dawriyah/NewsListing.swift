//
//  NewsListing.swift
//  Dawriyah
//
//  Created by Hardik Shah on 26/11/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class NewsListing: SuperViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewNews: UITableView!
    
    var arrayNews = [NSDictionary]()
    let PageCount = 0
    let IsMoreRecordsAvailbale = true;
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Title
        self.navigationItem.titleView = nil
        self.title = AppUtils.localized("LATEST_NEWS", value: "")
        
        tableViewNews.estimatedRowHeight = 110
        tableViewNews.rowHeight = UITableViewAutomaticDimension
        
        //Call web service for getting News
        self.newsWS()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - News WS
    func newsWS() -> Void {
        //Start Loading
        AppUtils.startLoading(view: self.view)
        
        NewsHandler.latestNews(String(PageCount), PageSize: "10") { (responseObject, success) in
            print("Response : \(responseObject)")
            if(success){
            let issuccess = responseObject?.value(forKey: "success") as! Bool
            if(issuccess) {
                let dicsData = responseObject?.value(forKey: "data") as! NSDictionary
                self.arrayNews = dicsData.value(forKey: "news") as! [NSDictionary]
                print("Response : \(self.arrayNews)")
                
                self.tableViewNews.reloadData()
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
        return self.arrayNews.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "NewsListing"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CellNewsListing
        //var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CellSignUp
        
        let dictionary = self.arrayNews[indexPath.row]
        
        cell.newsTitle.text = dictionary.value(forKey: "NTitle") as? String
        cell.newsSubTitle.text = dictionary.value(forKey: "NBody") as? String
        cell.newsDate.text = dictionary.value(forKey: "NPosteddate") as? String
        
        let strImageURL = dictionary.value(forKey: "NImg") as? String
        let urlImage = URL(string: strImageURL!)
        cell.imgNews.setImageWith(urlImage!, placeholderImage: UIImage(named: "DefaultImg"))
        
        /*
        cell.newsTitle.text = "مادلين مطر: لهذا السبب عزُّوا راغب علامة ولم يعزُّوني;"
        cell.newsSubTitle.text = "اختارت الفنانة دنيا باطما أن تؤدي الأغنية المغربية الشهيرة \"ياك أجرحي\" لقيدومة ..."
        cell.newsDate.text = "08/22/2016"
        */
        
        cell.bgView.layer.cornerRadius = 4.0
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsDVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.NEWS_DETAILS) as! NewsDetail
        
        self.navigationController?.pushViewController(newsDVC, animated: true)
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
