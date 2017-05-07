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

    private static let lineEntityName     = "Registration"
    private static let deer_type_key      = "deer_type"
    private static let method_of_kill_key = "method_of_kill"
    private static let date_of_kill_key   = "date_of_kill"
    private static let county_key         = "county"
    
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
        
        // For data persistence
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //let context = appDelegate.managedObjectContext
        //let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: ViewController.lineEntityName)
        
        let plistURL = Bundle.main.path(forResource:"counties", ofType: "plist")
        //counties = NSDictionary.init(contentsOf: (plistURL)!) as! [String]
        let counties_dict = NSDictionary(contentsOfFile: plistURL!)
        counties_d = counties_dict!.allKeys as! [String]//Array<String>//[String]
        //let counties = (counties_d!.allKeys as! [String:[String]]).sorted()

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        let msg = "You selected \(selected_county) county and deer type is \(deer_type) and method of kill is \(method_of_kill) at the time of \(time_of_kill)"
        
        
        // Begin alert messages
        let controller = UIAlertController(title: "Are you sure you want to submit?",
                                           message:nil, preferredStyle: .alert)
        
        // Yes action
        let yesAction = UIAlertAction(title: "Yes, I'm ready!",
                                      style: .default , handler: { action in
                                        let controller2 = UIAlertController(
                                            title:"Deer registration complete!",
                                            message: msg, preferredStyle: .alert)
                                        let cancelAction = UIAlertAction(title: "Great!",
                                                                         style: .cancel, handler: nil)
                                        controller2.addAction(cancelAction)
                                        self.present(controller2, animated: true,
                                                     completion: nil)
                                        self.myFunction(deer_type: deer_type, method_of_kill: method_of_kill, date_of_kill: time_of_kill, county: selected_county)
        })
        
        // No action
        let noAction = UIAlertAction(title: "No, not yet!",
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
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK:-
    // MARK: Picker Data Source Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
//        if component == 0 {
//            return method_of_kill.count
//        } else {
            return counties_d.count
//        }
    }
    
    // MARK: Picker Delegate Methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        if component == 0 {
//            return method_of_kill[row]
//        } else {
            return counties_d[row]
//        }
    }
    
    func myFunction(deer_type: String, method_of_kill: String, date_of_kill: Date, county: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        var theLine:NSManagedObject! //as? NSManagedObject
        theLine = NSEntityDescription.insertNewObject(forEntityName: RegistrationViewController.lineEntityName,
                into: context)as NSManagedObject
        theLine.setValue(deer_type,      forKey: RegistrationViewController.deer_type_key)
        theLine.setValue(method_of_kill, forKey: RegistrationViewController.method_of_kill_key)
        theLine.setValue(date_of_kill,   forKey: RegistrationViewController.date_of_kill_key)
        theLine.setValue(county,   forKey: RegistrationViewController.county_key)
        //theLine.setValue(county_key,     forKey: RegistrationViewController.county_key)
        
        //let managedObjectContext: NSManagedObjectContext
        // Create the deer_registration core data object
        // var deer_registration:NSManagedObject! = objects.first as? NSManagedObject
        //let deer_registration = NSEntityDescription.deer_registration(forEntityName: "Registration", in: managedObjectContext)
        //let managedObjectContext = NSEntityDescription.insertNewObject(forEntityName: "Registration", into:managedObjectContext) as NSManagedObject
        // Set the attributes of the core data object
//        deer_registration.setValue(deer_type,      forKey: "deer_type"     )
//        deer_registration.setValue(method_of_kill, forKey: "method_of_kill")
//        deer_registration.setValue(date_of_kill,   forKey: "date_of_kill"  )
//        deer_registration.setValue(county,         forKey: "county"        )
        // Save the core data object
        
    }

}
