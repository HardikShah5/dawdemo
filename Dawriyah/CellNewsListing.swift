//
//  CellNewsListing.swift
//  Dawriyah
//
//  Created by Hardik Shah on 26/11/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class CellNewsListing: UITableViewCell {

    @IBOutlet weak var newsDate: UILabel!
     @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var newsSubTitle: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
