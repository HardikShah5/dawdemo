//
//  CellLanguage.swift
//  Dawriyah
//
//  Created by MehulS on 06/04/17.
//  Copyright © 2017 MehulS. All rights reserved.
//

import UIKit

class CellLanguage: UITableViewCell {
    
    @IBOutlet weak var btnSelectLanguage: UIButton!
    @IBOutlet weak var btnEnglish: UIButton!
    @IBOutlet weak var btnArabic: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
