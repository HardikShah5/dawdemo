//
//  FBTwitterPostCell.swift
//  Dawriyah
//
//  Created by Hardik Shah on 30/11/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class FBTwitterPostCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.cornerRadius = 5.0;
    }
}
