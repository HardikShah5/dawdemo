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
    var dataDictionary = NSDictionary()
    
    
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
            let constraintRect = CGSize(width: tableView.frame.size.width - 30, height: .greatestFiniteMagnitude)
            
            let strTitle = self.dataDictionary.value(forKey: "NTitle") as? String
            let titleBox = strTitle?.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 17.0)!], context: nil)
            
            let strDetails = self.dataDictionary.value(forKey: "NBody") as? NSString
            let detailBox = strDetails?.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 15.0)!], context: nil)
            
            return (titleBox?.height)! + (detailBox?.height)! + 30
            //return 369
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
            let strImageURL = self.dataDictionary.value(forKey: "NImg") as? String
            let urlImage = URL(string: strImageURL!)
            cell.imageViewNews.setImageWith(urlImage!, placeholderImage: UIImage(named: "DefaultImg"))
            
        }else if indexPath.row == 1 {
            //News Info
            cell = tableView.dequeueReusableCell(withIdentifier: "CellInfo") as! CellNewsDetailTable
            cell.backgroundColor = UIColor.white
            
            cell.lblTitle.text = self.dataDictionary.value(forKey: "NTitle") as? String
            cell.lblDetails.text = self.dataDictionary.value(forKey: "NBody") as? String
            
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
