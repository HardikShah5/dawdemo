//
//  PressKit.swift
//  Dawriyah
//
//  Created by MehulS on 14/12/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class PressKit: SuperViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionViewPressKit: UICollectionView!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //Title
        self.navigationItem.titleView = nil
        self.title = AppUtils.localized("PRESS_KIT", value: "")
        
        
        //Resgister Cell
        collectionViewPressKit.register(UINib(nibName: "CellCollectionViewCustom", bundle: nil), forCellWithReuseIdentifier: "CellData")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - UICollectionView Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width - 20, height: 110)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellData", for: indexPath) as! CellCollectionViewCustom
        
        
        //For temporary Purpose
        if collectionView.tag == TOP_RATED_NEWS {
            cell.imageViewPost.image = UIImage(named: "news_stripe_img.png")
        }else if collectionView.tag == MOST_POPULAR_NEWS {
            cell.imageViewPost.image = UIImage(named: "presskit_img@3x.png")
        }else if collectionView.tag == ELECTRONIC_PRESS {
            cell.imageViewPost.image = UIImage(named: "SliderImage.png")
        }
        
        cell.lblTitle.text = "نوددجي نونطاوم ..نيزنبلا_عطاقن_حار ةديدجلا #راعسألل مهضفر ةديدجلا"
        cell.lblDescription.text = "د أحمد بصفر ينال براءتي اختراع أوروبية عن مركبات بوليمرات لمحاكاة أنسجة جسم الإنسان تساعد في العلاج الإ ..."
        //Layer Properties
        cell.layer.cornerRadius = 3.0
        cell.layer.masksToBounds = true
        
        return cell
    }

}
