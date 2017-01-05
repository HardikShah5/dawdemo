//
//  FBTwitterPost.swift
//  Dawriyah
//
//  Created by Hardik Shah on 30/11/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class FBTwitterPost: SuperViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionViewTwitter: UICollectionView!
    
    var isForTwitter: Bool = false

    var arrayOfWSData = [NSDictionary]()
    var PageCount = 1
    let IsMoreRecordsAvailbale = true;
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //For showing Section at top while scrolling else in UICollectionView section scrolls with Rows
        if #available(iOS 9.0, *) {
            (collectionViewTwitter.collectionViewLayout as! UICollectionViewFlowLayout).sectionHeadersPinToVisibleBounds = true
        } else {
            // Fallback on earlier versions
        }
        
        //Title View
        if AppUtils.isArabicLayout == true {
            titleViewForArabic()
        }else {
            titleViewForEnglish()
        }
        
        if isForTwitter == true {
            GetTwitter()
        }else {
            GetFacebook()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func GetTwitter() -> Void{
        //Start Loading
        AppUtils.startLoading(view: self.view)
        
        FBTwitterHandler.GetTwittsData(String(PageCount), PageSize: "10") { (responseObject, success) in
            print("Response : \(responseObject)")
            
            if(success){
                let issuccess = responseObject?.value(forKey: "success") as! Bool
                if issuccess{
                    let dicsData = responseObject?.value(forKey: "data") as! NSDictionary
                    
                    if self.arrayOfWSData.count <= 0 {
                        self.arrayOfWSData = dicsData.value(forKey: "writers") as! [NSDictionary]
                    }else {
                        self.arrayOfWSData.append(contentsOf: dicsData.value(forKey: "writers") as! [NSDictionary])
                    }
                    print("Response : \(self.arrayOfWSData)")
                    
                    
                    self.collectionViewTwitter.reloadData()

                }
            }
            //Stop Loading
            AppUtils.stopLoading()
        }
        
    }
    
    func GetFacebook() -> Void{
        //Start Loading
        AppUtils.startLoading(view: self.view)
        
        FBTwitterHandler.GetFacebookData(String(PageCount), PageSize: "10") { (responseObject, success) in
            print("Response : \(responseObject)")
            
            if(success){
                let issuccess = responseObject?.value(forKey: "success") as! Bool
                if issuccess{
                    let dicsData = responseObject?.value(forKey: "data") as! NSDictionary
                    self.arrayOfWSData = dicsData.value(forKey: "writers") as! [NSDictionary]
                    print("Response : \(self.arrayOfWSData)")
                    
                    self.collectionViewTwitter.reloadData()
                    
                }
            }
            //Stop Loading
            AppUtils.stopLoading()
        }
        
    }
    
    func titleViewForEnglish() -> Void {
        let viewTitle = UIView()
        viewTitle.backgroundColor = UIColor.clear
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 7, width: 30, height: 30))
        if isForTwitter == true {
            imageView.image = UIImage(named: "icn_twitter")?.withRenderingMode(.alwaysOriginal)
        }else {
            imageView.image = UIImage(named: "icn_facebook")?.withRenderingMode(.alwaysOriginal)
        }
        imageView.contentMode = .center
        viewTitle.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = true
        
        let lblTitle = UILabel(frame: CGRect(x: 30, y: 0, width: 150, height: 44))
        lblTitle.textAlignment = .left
        lblTitle.textColor = UIColor.white
        lblTitle.font = UIFont(name: "HelveticaNeue", size: 17.0)
        
        if isForTwitter == true {
            lblTitle.text = AppUtils.localized("TWITTER_TWEETS", value: "")
        }else {
            lblTitle.text = AppUtils.localized("FACEBOOK_POSTS", value: "")
        }
        lblTitle.sizeToFit()
        
        var rect = lblTitle.frame
        rect.size.height = 44
        lblTitle.frame = rect
        
        viewTitle.addSubview(lblTitle)
        lblTitle.translatesAutoresizingMaskIntoConstraints = true
        
        viewTitle.frame = CGRect(x: 0, y: 0, width: 30 + lblTitle.frame.size.width, height: 44)
        viewTitle.translatesAutoresizingMaskIntoConstraints = true
        
        self.navigationItem.titleView = viewTitle
    }
    
    func titleViewForArabic() -> Void {
        let viewTitle = UIView()
        viewTitle.backgroundColor = UIColor.clear
        
        let lblTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 44))
        lblTitle.textAlignment = .left
        lblTitle.textColor = UIColor.white
        lblTitle.font = UIFont(name: "HelveticaNeue", size: 17.0)
        
        if isForTwitter == true {
            lblTitle.text = AppUtils.localized("TWITTER_TWEETS", value: "")
        }else {
            lblTitle.text = AppUtils.localized("FACEBOOK_POSTS", value: "")
        }
        lblTitle.sizeToFit()
        
        var rect = lblTitle.frame
        rect.size.height = 44
        lblTitle.frame = rect
        
        viewTitle.addSubview(lblTitle)
        lblTitle.translatesAutoresizingMaskIntoConstraints = true
        
        
        let imageView = UIImageView(frame: CGRect(x: lblTitle.frame.size.width, y: 7, width: 30, height: 30))
        if isForTwitter == true {
            imageView.image = UIImage(named: "icn_twitter")?.withRenderingMode(.alwaysOriginal)
        }else {
            imageView.image = UIImage(named: "icn_facebook")?.withRenderingMode(.alwaysOriginal)
        }
        imageView.contentMode = .center
        viewTitle.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = true
        
        viewTitle.frame = CGRect(x: 0, y: 0, width: 30 + lblTitle.frame.size.width, height: 44)
        viewTitle.translatesAutoresizingMaskIntoConstraints = true
        
        self.navigationItem.titleView = viewTitle
    }
    
    
    //MARK: - UICollectionView Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width - 16, height: 150)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfWSData.count;
    }
    
    /*func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableView : UICollectionReusableView? = nil
        
        // Create header
        if (kind == UICollectionElementKindSectionHeader) {
            // Create Header
            let headerView : CollectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderTwitter", for: indexPath as IndexPath) as! CollectionHeaderView
            headerView.HeaderTitle.text = "مغردو تويتر"
            reusableView = headerView
        }
        
        return reusableView!

    }*/
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "FBTwitterPostCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! FBTwitterPostCell
        
        let dictionary = self.arrayOfWSData[indexPath.row]
        
        cell.lblTitle.text = dictionary.value(forKey: "Name") as? String
        cell.lblSubTitle.text = "" // "ودي اني قدرت ارد على الجميع ولكن محبتكم كبيرة و كثيرة علي الحمدلله الذي تصبحون على خير أظهر الحسن و ستر القبيح فينا"
        cell.lblDate.text = "" // " م 04:10:00 16/09/2016"
        
        
        let strImageURL = dictionary.value(forKey: "Img") as? String
        let urlImage = URL(string: strImageURL!)
        cell.image.setImageWith(urlImage!, placeholderImage: UIImage(named: "DefaultImg"))
        
        if indexPath.row == self.arrayOfWSData.count - 1 {
            PageCount = PageCount + 1
            self.GetTwitter()
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //For selection Color
        //let cell = self.collectionViewTwitter.cellForItem(at: indexPath) as! FBTwitterPostCell
        //cell.backgroundColor = UIColor.lightGray
        
        
        //Navigation
        var detailVC: FBTWProfile!
        
        if isForTwitter == true {
            detailVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.TWITTER_DETAILS) as! FBTWProfile
        }else {
            detailVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.FACEBOOK_DETAILS) as! FBTWProfile
        }
        
        detailVC.isForTwitter = self.isForTwitter;
        print(self.arrayOfWSData)
        let dictionary = self.arrayOfWSData[indexPath.row]
        print("dic: ", dictionary["ID"] as! String)
        //detailVC.WritterId =  (dictionary.value(forKey: "ID") as? Int)! //(self.arrayOfWSData[indexPath.row].value(forKey: "ID") as? Int)!
        
        print(Int(dictionary["ID"] as! String)!)
        detailVC.WritterId =  Int(dictionary["ID"] as! String)!
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
