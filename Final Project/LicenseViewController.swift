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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // When user clicks off the keypad
    func didTapView(){
        self.view.endEditing(true)
    }
    
    // Create action methods here for each user input
    // Each time a user input is touched, will call function to calculate total cost
    @IBAction func residentClicked(_ sender: UISwitch) {
        calculateTotalCost()
    }
    @IBAction func juniorClicked(_ sender: UISwitch) {
        calculateTotalCost()
    }
    @IBAction func antlerlessClicked(_ sender: UISwitch) {
        calculateTotalCost()
    }
    @IBAction func numAntlerlessClicked(_ sender: UISegmentedControl) {
        calculateTotalCost()
    }
    
    
    var total_cost = 0
    // Function to calculate total cost
    func calculateTotalCost() {
        // Starts off as 160, the nonresidence price
        total_cost = 160
        // if resident, get resident price
        if (wi_resident_switch.isOn) {
            total_cost = 24
        }
        // if junior hunter and resident
        if (wi_resident_switch.isOn && junior_hunter_switch.isOn) {
            total_cost = 20
        }
        
        if (wi_resident_switch.isOn && antlerless_tag_switch.isOn) {
            // if resident and extra antlerless tags
            total_cost = total_cost + ((num_antlerless_tags_ctrl.selectedSegmentIndex + 1) * 12)
        } else if (!wi_resident_switch.isOn && antlerless_tag_switch.isOn) {
            // if nonresident and extra antlerless tags
            total_cost = total_cost + ((num_antlerless_tags_ctrl.selectedSegmentIndex + 1) * 20)
        }
    
        total_cost_label.text = "$" + String(total_cost) + ".00"
    }
    
    // Show / Hide the num_antlerless_tags segmented control
    @IBAction func showHideNumAntlerless(_ sender: UISwitch) {
        if (self.antlerless_tag_switch.isOn) {
            self.num_antlerless_tags_ctrl.isHidden = false
        } else if (!self.antlerless_tag_switch.isOn) {
            self.num_antlerless_tags_ctrl.isHidden = true
        }
    }

    // Function called when user selects 'Submit' button
    @IBAction func submit_license(_ sender: UIButton) {
        
        // Set input status to variables
        let wi_resident_status    = wi_resident_switch.isOn
        let junior_hunter_status  = junior_hunter_switch.isOn
        let antlered_tag_status   = antlered_tag_switch.isOn
        let antlerless_tag_status = antlerless_tag_switch.isOn
        let num_antlerless_tags   = num_antlerless_tags_ctrl.selectedSegmentIndex
        let certification_number  = certification_number_input.text
        
        // Set message to be saved
        let msg = "Have a safe hunting season"
        
        // Begin alert messages
        let controller = UIAlertController(title: "Are you sure you want to submit?",
                                           message:nil, preferredStyle: .alert)

        
        // Yes action
        let yesAction = UIAlertAction(title: "Yes, I'm ready",
                                      style: .default , handler: { action in
                                        let controller2 = UIAlertController(
                                            title:"License purchase complete!",
                                            message: msg, preferredStyle: .alert)
                                        let cancelAction = UIAlertAction(title: "OK",
                                                                         style: .cancel, handler: nil)
                                        controller2.addAction(cancelAction)
                                        self.present(controller2, animated: true,
                                                     completion: nil)
                                        self.saveCoreData(
                                            wi_resident_status: wi_resident_status,
                                            junior_hunter_status: junior_hunter_status,
                                            antlered_tag_status: antlered_tag_status,
                                            antlerless_tag_status: antlerless_tag_status,
                                            num_antlerless_tags: num_antlerless_tags,
                                            certification_number: certification_number!,
                                            total_cost: Decimal(self.total_cost)
                                        )
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

}
