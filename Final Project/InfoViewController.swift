//
//  InfoViewController.swift
//  Final Project
//
//  Created by Kevin Jacks on 5/4/17.
//  Copyright © 2017 Kevin Jacks. All rights reserved.
//

import UIKit
import CoreData

class InfoViewController: UIViewController {
    
    // Variable names for core data
    public static let lineEntityName            = "License"
    public static let wi_resident_status_key    = "wi_resident_status"
    public static let junior_hunter_status_key  = "junior_hunter_status"
    public static let antlered_tag_status_key   = "antlered_tag_status"
    public static let antlerless_tag_status_key = "antlerless_tag_status"
    public static let num_antlerless_tags_key   = "num_antlerless_tags"
    public static let certification_number_key  = "certification_number"
    public static let total_cost_key            = "total_cost"

    // Data dump to test core data
    @IBOutlet weak var dataDump: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        dataDump.sizeToFit()
        
        // Core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: LicenseViewController.lineEntityName)
        
        do {
            let objects = try context.fetch(request)
            for object in objects {
                let wi_resident_status    = (object as AnyObject).value(forKey: InfoViewController.wi_resident_status_key)    as? Bool    ?? false
                let junior_hunter_status  = (object as AnyObject).value(forKey: InfoViewController.junior_hunter_status_key)  as? Bool    ?? false
                let antlered_tag_status   = (object as AnyObject).value(forKey: InfoViewController.antlered_tag_status_key)   as? Bool    ?? false
                let antlerless_tag_status = (object as AnyObject).value(forKey: InfoViewController.antlerless_tag_status_key) as? Bool    ?? false
                let num_antlerless_tags   = (object as AnyObject).value(forKey: InfoViewController.num_antlerless_tags_key)   as? Int     ?? 0
                let certification_number  = (object as AnyObject).value(forKey: InfoViewController.certification_number_key)  as? String  ?? ""
                let total_cost            = (object as AnyObject).value(forKey: InfoViewController.total_cost_key)            as? Decimal ?? 0
                
                var antlered_tag_text = ""
                if (antlered_tag_status == true) {
                    antlered_tag_text = "antlered tag purchased"
                } else {
                    antlered_tag_text = "no antlered tag purchased"
                }
                
                var antlerless_tag_text = ""
                if (antlerless_tag_status == true) {
                    antlerless_tag_text = "antlerless tags purchased"
                } else {
                    antlerless_tag_text = "antlerless tags purchased"
                }
                var num_antlerless_tags_text = num_antlerless_tags + 1
                
                //dataDump.text = "Some of the data: num_antlerless_tags \(num_antlerless_tags), certification_number \(certification_number), total_cost \(total_cost), antlerless_tag_status \(antlerless_tag_status), wi_resident_status \(wi_resident_status), junior_hunter_status \(junior_hunter_status), antlered_tag_status \(antlered_tag_status)."
                dataDump.text = "License information: \(antlered_tag_text), \(num_antlerless_tags_text) \(antlerless_tag_text) for license number \(certification_number)."
            }
            
            let app = UIApplication.shared
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(UIApplicationDelegate.applicationWillResignActive(_:)),
                                                   name: NSNotification.Name.UIApplicationWillResignActive,
                                                   object: app)
        } catch {
            // Error thrown from executeFetchRequest()
            print("There was an error in executeFetchRequest(): \(error)")
        }

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
