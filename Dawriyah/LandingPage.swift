//
//  ViewController.swift
//  Dawriyah
//
//  Created by MehulS on 23/11/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class LandingPage: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Hide Status Bar
        UIApplication.shared.setStatusBarHidden(true, with: .fade)
        
        //Hide Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Login
    @IBAction func btnLoginClicked(_ sender: Any) {
        let signD = self.storyboard?.instantiateViewController(withIdentifier: "Login") as! Login
        signD.strNavBarTitle = (btnLogin.titleLabel?.text)!
        self.navigationController?.pushViewController(signD, animated: true)
    }

    //MARK: - Sign Up
    @IBAction func btnSignUpClicked(_ sender: Any) {
        let signD = self.storyboard?.instantiateViewController(withIdentifier: "SignUp") as! SignUp
        signD.strNavBarTitle = (btnSignUp.titleLabel?.text)!
        self.navigationController?.pushViewController(signD, animated: true)
    }
}

