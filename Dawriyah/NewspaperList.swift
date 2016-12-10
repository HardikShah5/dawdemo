//
//  NewspaperList.swift
//  Dawriyah
//
//  Created by Hardik Shah on 10/12/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class NewspaperList: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblNewspaper: UITableView!
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        return 10;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "NewspaperCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! NewspaperCell
        //var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CellSignUp
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
