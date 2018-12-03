//
//  ViewController.swift
//  project1_01
//
//  Created by Isaac Sheets on 10/7/18.
//  Copyright © 2018 Isaac Sheets. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    
    @IBOutlet weak var intervalPicker: UIPickerView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var numTimesField: UITextField!
    @IBOutlet weak var costField: UITextField!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var constraintContentHeight: NSLayoutConstraint!
    
    

    //Picker view stuff
    let intervalOptions = ["hour", "day", "week", "month"]
    var selectedPicker = 0
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return intervalOptions.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return intervalOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        selectedPicker = row;
        print(selectedPicker)
    }
    
    //end picker view
    
    //send stuff back
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "save" {
            //save was pressed, pass data
            let tableView = segue.destination as! TableViewController
            if titleField.text!.isEmpty == false {
                if numTimesField.text!.isEmpty == false {
                    if costField.text!.isEmpty == false {
                        let newHabit = createHabit(title: titleField.text!, times: Int(numTimesField.text!)!, interval: selectedPicker, costPerTime: Float(costField.text!)!)
                        tableView.habitList.append(newHabit)
                        print("appended table")
                    }
                }
            }
        }
        //else do nothing with data
    }
    
    func createHabit(title: String, times: Int, interval: Int, costPerTime: Float) -> Habit {
        //calculate cost per second
        var secBetween : Float
        var costPerSec : Float
        
        if(interval == 0) {
            secBetween = Float(3600/times)
            costPerSec = costPerTime/secBetween
        }
        else if(interval == 1) {
            secBetween = Float(86400/times)
            costPerSec = costPerTime/secBetween
        }
        else if(interval == 2) {
            secBetween = Float(604800/times)
            costPerSec = costPerTime/secBetween
        }
        else if(interval == 3) {
            secBetween = Float(2628000/times)
            costPerSec = costPerTime/secBetween
        }
        else {
            costPerSec = 0
            secBetween = 0
        }
        print(costPerSec)
        
        let userHabit = Habit(habitTitle: title, numTimes: times, timeInterval: interval, secBetween: Double(secBetween), costPerTime: costPerTime, costPerSec: costPerSec, dateCreated: Date(), curDate: Date(), timeSince: "", moneySaved: 0)
        
        return userHabit;
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        intervalPicker.delegate=self
        intervalPicker.dataSource=self
        titleField.delegate=self
        numTimesField.delegate=self
        costField.delegate=self

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    //source for keyboard scrolling: https://stackoverflow.com/questions/26689232/scrollview-and-keyboard-swift
    
    @objc func keyboardWillShow(notification:NSNotification){
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 25
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }

    
    
    @IBAction func textFieldDoneEditing(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func onTapGestureRecognized(_ sender: Any) {
        titleField.resignFirstResponder()
        numTimesField.resignFirstResponder()
        costField.resignFirstResponder()
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

