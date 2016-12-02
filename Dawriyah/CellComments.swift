//
//  CellComments.swift
//  Dawriyah
//
//  Created by Hardik Shah on 02/12/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class CellComments: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        bgView.layer.cornerRadius = 5.0;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
