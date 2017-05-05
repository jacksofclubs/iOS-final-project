//
//  RegistrationViewController.swift
//  Final Project
//
//  Created by Kevin Jacks on 5/4/17.
//  Copyright © 2017 Kevin Jacks. All rights reserved.
//

import UIKit

class RegistrationViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    // Outlet variable for submit button
    @IBOutlet weak var submit_button: UIButton!
    // Outlet variable for method of kill picker
    @IBOutlet weak var method_of_kill_picker: UIPickerView!
    // Data source for method of kill picker
    private let method_of_kill = [
        "Firearm", "Bow", "Muzzleloader", "Crossbow"
    ]
    
    // Variables for counties in picker
    @IBOutlet weak var county_picker: UIPickerView!
    private var counties_d:[String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let plistURL = Bundle.main.path(forResource:"counties", ofType: "plist")
        //counties = NSDictionary.init(contentsOf: (plistURL)!) as! [String]
        let counties_dict = NSDictionary(contentsOfFile: plistURL!)
        counties_d = counties_dict!.allKeys as! [String]//Array<String>//[String]
        //let counties = (counties_d!.allKeys as! [String:[String]]).sorted()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submit_registration(_ sender: UIButton) {
        // method of kill picker
        //let row = method_of_kill_picker.selectedRow(inComponent: 0)
        //let selected = method_of_kill[row]
        //let msg = "Method of kill: \(selected)"
        
        // County information
        let countyRow = county_picker.selectedRow(inComponent: 0)
        let selected_county = counties_d[countyRow]
        let msg = " blah \(selected_county)"
        
        
        
        // Begin alert messages
        let controller = UIAlertController(title: "Are you sure you want to submit?",
                                           message:nil, preferredStyle: .actionSheet)
        
        let yesAction = UIAlertAction(title: "Yes, I'm ready!",
                                      style: .destructive, handler: { action in
                                        let controller2 = UIAlertController(
                                            title:"Deer registration complete!",
                                            message: msg, preferredStyle: .alert)
                                        let cancelAction = UIAlertAction(title: "Great!",
                                                                         style: .cancel, handler: nil)
                                        controller2.addAction(cancelAction)
                                        self.present(controller2, animated: true,
                                                     completion: nil)
        })
        
        let noAction = UIAlertAction(title: "No, not yet!",
                                     style: .cancel, handler: nil)
        
        controller.addAction(yesAction)
        controller.addAction(noAction)
        
        if let ppc = controller.popoverPresentationController {
            ppc.sourceView = sender
            ppc.sourceRect = sender.bounds
            ppc.permittedArrowDirections = .down
        }
        
        present(controller, animated: true, completion: nil)
        // End alert messages
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
        if component == 0 {
            return counties_d.count
        } else {
            return counties_d.count
        }
    }
    
    // MARK: Picker Delegate Methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return counties_d[row]
        } else {
            return counties_d[row]
        }
    }

}
