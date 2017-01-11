//
//  CellSignUp.swift
//  Dawriyah
//
//  Created by MehulS on 24/11/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class CellSignUp: UITableViewCell {
    
    //CellHeader
    @IBOutlet weak var btnParties: UIButton!
    @IBOutlet weak var btnNewUser: UIButton!
    
    @IBOutlet weak var lblNewUserSelected: UILabel!
    @IBOutlet weak var lblPartiesSelected: UILabel!
    
    
    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var txtValue: UITextField!
    @IBOutlet weak var constraintLeading_TextField: NSLayoutConstraint!
    
    //Verification Code
    @IBOutlet weak var lblVerificationCode: UILabel!
    @IBOutlet weak var btnTryAgain: UIButton!
    @IBOutlet weak var txtCode: UITextField!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
