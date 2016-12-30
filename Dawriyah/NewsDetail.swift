//
//  NewsDetail.swift
//  Dawriyah
//
//  Created by Hardik Shah on 27/11/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class NewsDetail: SuperViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Title
        self.title = AppUtils.localized("FULL_NEWS", value: "")
        
        /*
        var x: CGFloat = 0.0
        var height: CGFloat = 0.0
        for _ in 0...9 {
            let viewContainer = UIView()
            viewContainer.backgroundColor = UIColor.clear
            
            //View News Info
            let viewNews: ViewNewsInfo = Bundle.main.loadNibNamed("ViewNewsInfo", owner: self, options: nil)?.first as! ViewNewsInfo
            
            viewNews.frame = CGRect(x: 0, y: 0.0, width: self.view.frame.size.width, height: viewNews.frame.size.height)
            viewNews.backgroundColor = UIColor.red
            
            viewContainer.addSubview(viewNews)
            
            //Comments
            var y: CGFloat = viewNews.frame.size.height
            for _ in 0...2 {
                let viewComment: ViewNewsComment = Bundle.main.loadNibNamed("ViewNewsComment", owner: self, options: nil)?.first as! ViewNewsComment
                
                
                viewComment.frame = CGRect(x: 0, y: y, width: self.view.frame.size.width, height: viewComment.frame.size.height)
                
                y = y + viewComment.frame.size.height + 10
                
                viewContainer.addSubview(viewComment)
            }
            
            viewContainer.frame = CGRect(x: x, y: 0, width: self.view.frame.size.width, height: y)
            scrollView.addSubview(viewContainer)
            //viewContainer.translatesAutoresizingMaskIntoConstraints = true
            
            height = viewContainer.frame.size.height
            
            x = x + self.view.frame.size.width
        }
        scrollView.contentSize = CGSize(width: x, height: height)
        */
        
        /*
        constraintWidth_CollectionView.constant = (self.view.frame.size.width * 10)
        scrollView.contentSize = collectionView.frame.size
        //scrollView.contentSize = CGSize(width: collectionView.contentSize.width, height: collectionView.contentSize.height)
        
        collectionView.reloadData()
        print(collectionView.frame)
        */
        
        //lblNewsTitle.text = "test asdfsdfsdf";
        //lblNewsTitle.text = "بالفيديو: هل ستنتقل دنيا باطما إلى التمثيل؟"
        //lblNewsDesc.text = "اختارت الفنانة دنيا باطما أن تؤدي الأغنية المغربية الشهيرة ياك أجرحي لقيدومة الطرب المغربي نعيمة سميح ، وذلك في الحفل الختامي لسهرات مهرجان أصوات نسائية في دورته التاسعة بمدينة تطوان (شمال المغرب) ، حيث خصص المهرجان تكريماً خاصاً لنجمة الطرب المغربي الأصيل نعيمة سميح ، التي اختارت التواري عن الأضواء والاستمتاع بوقتها مع عائلتها ."
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: - UICollectionView Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width, height: self.view.frame.size.height)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellIdentifier = "CellNewsDetails"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CellNewsDetail
        cell.backgroundColor = UIColor.clear
        
        //Reload TableView
        cell.tableViewNewsDetails.backgroundColor = UIColor.clear
        cell.tableViewNewsDetails.reloadData()
        
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    //MARK: - UICollectionView Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView.tag == 111 {
            return CGSize(width: collectionView.frame.size.width, height: 100)
        }
        return CGSize(width: collectionView.frame.size.width - 10, height: CGFloat.greatestFiniteMagnitude)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 111 {
            return 3
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 111 {
            let cellIdentifier = "CellComment"
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
            return cell
        }
        
        let cellIdentifier = "CellNewsInfo"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CellNewsDetail
        
        //        cell.lblTitle.text = "منى أبوسليمان"
        //        cell.lblSubTitle.text = "ودي اني قدرت ارد على الجميع ولكن محبتكم كبيرة و كثيرة علي الحمدلله الذي تصبحون على خير أظهر الحسن و ستر القبيح فينا"
        //        cell.lblDate.text = " م 04:10:00 16/09/2016"
        
        return cell
    }*/

}
