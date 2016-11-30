//
//  FBTwitterPost.swift
//  Dawriyah
//
//  Created by Hardik Shah on 30/11/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class FBTwitterPost: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "FBTwitterPostCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! FBTwitterPostCell
        
        cell.lblTitle.text = "منى أبوسليمان"
        cell.lblSubTitle.text = "ودي اني قدرت ارد على الجميع ولكن محبتكم كبيرة و كثيرة علي الحمدلله الذي تصبحون على خير أظهر الحسن و ستر القبيح فينا"
        cell.lblDate.text = " م 04:10:00 16/09/2016"
        
        return cell
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