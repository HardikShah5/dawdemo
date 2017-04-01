//
//  OfficialMagazineCell.swift
//  Dawriyah
//
//  Created by Hardik Shah on 07/12/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class OfficialMagazineCell: UITableViewCell {

    @IBOutlet weak var imageViewMagazine: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgRating: UIImageView!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblPublisher: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        bgView.layer.cornerRadius = Constants.CornerRaius;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
