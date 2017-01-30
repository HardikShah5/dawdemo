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

struct SignUpNewUser {
    static let FullName         = 101
    static let Address          = 102
    static let Email            = 103
    static let CellPhone        = 104
    static let Country          = 105
    static let IDNumber         = 106
    static let UserName         = 107
    static let Password         = 108
    static let ConfirmPassword  = 109
    
}

struct SignUpParty {
    static let TheName          = 201
    static let DescribeThe      = 202
    static let TheType          = 203
    static let Country          = 204
    static let Address          = 205
    static let District         = 206
    static let PostNumber       = 207
    static let Phone1           = 208
    static let Phone2           = 209
    static let Fax              = 210
    static let Email            = 211
    static let Website          = 212
    static let UserName         = 213
    static let Password         = 214
    static let ConfirmPassword  = 215
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
    
    //For Getting value from UITextField : New User
    var strFullName:        String! = ""
    var strAddress:         String! = ""
    var strEmail:           String! = ""
    var strCellPhone:       String! = ""
    var strCountry:         String! = ""
    var strIDNumber:        String! = ""
    var strUserName:        String! = ""
    var strPassword:        String! = ""
    var strConfirmPassword: String! = ""
    
    //For Getting value from UITextField : New Party
    var strTheName_Party          : String! = ""
    var strDescribeThe_Party      : String! = ""
    var strTheType_Party          : String! = ""
    var strCountry_Party          : String! = ""
    var strAddress_Party          : String! = ""
    var strDistrict_Party         : String! = ""
    var strPostNumber_Party       : String! = ""
    var strPhone1_Party           : String! = ""
    var strPhone2_Party           : String! = ""
    var strFax_Party              : String! = ""
    var strEmail_Party            : String! = ""
    var strWebsite_Party          : String! = ""
    var strUserName_Party         : String! = ""
    var strPassword_Party         : String! = ""
    var strConfirmPassword_Party  : String! = ""
    
    
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if indexOfSignUpType == SignUpType.NewUser {
            //New User
            if textField.tag == SignUpNewUser.FullName {
                strFullName = textField.text
            }else if textField.tag == SignUpNewUser.Address {
                strAddress = textField.text
            }else if textField.tag == SignUpNewUser.Email {
                strEmail = textField.text
            }else if textField.tag == SignUpNewUser.CellPhone {
                strCellPhone = textField.text
            }else if textField.tag == SignUpNewUser.Country {
                strCountry = textField.text
            }else if textField.tag == SignUpNewUser.IDNumber {
                strIDNumber = textField.text
            }else if textField.tag == SignUpNewUser.UserName {
                strUserName = textField.text
            }else if textField.tag == SignUpNewUser.Password {
                strPassword = textField.text
            }else if textField.tag == SignUpNewUser.ConfirmPassword {
                strConfirmPassword = textField.text
            }
        }else {
            //Party
            if textField.tag == SignUpParty.TheName {
                strTheName_Party = textField.text
            }else if textField.tag == SignUpParty.DescribeThe {
                strDescribeThe_Party = textField.text
            }else if textField.tag == SignUpParty.TheType {
                strTheType_Party = textField.text
            }else if textField.tag == SignUpParty.Country {
                strCountry_Party = textField.text
            }else if textField.tag == SignUpParty.Address {
                strAddress_Party = textField.text
            }else if textField.tag == SignUpParty.District {
                strDistrict_Party = textField.text
            }else if textField.tag == SignUpParty.PostNumber {
                strPostNumber_Party = textField.text
            }else if textField.tag == SignUpParty.Phone1 {
                strPhone1_Party = textField.text
            }else if textField.tag == SignUpParty.Phone2 {
                strPhone2_Party = textField.text
            }else if textField.tag == SignUpParty.Fax {
                strFax_Party = textField.text
            }else if textField.tag == SignUpParty.Website {
                strWebsite_Party = textField.text
            }else if textField.tag == SignUpParty.Email {
                strEmail_Party = textField.text
            }else if textField.tag == SignUpParty.UserName {
                strUserName_Party = textField.text
            }else if textField.tag == SignUpParty.Password {
                strPassword_Party = textField.text
            }else if textField.tag == SignUpParty.ConfirmPassword {
                strConfirmPassword_Party = textField.text
            }
        }
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
                
                //Set Tag
                cell.txtValue.tag = 100 + indexPath.row
                
                cell.imageViewIcon.isHidden = false
                cell.constraintLeading_TextField.constant = 58
                
                //New User
                if cell.txtValue.tag == SignUpNewUser.FullName {
                    cell.txtValue.text = strFullName
                }else if cell.txtValue.tag == SignUpNewUser.Address {
                    cell.txtValue.text = strAddress
                }else if cell.txtValue.tag == SignUpNewUser.Email {
                    cell.txtValue.text = strEmail
                }else if cell.txtValue.tag == SignUpNewUser.CellPhone {
                    cell.txtValue.text = strCellPhone
                }else if cell.txtValue.tag == SignUpNewUser.Country {
                    cell.txtValue.text = strCountry
                }else if cell.txtValue.tag == SignUpNewUser.IDNumber {
                    cell.txtValue.text = strIDNumber
                }else if cell.txtValue.tag == SignUpNewUser.UserName {
                    cell.txtValue.text = strUserName
                }else if cell.txtValue.tag == SignUpNewUser.Password {
                    cell.txtValue.text = strPassword
                }else if cell.txtValue.tag == SignUpNewUser.ConfirmPassword {
                    cell.txtValue.text = strConfirmPassword
                }
                
            }else {
                //Set Delegate
                cell.txtValue.delegate = self
                
                cell.imageViewIcon.image = UIImage(named: arrayIconsParties[indexPath.row])
                cell.txtValue.attributedPlaceholder = NSAttributedString(string:arrayParties[indexPath.row], attributes:[NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(0.75), NSFontAttributeName :UIFont(name: "HelveticaNeue", size: 17)!])
                
                //Set Tag
                cell.txtValue.tag = 200 + indexPath.row
                
                cell.imageViewIcon.isHidden = true
                cell.constraintLeading_TextField.constant = 15
                
                //Parties
                if cell.txtValue.tag == SignUpParty.TheName {
                    cell.txtValue.text = strTheName_Party
                }else if cell.txtValue.tag == SignUpParty.DescribeThe {
                    cell.txtValue.text = strDescribeThe_Party
                }else if cell.txtValue.tag == SignUpParty.TheType {
                    cell.txtValue.text = strTheType_Party
                }else if cell.txtValue.tag == SignUpParty.Country {
                    cell.txtValue.text = strCountry_Party
                }else if cell.txtValue.tag == SignUpParty.Address {
                    cell.txtValue.text = strAddress_Party
                }else if cell.txtValue.tag == SignUpParty.District {
                    cell.txtValue.text = strDistrict_Party
                }else if cell.txtValue.tag == SignUpParty.PostNumber {
                    cell.txtValue.text = strPostNumber_Party
                }else if cell.txtValue.tag == SignUpParty.Phone1 {
                    cell.txtValue.text = strPhone1_Party
                }else if cell.txtValue.tag == SignUpParty.Phone2 {
                    cell.txtValue.text = strPhone2_Party
                }else if cell.txtValue.tag == SignUpParty.Fax {
                    cell.txtValue.text = strFax_Party
                }else if cell.txtValue.tag == SignUpParty.Email {
                    cell.txtValue.text = strEmail_Party
                }else if cell.txtValue.tag == SignUpParty.Website {
                    cell.txtValue.text = strWebsite_Party
                }else if cell.txtValue.tag == SignUpParty.UserName {
                    cell.txtValue.text = strUserName_Party
                }else if cell.txtValue.tag == SignUpParty.Password {
                    cell.txtValue.text = strPassword_Party
                }else if cell.txtValue.tag == SignUpParty.ConfirmPassword {
                    cell.txtValue.text = strConfirmPassword_Party
                }
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
    

    //MARK: - Sign Up
    @IBAction func btnSignUpClicked(_ sender: Any) {
        self.view.endEditing(true)
        
        if indexOfSignUpType == SignUpType.NewUser {
            self.doSignUpForNewUser()
        }else {
            self.doSignUpForNewParty()
        }
    }
    
    
    //MARK: - Sign Up - New User
    func doSignUpForNewUser() -> Void {
        //Validations
        if strFullName == "" {
            AppUtils.showAlertWith(Title: "", Message: "Please provide Full Name.", ForController: self)
        }else if strAddress == "" {
            AppUtils.showAlertWith(Title: "", Message: "Please provide Address.", ForController: self)
        }else if strEmail == "" {
            AppUtils.showAlertWith(Title: "", Message: "Please provide Email.", ForController: self)
        }else if AppUtils.validateEmail(strEmail) == false {
            AppUtils.showAlertWith(Title: "", Message: "Please provide valid Email.", ForController: self)
        }else if strCellPhone == "" {
            AppUtils.showAlertWith(Title: "", Message: "Please provide Cell Phone.", ForController: self)
        }else if strCountry == "" {
            AppUtils.showAlertWith(Title: "", Message: "Please provide Country.", ForController: self)
        }else if strIDNumber == "" {
            AppUtils.showAlertWith(Title: "", Message: "Please provide ID Number.", ForController: self)
        }else if strUserName == "" {
            AppUtils.showAlertWith(Title: "", Message: "Please provide UserName.", ForController: self)
        }else if strPassword == "" {
            AppUtils.showAlertWith(Title: "", Message: "Please provide Password.", ForController: self)
        }else if strConfirmPassword == "" {
            AppUtils.showAlertWith(Title: "", Message: "Please provide Confirm Password.", ForController: self)
        }else if strPassword != strConfirmPassword {
            AppUtils.showAlertWith(Title: "", Message: "Password and Confirm password should be same.", ForController: self)
        }else  {
            self.callSignUpNewUserWebService()
        }
    }
    
    func callSignUpNewUserWebService() -> Void {
        //Start Loading
        AppUtils.startLoading(view: self.view)
        
        UserHandler.registerNewUserWith(strFullName, address: strAddress, email: strEmail, cellPhone: strCellPhone, country: strCountry, IDNumber: strIDNumber, userName: strUserName, password: strPassword) { (responseObject, success) in
            
            print("Response : \(responseObject)")
            
            if success == false {
                AppUtils.showAlertWith(Title: "", Message: responseObject as! String, ForController: self)
            }else if Int(responseObject?.value(forKey: "success") as! String) == 1 {
                
                //Navigate To The Dashboard
                DispatchQueue.main.async {
                    self.navigateToDashboard()
                }
            }else {
                DispatchQueue.main.async {
                    AppUtils.showAlertWith(Title: "", Message: responseObject?.value(forKey: "error") as! String, ForController: self)
                }
            }
            
            //Stop Loading
            DispatchQueue.main.async {
                AppUtils.stopLoading()
            }
        }
    }
    
    //MARK: - Sign Up - New Party
    func doSignUpForNewParty() -> Void {
        //Validations
        if strTheName_Party == "" {
            AppUtils.showAlertWith(Title: "", Message: "Please provide Name.", ForController: self)
        }else if strDescribeThe_Party == "" {
            AppUtils.showAlertWith(Title: "", Message: "Please provide description.", ForController: self)
        }else if strTheType_Party == "" {
            AppUtils.showAlertWith(Title: "", Message: "Please provide the Type.", ForController: self)
        }else if strCountry_Party == "" {
            AppUtils.showAlertWith(Title: "", Message: "Please provide country.", ForController: self)
        }else if strAddress_Party == "" {
            AppUtils.showAlertWith(Title: "", Message: "Please provide address.", ForController: self)
        }else if strDistrict_Party == "" {
            AppUtils.showAlertWith(Title: "", Message: "Please provide district.", ForController: self)
        }else if strPostNumber_Party == "" {
            AppUtils.showAlertWith(Title: "", Message: "Please provide post number.", ForController: self)
        }else if strPhone1_Party == "" {
            AppUtils.showAlertWith(Title: "", Message: "Please provide Phone 1.", ForController: self)
        }else if strPhone2_Party == "" {
            AppUtils.showAlertWith(Title: "", Message: "Please provide Phone 2.", ForController: self)
        }else if strFax_Party == "" {
            AppUtils.showAlertWith(Title: "", Message: "Please provide Fax.", ForController: self)
        }else if strEmail_Party == "" {
            AppUtils.showAlertWith(Title: "", Message: "Please provide email address.", ForController: self)
        }else if AppUtils.validateEmail(strEmail_Party) == false {
            AppUtils.showAlertWith(Title: "", Message: "Please provide valid email address.", ForController: self)
        }else if strWebsite_Party == "" {
            AppUtils.showAlertWith(Title: "", Message: "Please provide web site.", ForController: self)
        }else if strUserName_Party == "" {
            AppUtils.showAlertWith(Title: "", Message: "Please provide UserName.", ForController: self)
        }else if strPassword_Party == "" {
            AppUtils.showAlertWith(Title: "", Message: "Please provide Password.", ForController: self)
        }else if strConfirmPassword_Party == "" {
            AppUtils.showAlertWith(Title: "", Message: "Please provide Confirm Password.", ForController: self)
        }else if strPassword_Party != strConfirmPassword_Party {
            AppUtils.showAlertWith(Title: "", Message: "Password and Confirm password should be same.", ForController: self)
        }else  {
            self.callSignUpPartyWebService()
        }
    }
    
    func callSignUpPartyWebService() -> Void {
        //Start Loading
        AppUtils.startLoading(view: self.view)
        
        UserHandler.registerPartyWith(strTheName_Party, companyDesc: strDescribeThe_Party, organization_id: strTheType_Party, countryCode: strCountry_Party, address: strAddress_Party, district: strDistrict_Party, postalcode: strPostNumber_Party, tele1: strPhone1_Party, tele2: strPhone2_Party, fax: strFax_Party, email1: strEmail_Party, username: strUserName_Party, password: strPassword_Party) { (responseObject, success) in
            
            print("Response : \(responseObject)")
            
            if success == false {
                AppUtils.showAlertWith(Title: "", Message: responseObject as! String, ForController: self)
            }else if Int(responseObject?.value(forKey: "success") as! String) == 1 {
                
                //Navigate To The Dashboard
                DispatchQueue.main.async {
                    self.navigateToDashboard()
                }
            }else {
                DispatchQueue.main.async {
                    AppUtils.showAlertWith(Title: "", Message: responseObject?.value(forKey: "error") as! String, ForController: self)
                }
            }
            
            //Stop Loading
            DispatchQueue.main.async {
                AppUtils.stopLoading()
            }
        }
    }
    
    
    //MARK: - Navigate To The Dashboard
    func navigateToDashboard() -> Void {
        let homeD = self.storyboard?.instantiateViewController(withIdentifier: "Home") as! Home
        self.navigationController?.pushViewController(homeD, animated: true)
    }
    

}
