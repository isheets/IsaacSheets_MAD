//
//  TestTableViewController.swift
//  tableTest
//
//  Created by Isaac Sheets on 9/27/18.
//  Copyright © 2018 Isaac Sheets. All rights reserved.
//

import UIKit

struct Habit {
    var id : Int
    var habitTitle : String
    var timeSince : String
    var moneySaved : String
}

class HabitTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var lastIndulged: UILabel!
    @IBOutlet weak var money: UILabel!
    
    
    
    
}

class TestTableViewController: UITableViewController {

    @IBAction func addButton(_ sender: UIBarButtonItem) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Add Habit", message: "Enter the details", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
//        alert.addTextField { (textField) in
//            textField.placeholder = "Title"
//        }
//
//        alert.addTextField { (textField) in
//            textField.placeholder = "Frequency"
//        }
        
        let pickerFrame = UIDatePicker(frame: CGRect(x: 0, y: 0, width: alert.view.frame.size.width - 20, height: 140)) // CGRectMake(left, top, width, height) - left and top are like margins
        pickerFrame.tag = 555
        //set the pickers datasource and delegate
        //
        
        //Add the picker to the alert controller
        alert.view.addSubview(pickerFrame)
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(textField?.text ?? "none entered")")
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    
    var habits = [
        Habit(id: 1, habitTitle: "Coffee", timeSince : "1d 14hr", moneySaved : "$5.00"),
        Habit(id: 2, habitTitle: "Drinking", timeSince : "2d 18hr", moneySaved : "$15.00"),
        Habit(id: 3, habitTitle: "Smoking", timeSince : "1hr", moneySaved : "$0.50"),
    ]

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return habits.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HabitCell", for: indexPath)
            as! HabitTableViewCell
        
        // Configure the cell...
        let habit = habits[indexPath.row];
        cell.title?.text = habit.habitTitle;
        cell.lastIndulged?.text = habit.timeSince;
        cell.money?.text = habit.moneySaved;
        cell.selectionStyle = .none
        
        return cell
    }
    
    
//    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
//        footerView.backgroundColor = UIColor.green
//        let button = UIButton(frame: CGRect(x: 0, y: 0, width: footerView.frame.size.width, height: 50))
//        button.setTitle("ADD", for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
//        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//        footerView.addSubview(button)
//        return footerView
//    }
    
//    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 50
//    }

//

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
