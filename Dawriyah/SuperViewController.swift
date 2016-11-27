//
//  SuperViewController.swift
//  Dawriyah
//
//  Created by MehulS on 24/11/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

//UITextField Extenstion
extension UITextField{
    //Placeholder text Color
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSForegroundColorAttributeName: newValue!])
        }
    }
}

class SuperViewController: UIViewController {

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Set Left Bar Back Button
        self.backButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - Back Button
    func backButton() -> Void {
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "BackButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(btnBackClicked))
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    func btnBackClicked() -> Void {
        self.navigationController?.popViewController(animated: true)
    }

}
