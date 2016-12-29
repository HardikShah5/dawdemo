//
//  FBTWProfile.swift
//  Dawriyah
//
//  Created by Hardik Shah on 02/12/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class FBTWProfile: SuperViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tblComment: UITableView!
    @IBOutlet weak var ProfileTitle: UILabel!
    @IBOutlet weak var ProfileImage: UIImageView!
    
    var isForTwitter: Bool = false
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        
        tblComment.estimatedRowHeight = 68
        tblComment.rowHeight = UITableViewAutomaticDimension
        
        ProfileTitle.text = "منى أبوسليمان"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    //MARK: - UITableView Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CellComments"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CellComments
        
        cell.lblComment.text = "ودي اني قدرت ارد على الجميع ولكن محبتكم كبيرة و كثيرة علي الحمدلله الذي تصبحون "
        cell.lblDate.text = "04:10:00 16/09/2016"
        
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
