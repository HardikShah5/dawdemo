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
    
    @IBOutlet weak var lblNewsTitle: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblFrequency: UILabel!
    @IBOutlet weak var lblISSN: UILabel!
    @IBOutlet weak var lblPublisher: UILabel!
    @IBOutlet weak var lblFigure: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblSubject: UILabel!
    @IBOutlet weak var lblElectronic: UILabel!
    @IBOutlet weak var imgNews: UIImageView!
    
    
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
