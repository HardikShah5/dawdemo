//
//  DataBaseHandler.swift
//  Dawriyah
//
//  Created by Hardik Shah on 20/04/17.
//  Copyright © 2017 MehulS. All rights reserved.
//

import UIKit
import CoreData

class DataBaseHandler: NSObject {


    static func getLabelTitleForPage(ScreenName: String) -> [NSManagedObject] {
        
        // Initialize Fetch Request
        var homeLabelTitles = [NSManagedObject]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Language")
        
        //Key : ScreenName
        //Value : 01_Splash
        fetchRequest.predicate = NSPredicate(format: "screenName == %@", ScreenName)
        
        do {
            
            let results = try AppUtils.APPDELEGATE().managedObjectContext.fetch(fetchRequest)
            //var homeLabelTitles = [NSManagedObject]()
            homeLabelTitles = results as! [NSManagedObject]
            //            for item in homeLabelTitles {
            //                print("Key : \(item.value(forKey: "key")!)")
            //                print("Value : \(item.value(forKey: "value")!)")
            //                print("\n")
            //
            //                if(item.value(forKey: "key") as! String == "sction_4_label_1"){
            //                    print("Tweeter Section found")
            //                }
            //            }
        }catch {
            let fetchError = error as NSError
            print("\(fetchError), \(fetchError.userInfo)")
        }
        return homeLabelTitles
    }
    
    static func getTheLabelTitle(ScreenLabelData: [NSManagedObject], key: String) -> String? {
        for item in ScreenLabelData {
            //                        print("Key : \(item.value(forKey: "key")!)")
            //                        print("Value : \(item.value(forKey: "value")!)")
            //                        print("\n")
            
            if(item.value(forKey: "key") as! String == key){
                return item.value(forKey: "value") as? String
            }
        }
        return ""
    }
}
