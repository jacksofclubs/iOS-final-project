//
//  LicenseViewController.swift
//  Final Project
//
//  Created by Kevin Jacks on 5/4/17.
//  Copyright © 2017 Kevin Jacks. All rights reserved.
//

import UIKit

class LicenseViewController: UITableViewController {

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
        let wi_resident_selection          = wi_resident_switch.isSelected
        let junior_hunter_selection        = junior_hunter_switch.isSelected
        let antlered_tag_selction          = antlered_tag_switch.isSelected
        let antlerless_tag_selection       = antlerless_tag_switch.isSelected
        let num_antlerless_tag_selection   = num_antlerless_tags_ctrl.selectedSegmentIndex
        let certification_number_selection = certification_number_input.text
        let total_cost                     = total_cost_label.text
        
        // Set message to be saved
        let msg = "This is some text to displayed!"
        
        // Begin alert messages
        
        // Yes action
        
        // No action
        
        // Add actions to alert controller
        
        
    }
    
    // Function to save license to core data
    func saveCoreData() {
        
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
