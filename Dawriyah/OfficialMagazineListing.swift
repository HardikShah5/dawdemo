//
//  OfficialMagazineListing.swift
//  Dawriyah
//
//  Created by Hardik Shah on 07/12/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class OfficialMagazineListing: SuperViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var lblTotal: UILabel!
    
    var viewFilter: Filter!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Title
        self.title = AppUtils.localized("OFFICAIL_MAGAZINE", value: "")
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
        let cellIdentifier = "OfficialMagazineCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! OfficialMagazineCell
        //var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CellSignUp
        
       
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    //MARK: - Filter
    @IBAction func btnFilterClicked(_ sender: Any) {
        if viewFilter == nil {
            viewFilter = Bundle.main.loadNibNamed("Filter", owner: self, options: nil)?.first as! Filter
            AppUtils.APPDELEGATE().window?.addSubview(viewFilter)
        }
        viewFilter.isHidden = false
        
        viewFilter.setLayout()
        AppUtils.APPDELEGATE().window?.bringSubview(toFront: viewFilter)
    }
    
}
