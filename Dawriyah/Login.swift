//
//  SignInUp.swift
//  Dawriyah
//
//  Created by MehulS on 23/11/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class Login: SuperViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var strNavBarTitle = ""

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Navigation Bar Title
        self.title = strNavBarTitle
        
        
        
        //Login
        txtUserName.text = "test"
        txtPassword.text = "123456"
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
    
    //MARK: - UITextField Delegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 1 {
            txtPassword.becomeFirstResponder()
        }else if textField.tag == 2 {
            txtPassword.resignFirstResponder()
        }
        return true
    }
    
    //MARK: - Forgot Password
    @IBAction func btnForgotPasswordClicked(_ sender: Any) {
    }
    
    //MARK: - Submit
    @IBAction func btnSubmitClicked(_ sender: Any) {
        
//        UserHandler.loginWith(txtUserName.text, password: txtPassword.text, completion: {(responseObject, isSuccess)  -> Void in
//            print("Response : \(responseObject)")
//            
//            let dictData = responseObject?.value(forKey: "clientData") as! NSDictionary
//            
//            if (dictData.value(forKey: "statusCode") as! NSNumber) == 1 {
//            }
//            
//        })
        
        //Validations
        if (txtUserName.text?.characters.count)! <= 0 {
            AppUtils.showAlertWith(Title: "", Message: "Please provide User Name.", ForController: self)
        }else if (txtPassword.text?.characters.count)! <= 0 {
            AppUtils.showAlertWith(Title: "", Message: "Please provide Password.", ForController: self)
        }else {
            doLogin()
        }
    }
    
    func doLogin() -> Void {
        //Start Loading
        AppUtils.startLoading(view: self.view)
        
        UserHandler.loginWith(txtUserName.text, password: txtPassword.text, completion: { (responseObject, success) -> Void in
            
            print("Response : \(responseObject)")
            
            if success == false {
                AppUtils.showAlertWith(Title: "", Message: responseObject as! String, ForController: self)
            }else if Int(responseObject?.value(forKey: "success") as! NSNumber) == 1 {
                
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
        })
    }
    
    
    
    //MARK: - Navigate To The Dashboard
    func navigateToDashboard() -> Void {
        let homeD = self.storyboard?.instantiateViewController(withIdentifier: "Home") as! Home
        self.navigationController?.pushViewController(homeD, animated: true)
    }
    
    //MARK: - Sign Up
    @IBAction func btnSignUpClicked(_ sender: Any) {
        let signD = self.storyboard?.instantiateViewController(withIdentifier: "SignUp") as! SignUp
        signD.strNavBarTitle = "تسجيل"
        self.navigationController?.pushViewController(signD, animated: true)
    }
    
}
