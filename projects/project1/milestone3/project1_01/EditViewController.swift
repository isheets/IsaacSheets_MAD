//
//  EditViewController.swift
//  project1_01
//
//  Created by Isaac Sheets on 10/10/18.
//  Copyright © 2018 Isaac Sheets. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var editting : Int = 0
    
    var habitToEdit = Habit(habitTitle: "", numTimes: 0, timeInterval: 0, secBetween: 10, costPerTime: 0, costPerSec: 0, dateCreated: Date(), curDate: Date(), timeSince: "", moneySaved: 0)
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var numTimesField: UITextField!
    @IBOutlet weak var pickerInterval: UIPickerView!
    @IBOutlet weak var costField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func resetTimer(_ sender: UIBarButtonItem) {
        //reset date created
        habitToEdit.dateCreated = Date();
        
        //display alert
        let alert = UIAlertController(title: "BAD", message:
            "Looks like your self control could use work. We reset the timer and money saved for this habit. Better luck next time.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:"OK", style: .default, handler:  { action in self.performSegue(withIdentifier: "saveEdit", sender: self)}))
        
        self.present(alert, animated: true, completion: nil)
    
    }
    
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        titleField.text = habitToEdit.habitTitle
        numTimesField.text = String(habitToEdit.numTimes)
        pickerInterval.selectRow(habitToEdit.timeInterval, inComponent: 0, animated: false)
        costField.text = String(habitToEdit.costPerTime)
        selectedPicker = habitToEdit.timeInterval
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerInterval.delegate=self
        pickerInterval.dataSource=self
        titleField.delegate=self
        numTimesField.delegate=self
        costField.delegate=self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        // Do any additional setup after loading the view.
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
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveEdit" {
            //save was pressed, pass data
            let tableView = segue.destination as! TableViewController
            if titleField.text!.isEmpty == false {
                if numTimesField.text!.isEmpty == false {
                    if costField.text!.isEmpty == false {
                        tableView.habitList[editting].habitTitle = titleField.text!
                        tableView.habitList[editting].numTimes = Int(numTimesField.text!)!
                        tableView.habitList[editting].timeInterval = selectedPicker
                        tableView.habitList[editting].costPerTime = Float(costField.text!)!
                        tableView.habitList[editting].dateCreated = habitToEdit.dateCreated
                        
                        //update cost per sec based on new stuff
                        let costPerSec = updateCostPerSec(costPerTime: Float(costField.text!)!, times: Int(numTimesField.text!)!, interval: selectedPicker)
                        tableView.habitList[editting].costPerSec = costPerSec
                        
                        print("updated table")
                        
                    }
                }
            }
        }
        //else do nothing with data
    }
    
    
    func updateCostPerSec(costPerTime: Float, times: Int, interval: Int) -> Float {
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
        }
        return costPerSec
    }
 

}
