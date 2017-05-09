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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: RegistrationViewController.lineEntityName)
        
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
                
                //deer_type_label.text = "Registered an \(deer_type) deer using a \(method_of_kill) in \(county) on \(date_of_kill)."
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
