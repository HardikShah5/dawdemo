//
//  SignUp.swift
//  Dawriyah
//
//  Created by MehulS on 24/11/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

struct SignUpType {
    static let NewUser = 1
    static let Parties = 2
}

import UIKit

class SignUp: SuperViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var tableViewSignUp: UITableView!
    
    var strNavBarTitle = ""
    var arrayNewUser = [String]()
    var arrayParties = [String]()
    var arrayIconsNewUser = [String]()
    var arrayIconsParties = [String]()
    
    var indexLast: Int!
    
    
    var indexOfSignUpType: Int! = SignUpType.NewUser
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Navigation Bar Title
        self.title = strNavBarTitle
        
        tableViewSignUp.contentInset = UIEdgeInsetsMake(64, 0, 70, 0)
        
        //Set Values
        if AppUtils.isArabicLayout == true {
            //Arabic
            arrayNewUser = ["", "الاسم بالكامل", "العنوان", "العنوان", "الجوال", "البلد", "رقم الهوية", "اسم المستخدم", "كلمة المرور", "تأكيد كلمة المرور", ""]
            arrayParties = ["", "اسم الجهة", "وصف الجهة", "نوع الجهة", "الدولة", "العنوان", "الحى", "الرقم البريدى", "هاتف1", "هاتف2", "الفاكس", "بريد الكترونى", "الموقع الالكترونى", "اسم المستخدم", "كلمة المرور", "اعد كلمة المرور", ""]
        }else {
            //English
            arrayNewUser = ["", "Full Name", "Address", "Email", "Cell Phone", "Country", "ID Number", "User Name", "Password", "Confirm Password", ""]
            arrayParties = ["", "The Name", "Describe the", "The Type", "Country", "Address", "District", "Post Number", "Phone 1", "Phone 2", "Fax", "Email", "Website", "User Name", "Password", "Confirm Password", ""]
        }
        
        
        //Set Image Icon
        arrayIconsNewUser = ["", "Username", "Location", "Email", "Phone", "Country", "IDNumber", "UserNameSignUp", "Password", "Password", ""]
        arrayIconsParties = ["", "Username", "", "", "Country", "Location", "", "", "Phone", "Phone", "", "Email", "", "Username", "Password", "Password", ""]
        
        //Get Last Index
        if indexOfSignUpType == SignUpType.NewUser {
            indexLast = arrayNewUser.count - 1
        }else {
            indexLast = arrayParties.count - 1
        }
        self.tableViewSignUp.reloadData()
        
        
        //For Keyboard event
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
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
    
    
    //MARK: - Keyboard Events
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                self.tableViewSignUp.contentInset = UIEdgeInsetsMake(64, 0, keyboardSize.height, 0)
            }
        }
    }
    func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            self.tableViewSignUp.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
    
    
    //MARK: - UITextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    

    //MARK: - UITableView Delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if indexOfSignUpType == SignUpType.NewUser {
            return arrayNewUser.count
        }
        return arrayParties.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 50
        }else if indexPath.row == indexLast {
            return 156
        }
        return 55
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CellValues"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CellSignUp
        
        
        
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "CellHeader")  as! CellSignUp
            
            //Add Target
            cell.btnNewUser.addTarget(self, action: #selector(btnNewUserClicked), for: .touchUpInside)
            cell.btnParties.addTarget(self, action: #selector(btnPartiesClicked), for: .touchUpInside)
            
            if indexOfSignUpType == SignUpType.NewUser {
                cell.lblNewUserSelected.isHidden = false
                cell.lblPartiesSelected.isHidden = true
            }else {
                cell.lblNewUserSelected.isHidden = true
                cell.lblPartiesSelected.isHidden = false
            }
            
        }else if indexPath.row == indexLast {
            cell = tableView.dequeueReusableCell(withIdentifier: "CellVerification")  as! CellSignUp
        }else {
            
            if indexOfSignUpType == SignUpType.NewUser {
                cell.imageViewIcon.image = UIImage(named: arrayIconsNewUser[indexPath.row])
                cell.txtValue.attributedPlaceholder = NSAttributedString(string:arrayNewUser[indexPath.row], attributes:[NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(0.75), NSFontAttributeName :UIFont(name: "HelveticaNeue", size: 17)!])
                
                cell.imageViewIcon.isHidden = false
                cell.constraintLeading_TextField.constant = 58
            }else {
                //Set Delegate
                cell.txtValue.delegate = self
                
                cell.imageViewIcon.image = UIImage(named: arrayIconsParties[indexPath.row])
                cell.txtValue.attributedPlaceholder = NSAttributedString(string:arrayParties[indexPath.row], attributes:[NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(0.75), NSFontAttributeName :UIFont(name: "HelveticaNeue", size: 17)!])
                
                cell.imageViewIcon.isHidden = true
                cell.constraintLeading_TextField.constant = 15
            }
            
        }
        
        return cell
    }
    
    
    //MARK: - New User
    func btnNewUserClicked() -> Void {
        indexOfSignUpType = SignUpType.NewUser
        
        indexLast = arrayNewUser.count - 1
        
        //let indexPath = IndexPath(row: 0, section: 0)
        //self.tableViewSignUp.reloadRows(at: [indexPath], with: .fade)
        self.tableViewSignUp.reloadData()
    }
    
    //MARK: - Parties
    func btnPartiesClicked() -> Void {
        indexOfSignUpType = SignUpType.Parties
        
        indexLast = arrayParties.count - 1
        
        //let indexPath = IndexPath(row: 0, section: 0)
        //self.tableViewSignUp.reloadRows(at: [indexPath], with: .fade)
        self.tableViewSignUp.reloadData()
    }

}
