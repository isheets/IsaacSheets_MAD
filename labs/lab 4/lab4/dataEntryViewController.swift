//
//  dataEntryViewController.swift
//  lab4
//
//  Created by Isaac Sheets on 10/8/18.
//  Copyright © 2018 Isaac Sheets. All rights reserved.
//

import UIKit

class dataEntryViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userAssign: UITextField!
    @IBOutlet weak var userStress: UISlider!
    
    
    var currentStress = stressStats()
    
    override func viewWillAppear(_ animated: Bool) {
        if currentStress.numAssignments?.isEmpty == false {
            userAssign.text = currentStress.numAssignments!
        }
        if currentStress.stressLevel != nil {
            userStress.setValue(Float(currentStress.stressLevel!), animated: true)
        }
    }

    override func viewDidLoad() {
        userAssign.delegate = self

        super.viewDidLoad()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "doneEntry" {
            let unwindViewController = segue.destination as! ViewController
            if userAssign.text!.isEmpty == false {
                unwindViewController.stress.numAssignments = userAssign.text!
            }
            unwindViewController.stress.stressLevel = Int(round(userStress.value))
        }
    }
 

}
