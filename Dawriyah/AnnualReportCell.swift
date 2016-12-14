//
//  AnnualReportCell.swift
//  Dawriyah
//
//  Created by Hardik Shah on 14/12/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class AnnualReportCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
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
