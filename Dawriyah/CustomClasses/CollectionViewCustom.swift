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
    var arrayData = [NSDictionary]()

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
        self.frame = CGRect(x: viewCTR.view.frame.size.width, y: 114, width: viewCTR.view.frame.size.width, height: viewCTR.navigationController!.view.frame.size.height - 114)
        viewCTR.view.window?.addSubview(self)
        viewCTR.view.window?.bringSubview(toFront: self)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = CGRect(x: 0, y: 114, width: viewCTR.view.frame.size.width, height: viewCTR.navigationController!.view.frame.size.height - 114)
        })
        
        //Resgister Cell
        collectionViewData.register(UINib(nibName: "CellCollectionViewCustom", bundle: nil), forCellWithReuseIdentifier: "CellData")
        
        //collectionViewData.reloadData()
    }
    
    func showDataWithArray(array: [NSDictionary]) -> Void {
        arrayData = array
        
        if arrayData.count > 0 {
            collectionViewData.reloadData()
        }
    }
    
    
    //MARK: - UICollectionView Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width - 20, height: 110)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellData", for: indexPath) as! CellCollectionViewCustom
    
        let dict = arrayData[indexPath.row]
        
        //Image URL
        let strImageURL = /*Constants.IMAGE_PREFIX + */(dict.value(forKey: "image1") as! String)
        let url = URL(string: strImageURL)
        //cell.imageViewPost.setImageWith(url!)
        cell.imageViewPost.setImageWith(url!, placeholderImage: UIImage(named: "DefaultImg"))
        
        //Set First Text
        cell.lblTitle.text          = dict.value(forKey: "title") as? String
        cell.lblDescription.text    = dict.value(forKey: "body") as? String
        cell.lblDate.text           = dict.value(forKey: "publishdate") as? String
        
        //Layer Properties
        cell.layer.cornerRadius     = 3.0
        cell.layer.masksToBounds    = true
        
        return cell
    }

}
