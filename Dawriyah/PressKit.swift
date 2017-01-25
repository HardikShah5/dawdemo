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
    
    var arrayOfWSData = [NSDictionary]()
    var PageCount = 1
    var PageSize = Constants.ItemsPerPage
    
    var IsMoreRecordsAvailbale = true
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //Title
        self.navigationItem.titleView = nil
        self.title = AppUtils.localized("PRESS_KIT", value: "")
        
        
        //Resgister Cell
        collectionViewPressKit.register(UINib(nibName: "CellCollectionViewCustom", bundle: nil), forCellWithReuseIdentifier: "CellData")
        
        //Get Press Kit News
        self.getPressKitNews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Press Kit News
    func getPressKitNews() -> Void {
        //Start Loading
        AppUtils.startLoading(view: self.view)
        
        NewsHandler.getPressNews(String(PageCount), PageSize: String(PageSize)) { (responseObject, success) in
            print("Response : \(responseObject)")
            
            if(success){
                let issuccess = responseObject?.value(forKey: "success") as! Bool
                if issuccess {
                    let dicsData = responseObject?.value(forKey: "data") as! NSDictionary
                    if(self.PageCount >= dicsData.value(forKey: "last_page") as! Int){
                        self.IsMoreRecordsAvailbale = false
                    }
                    if self.arrayOfWSData.count <= 0 {
                        self.arrayOfWSData = dicsData.value(forKey: "news") as! [NSDictionary]
                    }else {
                        self.arrayOfWSData.append(contentsOf: dicsData.value(forKey: "news") as! [NSDictionary])
                    }
                    print("Response : \(self.arrayOfWSData)")
                    
                    self.collectionViewPressKit.reloadData()
                }
            }
            //Stop Loading
            AppUtils.stopLoading()
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
        return self.arrayOfWSData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellData", for: indexPath) as! CellCollectionViewCustom
        
        let dict = arrayOfWSData[indexPath.row]
        
        //Image URL
        if dict.value(forKey: "image1") is NSNull {
            cell.imageViewPost.image = UIImage(named: "DefaultImg")
        }else {
            let strImageURL = Constants.IMAGE_PREFIX + (dict.value(forKey: "image1") as! String)
            let url = URL(string: strImageURL)
            //cell.imageViewPost.setImageWith(url!)
            cell.imageViewPost.setImageWith(url!, placeholderImage: UIImage(named: "DefaultImg"))
        }
        
        //Set First Text
        cell.lblTitle.text  = dict.value(forKey: "Title") as? String
        cell.lblDescription.text = dict.value(forKey: "NewsBody") as? String
        cell.lblDate.text = dict.value(forKey: "PublishDate") as? String
        
        //Layer Properties
        cell.layer.cornerRadius = 3.0
        cell.layer.masksToBounds = true
        
        //For getting more records
        if indexPath.row == self.arrayOfWSData.count - 1 && self.IsMoreRecordsAvailbale {
            PageCount = PageCount + 1
            self.getPressKitNews()
        }
        
        return cell
    }

}
