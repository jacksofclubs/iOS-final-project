//
//  LicenseViewController.swift
//  Final Project
//
//  Created by Kevin Jacks on 5/4/17.
//  Copyright © 2017 Kevin Jacks. All rights reserved.
//

import UIKit
import CoreData

class LicenseViewController: UITableViewController {
    
    // Variable names for core data
    public static let lineEntityName            = "License"
    public static let wi_resident_status_key    = "wi_resident_status"
    public static let junior_hunter_status_key  = "junior_hunter_status"
    public static let antlered_tag_status_key   = "antlered_tag_status"
    public static let antlerless_tag_status_key = "antlerless_tag_status"
    public static let num_antlerless_tags_key   = "num_antlerless_tags"
    public static let certification_number_key  = "certification_number"
    public static let total_cost_key            = "total_cost"

    @IBOutlet weak var wi_resident_switch: UISwitch!
    @IBOutlet weak var junior_hunter_switch: UISwitch!
    @IBOutlet weak var antlered_tag_switch: UISwitch!
    @IBOutlet weak var antlerless_tag_switch: UISwitch!
    @IBOutlet weak var num_antlerless_tags_ctrl: UISegmentedControl!
    @IBOutlet weak var certification_number_input: UITextField!
    @IBOutlet weak var total_cost_label: UILabel!
    @IBOutlet weak var submit_button: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creates variable for tap gesture in order to dismiss number pad
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(LicenseViewController.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // When user clicks off the keypad
    func didTapView(){
        self.view.endEditing(true)
    }

    // Function called when user selects 'Submit' button
    @IBAction func submit_license(_ sender: UIButton) {
        
        // Set input status to variables
        let wi_resident_status    = wi_resident_switch.isSelected
        let junior_hunter_status  = junior_hunter_switch.isSelected
        let antlered_tag_status   = antlered_tag_switch.isSelected
        let antlerless_tag_status = antlerless_tag_switch.isSelected
        let num_antlerless_tags   = num_antlerless_tags_ctrl.selectedSegmentIndex
        let certification_number  = certification_number_input.text
        let total_cost            = 10 //total_cost_label.text
        
        // Set message to be saved
        let msg = "This is some text to displayed!"
        
        // Begin alert messages
        let controller = UIAlertController(title: "Are you sure you want to submit?",
                                           message:nil, preferredStyle: .alert)

        
        // Yes action
        let yesAction = UIAlertAction(title: "Yes, I'm ready!",
                                      style: .default , handler: { action in
                                        let controller2 = UIAlertController(
                                            title:"License purchase complete!",
                                            message: msg, preferredStyle: .alert)
                                        let cancelAction = UIAlertAction(title: "Great!",
                                                                         style: .cancel, handler: nil)
                                        controller2.addAction(cancelAction)
                                        self.present(controller2, animated: true,
                                                     completion: nil)
                                        //self.myFunction(deer_type: deer_type, method_of_kill: method_of_kill, date_of_kill: time_of_kill, county: selected_county)
                                        self.saveCoreData(
                                            wi_resident_status: wi_resident_status,
                                            junior_hunter_status: junior_hunter_status,
                                            antlered_tag_status: antlered_tag_status,
                                            antlerless_tag_status: antlerless_tag_status,
                                            num_antlerless_tags: num_antlerless_tags,
                                            certification_number: certification_number!,
                                            total_cost: Decimal(total_cost)
                                        )
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
    
    // Function to save license to core data
    func saveCoreData(
        wi_resident_status: Bool,
        junior_hunter_status: Bool,
        antlered_tag_status: Bool,
        antlerless_tag_status: Bool,
        num_antlerless_tags: Int,
        certification_number: String,
        total_cost: Decimal
        ) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: LicenseViewController.lineEntityName)
        do{
            let objects = try context.fetch(request)
            var theData:NSManagedObject! = objects.first as? NSManagedObject
            theData = NSEntityDescription.insertNewObject(forEntityName: InfoViewController.lineEntityName,
                                                          into: context)as NSManagedObject
            theData.setValue(wi_resident_status,    forKey: InfoViewController.wi_resident_status_key)
            theData.setValue(junior_hunter_status,  forKey: InfoViewController.junior_hunter_status_key)
            theData.setValue(antlered_tag_status,   forKey: InfoViewController.antlered_tag_status_key)
            theData.setValue(antlerless_tag_status, forKey: InfoViewController.antlerless_tag_status_key)
            theData.setValue(num_antlerless_tags,   forKey: InfoViewController.num_antlerless_tags_key)
            theData.setValue(certification_number,  forKey: InfoViewController.certification_number_key)
            theData.setValue(total_cost,            forKey: InfoViewController.total_cost_key)
        } catch {
            print("Error")
        }
        
        appDelegate.saveContext()

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

}
