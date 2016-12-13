//
//  NewsDetail.swift
//  Dawriyah
//
//  Created by Hardik Shah on 27/11/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class NewsDetail: SuperViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var constraintWidth_CollectionView: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Title
        self.title = AppUtils.localized("FULL_NEWS", value: "")
        
        
        constraintWidth_CollectionView.constant = (self.view.frame.size.width * 10)
        scrollView.contentSize = collectionView.frame.size
        //scrollView.contentSize = CGSize(width: collectionView.contentSize.width, height: collectionView.contentSize.height)
        
        collectionView.reloadData()
        print(collectionView.frame)
        
        
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
    }

}
