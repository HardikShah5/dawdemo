//
//  CollectionViewCustom.swift
//  Dawriyah
//
//  Created by MehulS on 01/12/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class CollectionViewCustom: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionViewData: UICollectionView!
    
    var viewCTRParent: UIViewController!

    func getCollectionView() -> CollectionViewCustom {
        let arrayNIBs: NSArray! = Bundle.main.loadNibNamed("CollectionViewCustom", owner: self, options: nil) as NSArray!
        for object in arrayNIBs {
            if (object as AnyObject).isKind(of: CollectionViewCustom.self) {
                return object as! CollectionViewCustom
            }
        }
        return ((Bundle.main.loadNibNamed("CollectionViewCustom", owner: self, options: nil) as AnyObject) as? CollectionViewCustom)!
    }
    
    func showCollectionViewIn(viewCTR: UIViewController) {
        
        viewCTRParent = viewCTR
        
        //Delegate and Data source to Table view
        collectionViewData.delegate = self
        collectionViewData.dataSource = self
        
        
        //Set frame and add slider menu
        self.frame = CGRect(x: viewCTR.view.frame.size.width, y: 104, width: viewCTR.view.frame.size.width, height: viewCTR.navigationController!.view.frame.size.height - 104)
        viewCTR.view.window?.addSubview(self)
        viewCTR.view.window?.bringSubview(toFront: self)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = CGRect(x: 0, y: 104, width: viewCTR.view.frame.size.width, height: viewCTR.navigationController!.view.frame.size.height - 104)
        })
        
        //Resgister Cell
        
        collectionViewData.register(UINib(nibName: "CellCollectionViewCustom", bundle: nil), forCellWithReuseIdentifier: "CellData")
        
        collectionViewData.reloadData()
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
        
        //Layer Properties
        cell.layer.cornerRadius = 3.0
        cell.layer.masksToBounds = true
        
        return cell
    }

}
