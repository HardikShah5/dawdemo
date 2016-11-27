//
//  NewsDetail.swift
//  Dawriyah
//
//  Created by Hardik Shah on 27/11/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class NewsDetail: SuperViewController {

    @IBOutlet weak var lblNewsTitle: UILabel!
    @IBOutlet weak var lblNewsDesc: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "أخبار الكامل"
        lblNewsTitle.text = "test asdfsdfsdf";
        //lblNewsTitle.text = "بالفيديو: هل ستنتقل دنيا باطما إلى التمثيل؟"
//        lblNewsDesc.text = "اختارت الفنانة دنيا باطما أن تؤدي الأغنية المغربية الشهيرة ياك أجرحي لقيدومة الطرب المغربي نعيمة سميح ، وذلك في الحفل الختامي لسهرات مهرجان أصوات نسائية في دورته التاسعة بمدينة تطوان (شمال المغرب) ، حيث خصص المهرجان تكريماً خاصاً لنجمة الطرب المغربي الأصيل نعيمة سميح ، التي اختارت التواري عن الأضواء والاستمتاع بوقتها مع عائلتها ." 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
