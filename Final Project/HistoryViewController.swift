//
//  HistoryViewController.swift
//  Final Project
//
//  Created by Kevin Jacks on 5/4/17.
//  Copyright © 2017 Kevin Jacks. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController {
    public static let lineEntityName     = "Registration"
    public static let deer_type_key      = "deer_type"
    public static let method_of_kill_key = "method_of_kill"
    public static let date_of_kill_key   = "date_of_kill"
    public static let county_key         = "county"

    //@IBOutlet var lineFields:[UITextField]!
    @IBOutlet weak var deer_type_label: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: RegistrationViewController.lineEntityName)

        do {
            let objects = try context.fetch(request)
            for object in objects {
                let deer_type      = (object as AnyObject).value(forKey: HistoryViewController.deer_type_key)      as? String ?? ""
                let method_of_kill = (object as AnyObject).value(forKey: HistoryViewController.method_of_kill_key) as? String ?? ""
                let date_of_kill   = (object as AnyObject).value(forKey: HistoryViewController.date_of_kill_key)   as? Date   ?? Date()
                let county         = (object as AnyObject).value(forKey: HistoryViewController.county_key)         as? String ?? ""
                
                deer_type_label.text = "Registered an \(deer_type) deer using a \(method_of_kill) in \(county) on \(date_of_kill)."
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
//
//    func applicationWillResignActive(_ notification:Notification) {
//        let appDelegate =
//            UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.managedObjectContext
//        for i in 0 ..< lineFields.count {
//            let textField = lineFields[i]
//            
//            let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: HistoryViewController.lineEntityName)
//            let pred = NSPredicate(format: "%K = %d", HistoryViewController.lineNumberKey, i)
//            request.predicate = pred
//            
//            do {
//                let objects = try context.fetch(request)
//                var theLine:NSManagedObject! = objects.first as? NSManagedObject
//                if theLine == nil {
//                    // No existing data for this row – insert a new managed object for it
//                    theLine =
//                        NSEntityDescription.insertNewObject(
//                            forEntityName: HistoryViewController.lineEntityName,
//                            into: context)
//                        as NSManagedObject
//                }
//                
//                theLine.setValue(i, forKey: HistoryViewController.lineNumberKey)
//                theLine.setValue(textField.text, forKey: HistoryViewController.lineTextKey)
//            } catch {
//                print("There was an error in executeFetchRequest(): \(error)")
//            }
//        }
//        appDelegate.saveContext()
//    }

}
