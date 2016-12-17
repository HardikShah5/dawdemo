//
//  CellNewsDetailTable.swift
//  Dawriyah
//
//  Created by MehulS on 17/12/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class CellNewsDetailTable: UITableViewCell {
    
    //CellImage
    @IBOutlet weak var imageViewNews: UIImageView!
    
    //CellInfo
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    
    //CellComment
    @IBOutlet weak var textViewComment: UITextView!
    
    //CellSignUp
    @IBOutlet weak var btnSignUp: UIButton!
    
    //CellPeopleComments
    @IBOutlet weak var imageViewPeople: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPeopleComment: UILabel!
    @IBOutlet weak var lblCommentDate: UILabel!
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
