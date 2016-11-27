//
//  NewsListing.swift
//  Dawriyah
//
//  Created by Hardik Shah on 26/11/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class NewsListing: SuperViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "أحدث الأخبار";
        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - UITableView Delegates

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "NewsListing"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CellNewsListing
        //var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CellSignUp
        
        cell.newsTitle.text = "مادلين مطر: لهذا السبب عزُّوا راغب علامة ولم يعزُّوني;"
        cell.newsSubTitle.text = "اختارت الفنانة دنيا باطما أن تؤدي الأغنية المغربية الشهيرة \"ياك أجرحي\" لقيدومة ..."
        cell.newsDate.text = "08/22/2016"
        
        cell.bgView.layer.cornerRadius = 4.0
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetail") as! NewsDetail
        self.navigationController?.pushViewController(newsDetailVC, animated: true)
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
