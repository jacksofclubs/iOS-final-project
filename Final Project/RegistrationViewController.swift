//
//  RegistrationViewController.swift
//  Final Project
//
//  Created by Kevin Jacks on 5/4/17.
//  Copyright © 2017 Kevin Jacks. All rights reserved.
//

import UIKit
import CoreData

class RegistrationViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    public static let lineEntityName     = "Registration"
    public static let deer_type_key      = "deer_type"
    public static let method_of_kill_key = "method_of_kill"
    public static let date_of_kill_key   = "date_of_kill"
    public static let county_key         = "county"
    
    // Deer type segmented control
    @IBOutlet weak var deer_types_selector: UISegmentedControl!
    // Method of kill segmented control
    @IBOutlet weak var method_of_kill_selector: UISegmentedControl!
    // Date picker
    @IBOutlet weak var date_picker: UIDatePicker!
    // Variables for counties in picker
    @IBOutlet weak var county_picker: UIPickerView!
    private var counties_d:[String]!
    // Outlet variable for submit button
    @IBOutlet weak var submit_button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let plistURL = Bundle.main.path(forResource:"counties", ofType: "plist")
        //counties = NSDictionary.init(contentsOf: (plistURL)!) as! [String]
        let counties_dict = NSDictionary(contentsOfFile: plistURL!)
        counties_d = counties_dict!.allKeys as! [String]//Array<String>//[String]
        counties_d = counties_d.sorted()

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Function called when user selects 'Submit' button
    @IBAction func submit_registration(_ sender: UIButton) {
        
        // Deer information
        // Sets to 0 for antlered, 1 for antlerless
        let deer_type_selection = deer_types_selector.selectedSegmentIndex
        let deer_type = deer_type_selection == 0 ? "antlered" : "antlerless"
        
        // Method of kill information
        // Sets to 0 = firearm, 1 = bow, 2 = muzzleloader, 3 = crossbow
        let method_of_kill_selection = method_of_kill_selector.selectedSegmentIndex
        var method_of_kill = ""
        switch method_of_kill_selection {
            case 0:
                method_of_kill = "firearm"
            case 1:
                method_of_kill = "bow"
            case 2:
                method_of_kill = "muzzleloader"
            case 3:
                method_of_kill = "crossbow"
            default:
                method_of_kill = ""
        }
        
        
        // Date information
        let time_of_kill = date_picker.date
        
        // County information
        let countyRow = county_picker.selectedRow(inComponent: 0)
        let selected_county = counties_d[countyRow]
        let msg = "Thank you for a safe hunting season"
        
        // Begin alert messages
        let controller = UIAlertController(title: "Are you sure you want to submit?",
                                           message:nil, preferredStyle: .alert)
        
        // Yes action
        let yesAction = UIAlertAction(title: "Yes, I'm ready",
                                      style: .default , handler: { action in
                                        let controller2 = UIAlertController(
                                            title:"Deer registration complete!",
                                            message: msg, preferredStyle: .alert)
                                        let cancelAction = UIAlertAction(title: "OK",
                                                                         style: .cancel, handler: nil)
                                        controller2.addAction(cancelAction)
                                        self.present(controller2, animated: true,
                                                     completion: nil)
                                        self.myFunction(deer_type: deer_type, method_of_kill: method_of_kill, date_of_kill: time_of_kill, county: selected_county)
        })
        
        // No action
        let noAction = UIAlertAction(title: "No, not yet",
                                     style: .destructive, handler: nil)
        // Add actions to alert controller
        controller.addAction(yesAction)
        controller.addAction(noAction)
        
        if let ppc = controller.popoverPresentationController {
            ppc.sourceView = sender
            ppc.sourceRect = sender.bounds
            ppc.permittedArrowDirections = .down
        }
        
        present(controller, animated: true, completion: nil)
        
        
    }
    
    // MARK:-
    // MARK: Picker Data Source Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
            return counties_d.count
    }
    
    // MARK: Picker Delegate Methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return counties_d[row]
    }
    
    func myFunction(deer_type: String, method_of_kill: String, date_of_kill: Date, county: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: RegistrationViewController.lineEntityName)
        do{
        let objects = try context.fetch(request)
        var theLine:NSManagedObject! = objects.first as? NSManagedObject
        theLine = NSEntityDescription.insertNewObject(forEntityName: HistoryViewController.lineEntityName,
                into: context)as NSManagedObject
        theLine.setValue(deer_type,      forKey: HistoryViewController.deer_type_key)
        theLine.setValue(method_of_kill, forKey: HistoryViewController.method_of_kill_key)
        theLine.setValue(date_of_kill,   forKey: HistoryViewController.date_of_kill_key)
        theLine.setValue(county,         forKey: HistoryViewController.county_key)
        } catch {
            print("Error")
        }
        
        appDelegate.saveContext()
    }

}
