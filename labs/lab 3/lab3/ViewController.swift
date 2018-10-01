//
//  ViewController.swift
//  lab3
//
//  Created by Isaac Sheets on 9/30/18.
//  Copyright © 2018 Isaac Sheets. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var miField: UITextField!
    @IBOutlet weak var minField: UITextField!
    @IBOutlet weak var paceLabel: UILabel!
    
    @IBAction func textFieldDoneEditing(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    func updatePace() {
        var minutes:Float
        var miles:Float
        
        if miField.text!.isEmpty {
            miles = 0.0
        }
        else {
            miles = Float(miField.text!)!
            if miles < 0 {
                //create a UIAlertController object
                let alert=UIAlertController(title: "Seriously?", message: "You can't run negative miles", preferredStyle: UIAlertControllerStyle.alert)
                //create a UIAlertAction object for the button
                let cancelAction=UIAlertAction(title: "Cancel", style:UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(cancelAction) //adds the alert action to the alert object
                let okAction=UIAlertAction(title: "Change it for me", style: UIAlertActionStyle.default, handler: {action in
                    self.miField.text = String(abs(miles))
                    self.updatePace()
                })
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
            }
        }
        if minField.text!.isEmpty {
            minutes = 0.0
        }
        else {
            minutes = Float(minField.text!)!
            if minutes < 0 {
                //create a UIAlertController object
                let alert=UIAlertController(title: "Seriously?", message: "You can't have negative minutes", preferredStyle: UIAlertControllerStyle.alert)
                //create a UIAlertAction object for the button
                let cancelAction=UIAlertAction(title: "Cancel", style:UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(cancelAction) //adds the alert action to the alert object
                let okAction=UIAlertAction(title: "Change it for me", style: UIAlertActionStyle.default, handler: {action in
                    self.minField.text = String(abs(minutes))
                    self.updatePace()
                })
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
            }
        }
        
        let pace = minutes/miles;
        
        paceLabel.text = String(pace) + " min/mile"
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updatePace()
    }
    override func viewDidLoad() {
        minField.delegate = self
        miField.delegate = self
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onTapGestureRecognized(_ sender: Any) {
        miField.resignFirstResponder()
        minField.resignFirstResponder()
    }
}

