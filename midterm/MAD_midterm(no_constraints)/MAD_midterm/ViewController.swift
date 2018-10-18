//
//  ViewController.swift
//  MAD_midterm
//
//  Created by Isaac Sheets on 10/18/18.
//  Copyright © 2018 Isaac Sheets. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var enterTime: UITextField!
    @IBOutlet weak var calcMiles: UILabel!
    @IBOutlet weak var calcCals: UILabel!
    @IBOutlet weak var perWeekLabel: UILabel!
    @IBOutlet weak var typeControl: UISegmentedControl!
    @IBOutlet weak var numWorkouts: UISlider!
    @IBOutlet weak var weeklySwitch: UISwitch!
    @IBOutlet weak var iconImage: UIImageView!
    
    var workouts = 5
    
    @IBAction func sliderChanged(_ sender: Any) {
        workouts = Int(round(numWorkouts.value))
        perWeekLabel.text = String(workouts)
    }
    
    var workoutType : Int? //0 = run, 1 = bike, 2 = swim
    
    @IBAction func typeChanged(_ sender: Any) {
        workoutType = typeControl.selectedSegmentIndex
        
        switch typeControl.selectedSegmentIndex
        {
        case 0:
            iconImage.image = UIImage(named: "run")
        case 1:
            iconImage.image = UIImage(named: "bike")
        case 2:
            iconImage.image = UIImage(named: "swim")
        default:
            break
        }
    }
    
    @IBAction func workout(_ sender: Any) {
        updateStats()
    }
    
    func updateStats() {
        var minutes : Int
        
        if enterTime.text!.isEmpty {
            minutes = 0
        }
        else {
            minutes = Int(enterTime.text!)!
        }
        
        //ALERT STUFF//
        if minutes < 30 {
            //create a UIAlertController object
            let alert=UIAlertController(title: "Seriously?", message: "You didn't work out for even 30 minutes? That's almost no time at all.", preferredStyle: UIAlertControllerStyle.alert)
            //create a UIAlertAction object for the button
            let cancelAction=UIAlertAction(title: "Cancel", style:UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(cancelAction) //adds the alert action to the alert object
            let okAction=UIAlertAction(title: "Change it for me", style: UIAlertActionStyle.default, handler: {action in
                self.enterTime.text = "30"
                self.updateStats()
            })
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            
        }
        
        var calories : Double
        var miles : Double
        //run claculation
        if workoutType == 0 {
            calories = 10 * Double(minutes)
            miles = 0.1 * Double(minutes)
        }
        //bike calculation
        else if workoutType == 1 {
            calories = 8.5 * Double(minutes)
            miles = 0.25 * Double(minutes)
        }
        //swim calculation
        else {
            calories = 7 * Double(minutes)
            miles = 0.03333333 * Double(minutes)
        }
        
        if weeklySwitch.isOn {
            calcCals.text = String((Int(round(10*calories)/10)) * workouts) + " calories"
            calcMiles.text = String((Int(round(10*miles)/10)) * workouts) + " miles"
            
        }
        else {
            calcCals.text = String(round(10*calories)/10) + " calories"
            calcMiles.text = String(round(10*miles)/10) + " miles"
        }
        
    }
    
    @IBAction func textFieldDoneEditing(sender: UITextField) {
        sender.resignFirstResponder()
    }


    override func viewDidLoad() {
        enterTime.delegate = self
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

