//
//  ViewController.swift
//  Dawriyah
//
//  Created by MehulS on 23/11/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit
import CoreData

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
        
        //To get the Title from server
        getTitleTextAsPerLang()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Get Records from Table
        
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Language")
        
        // Initialize Asynchronous Fetch Request
        let asynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { (asynchronousFetchResult) -> Void in
            
            DispatchQueue.main.async {
                self.processAsynchronousFetchResult(asynchronousFetchResult: asynchronousFetchResult)
            }
        }
        
        do {
            // Execute Asynchronous Fetch Request
            let asynchronousFetchResult = try AppUtils.APPDELEGATE().managedObjectContext.execute(asynchronousFetchRequest)
            
            print(asynchronousFetchResult)
            
        }catch {
            let fetchError = error as NSError
            print("\(fetchError), \(fetchError.userInfo)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func processAsynchronousFetchResult(asynchronousFetchResult: NSAsynchronousFetchResult<NSFetchRequestResult>) {
        if let result = asynchronousFetchResult.finalResult {
            // Update Items
            let items = result as! [NSManagedObject]
            
            print("Items : \(items)")
            
            for item in items {
                print("Key : \(item.value(forKey: "key")!)")
                print("Value : \(item.value(forKey: "value")!)")
                print("\n")
            }
        }
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
    
    func getTitleTextAsPerLang() -> Void {
        //Start Loading
        AppUtils.startLoading(view: self.view!)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        //Get Language
        var strLang = "ar"
        let language = NSLocale.preferredLanguages.first
        if language == "ar" {
            strLang = "ar"
        }else {
            strLang = "en"
        }
        
        
        LanguageHandler.GetTitleData("en") { (responseObject, success) in
            print("Response : \(responseObject!)")
            
            if(success) {
                let arrData = responseObject?.value(forKey: "screens") as! [AnyObject]
                for dicsData in arrData{
                    print("Dics: \(dicsData)")
                    let dics = dicsData as! NSDictionary
                    let screenName = dics.value(forKey: "ScreenName") as! String
                    
                    for label in dics.allKeys {
                        print(label)
                        let key = label as! String
                        let value = dics.value(forKey: key) as! String
                        
                        //DBM_INSERT
                        // Create Managed Object
                        let entityDescription = NSEntityDescription.entity(forEntityName: "Language", in: appDelegate.managedObjectContext)
                        let newRecord = NSManagedObject(entity: entityDescription!, insertInto: appDelegate.managedObjectContext)
                        
                        //Add Data
                        newRecord.setValue(screenName, forKey: "screenName")
                        newRecord.setValue(key, forKey: "key")
                        newRecord.setValue(value, forKey: "value")
                        newRecord.setValue(strLang, forKey: "language")
                        
                        // we save our entity
                        do {
                            try appDelegate.managedObjectContext.save()
                        } catch {
                            fatalError("Failure to save context: \(error)")
                        }
                        
                    }
                }
            }
            
            //Stop Loading
            AppUtils.stopLoading()
        }
        
    }
}

