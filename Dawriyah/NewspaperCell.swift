//
//  NewspaperCell.swift
//  Dawriyah
//
//  Created by Hardik Shah on 10/12/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class NewspaperCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var btnClickHereToDownload: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.layer.cornerRadius = Constants.CornerRaius
        
        //For RTL - Mehul December 29, 2016
        if UIView.userInterfaceLayoutDirection(for: btnClickHereToDownload.semanticContentAttribute) == UIUserInterfaceLayoutDirection.rightToLeft {
            
            btnClickHereToDownload.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
            btnClickHereToDownload.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10)
            btnClickHereToDownload.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
