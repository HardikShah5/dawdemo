//
//  Home.swift
//  Dawriyah
//
//  Created by MehulS on 26/11/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class Home: SuperViewController, UICollectionViewDataSource,UICollectionViewDelegate {

    
    @IBOutlet weak var btnNewsDetail: UIButton!
    @IBOutlet weak var lblNewsTitle: UILabel!
    
    @IBOutlet weak var lblNewsSubTitle: UILabel!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Set Up Navigation Bar Buttons
        self.setupNavigationBar()
        
        lblNewsTitle.text = "يف ثلاثلا رودلا ىلإ ياروم";
        lblNewsSubTitle.text = "استكمل آندي موراي بطل ويمبلدون ما بدأه عندما حصد اللقب الأولمبي في ريو دي جانيرو وتغلب على";
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Set Up Navigation Bar Buttons
    func setupNavigationBar() -> Void {
        //Left Buttons
        let leftMenu = UIBarButtonItem(image: UIImage(named: "Menu")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(btnMenuClicked))
        
        let leftSearch = UIBarButtonItem(image: UIImage(named: "Search")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(btnSearchClicked))
        
        self.navigationItem.leftBarButtonItems = [leftMenu, leftSearch]
        
        
        //Right Button
        let rightMore = UIBarButtonItem(image: UIImage(named: "More")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(btnMoreClicked))
        
        self.navigationItem.rightBarButtonItem = rightMore
        
        
        //Title View
        let imageView = UIImageView(image: UIImage(named: "logo_nav")?.withRenderingMode(.alwaysOriginal))
        self.navigationItem.titleView = imageView
    }
    
    
    func btnMenuClicked() -> Void {
        print("Menu Clicked.")
    }
    
    func btnSearchClicked() -> Void {
        print("Search Clicked.")
    }

    func btnMoreClicked() -> Void {
        print("More Clicked.")
    }
    
    @IBAction func btnNewsDetailClicked(_ sender: Any) {
        let newsVC = self.storyboard?.instantiateViewController(withIdentifier: "NewsListing") as! NewsListing
        self.navigationController?.pushViewController(newsVC, animated: true)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "NewsCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! NewsCollectionViewCell
        
        if indexPath.row == 2{
            cell.bgImage.isHidden = false
        }else{
            cell.bgImage.isHidden = true;
        }
        
        
        
        return cell;
        
    }
}
