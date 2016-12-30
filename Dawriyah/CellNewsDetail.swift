//
//  CellNewsDetail.swift
//  Dawriyah
//
//  Created by MehulS on 12/12/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class CellNewsDetail: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate {
    
    //CellNewsDetails
    @IBOutlet weak var tableViewNewsDetails: UITableView!
    
    
    
    //MARK: - UITableView Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            //For Image
            return 200
        }else if indexPath.row == 1 {
            //News Info
            return 369
        }else if indexPath.row == 2 {
            //Comment
            return 143
        }else if indexPath.row == 3 {
            //SignUp
            return 85
        }else {
            //People's Comment
            return 108
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CellImage"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CellNewsDetailTable
        cell.backgroundColor = UIColor.clear
        
        if indexPath.row == 0 {
            //For Image
        }else if indexPath.row == 1 {
            //News Info
            cell = tableView.dequeueReusableCell(withIdentifier: "CellInfo") as! CellNewsDetailTable
            cell.backgroundColor = UIColor.white
        }else if indexPath.row == 2 {
            //Comment
            cell = tableView.dequeueReusableCell(withIdentifier: "CellComment") as! CellNewsDetailTable
            cell.backgroundColor = UIColor.clear
        }else if indexPath.row == 3 {
            //CellSignUp
            cell = tableView.dequeueReusableCell(withIdentifier: "CellSignUp") as! CellNewsDetailTable
            cell.backgroundColor = UIColor.clear
        }else {
            //CellPeopleComments
            cell = tableView.dequeueReusableCell(withIdentifier: "CellPeopleComments") as! CellNewsDetailTable
            cell.backgroundColor = UIColor.clear
        }
        
        
        cell.selectionStyle = .none
        return cell
    }
    
}
