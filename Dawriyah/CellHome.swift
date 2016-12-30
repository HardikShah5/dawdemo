//
//  CellHome.swift
//  Dawriyah
//
//  Created by MehulS on 01/12/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class CellHome: UITableViewCell {
    
    //News Header
    @IBOutlet weak var imageViewNews: UIImageView!
    @IBOutlet weak var lblTitleNews: UILabel!
    @IBOutlet weak var lblSubTitleNews: UILabel!
    @IBOutlet weak var scrollViewNewsImages: UIScrollView!
    @IBOutlet weak var btnPreviousNews: UIButton!
    @IBOutlet weak var btnNextNews: UIButton!
    
    
    //Header Section
    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var lblTitleHeader: UILabel!
    
    //Header Section - Facebook And Twitter
    @IBOutlet weak var lblTweets: UILabel!
    @IBOutlet weak var lblFacebookPost: UILabel!
    
    //CellClubPlayer
    @IBOutlet weak var btnClubs: UIButton!
    @IBOutlet weak var btnPlayers: UIButton!
    
    //CellCollectionView
    @IBOutlet weak var collectionView: UICollectionView!
    
    //CellVote
    @IBOutlet weak var btnExcellent: UIButton!
    @IBOutlet weak var btnGood: UIButton!
    @IBOutlet weak var btnAcceptable: UIButton!
    
    
    //Advertisement
    @IBOutlet weak var imageViewAd: UIImageView!
    @IBOutlet weak var btnPreviousAd: UIButton!
    @IBOutlet weak var btnNextAd: UIButton!
    
    
    //Footer
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
