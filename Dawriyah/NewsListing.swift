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
        
        cell.newsTitle.text = "News Title"
        cell.newsSubTitle.text = "News Subtitle"
        cell.newsDate.text = "Date: "
        
        cell.bgView.layer.cornerRadius = 4.0
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
