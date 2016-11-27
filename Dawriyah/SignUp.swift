//
//  SignUp.swift
//  Dawriyah
//
//  Created by MehulS on 24/11/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class SignUp: SuperViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var tableViewSignUp: UITableView!
    
    var strNavBarTitle = ""
    var arrayValues = [String]()
    var arrayIcons = [String]()
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Navigation Bar Title
        self.title = strNavBarTitle
        
        tableViewSignUp.contentInset = UIEdgeInsetsMake(64, 0, 70, 0)
        
        //Set Values
        arrayValues = ["", "الاسم بالكامل", "العنوان", "العنوان", "الجوال", "البلد", "رقم الهوية", "اسم المستخدم", "كلمة المرور", "تأكيد كلمة المرور", ""]
        
        //Set Image Icon
        arrayIcons = ["",
                       "Username",
                        "Location",
                        "Email",
                        "Phone",
                        "Country",
                        "IDNumber",
                        "UserNameSignUp",
                        "Password",
                        "Password",
                        ""]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Show Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Show Status Bar
        UIApplication.shared.setStatusBarHidden(false, with: .fade)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - UITableView Delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayValues.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 50
        }else if indexPath.row == arrayValues.count - 1 {
            return 156
        }
        return 55
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CellValues"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CellSignUp
        
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "CellHeader")  as! CellSignUp
        }else if indexPath.row == arrayValues.count - 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "CellVerification")  as! CellSignUp
        }else {
            cell.imageViewIcon.image = UIImage(named: arrayIcons[indexPath.row])
            //cell.txtValue.placeholder = arrayValues[indexPath.row]
            cell.txtValue.attributedPlaceholder = NSAttributedString(string:arrayValues[indexPath.row], attributes:[NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName :UIFont(name: "HelveticaNeue", size: 18)!])

        }
        
        return cell
    }

}
