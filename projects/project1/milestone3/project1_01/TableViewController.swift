//
//  TableViewController.swift
//  project1_01
//
//  Created by Isaac Sheets on 10/7/18.
//  Copyright © 2018 Isaac Sheets. All rights reserved.
//

import UIKit




class HabitTableViewCell: UITableViewCell {
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellLastIndulged: UILabel!
    @IBOutlet weak var cellSaved: UILabel!
    
}

class TableViewController: UITableViewController {
    
    @IBAction func updateStats(_ sender: UIBarButtonItem) {
        updateTimeSince()
        tableView.reloadData()
    }
    
    var habitList = [Habit]()
    
//    var habitList = [
//        Habit(habitTitle: "test", numTimes: 2, timeInterval: 1, secBetween: 10, costPerTime: 3, costPerSec: 0.01, dateCreated: Date(), curDate: Date(), timeSince: "0", moneySaved: 4)
//    ]
    
    @IBAction func unwindToTableViewController(segue: UIStoryboardSegue){
        print("unwind to tableview")
        updateTimeSince()
        tableView.reloadData()
    }
    @IBAction func saveToTableViewController(segue: UIStoryboardSegue){
        
        updateTimeSince()
        tableView.reloadData()
        print("save to tableview now there's ")
        print(habitList.count)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    
    func updateTimeSince() {
        //loop through array
        for i in 0..<habitList.count {
            //update time since field
            habitList[i].curDate = Date()
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .abbreviated
            formatter.allowedUnits = [.weekOfMonth, .day, .hour, .minute, .second]
            formatter.maximumUnitCount = 2
            let string = formatter.string(from: habitList[i].dateCreated, to: habitList[i].curDate)
            habitList[i].timeSince = string! + " ago"
            
            //update money saved
            let interval = DateInterval.init(start: habitList[i].dateCreated, end: habitList[i].curDate)
            let dollars = round(100*(interval.duration * Double(habitList[i].costPerSec)))/100
            habitList[i].moneySaved = dollars
        }
    }
    
    override func viewDidLoad() {
        
        //retrieve file and decode if it exists
        
        if Storage.fileExists("habits.json", in: .documents) {
            // we have messages to retrieve
            habitList = Storage.retrieve("habits.json", from: .documents, as: [Habit].self)
            print("file exists!")
        }
        
        //application instance
        let app = UIApplication.shared
        //subscribe to the UIApplicationWillResignActiveNotification notification
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillResignActive(_:)), name: Notification.Name.UIApplicationWillResignActive, object: app)
        
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    //store data to JSON file
     @objc func applicationWillResignActive(_ notification: Notification){
            Storage.store(habitList, to: .documents, as: "habits.json")
            print("stored data!")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return habitList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HabitCell", for: indexPath) as! HabitTableViewCell
        
        //         Configure the cell...
        let habit = habitList[indexPath.row]
        cell.cellTitle?.text = habit.habitTitle
        cell.cellLastIndulged?.text = habit.timeSince
        
        //format currency for money saved field
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        let priceString = currencyFormatter.string(from: NSNumber(value:habit.moneySaved))!
        
        cell.cellSaved?.text = priceString
        
        //for bg color of cell, check how many times they haven't indulged
        let interval = habit.curDate.timeIntervalSince(habit.dateCreated)
        let timesResisted = interval/habit.secBetween
        
        //set bg color accordingly, red is recent, orange = resisted once, orange/yellow = reisted twoice green = resisted thrice
        if timesResisted < 1 {
            cell.contentView.backgroundColor = UIColor(red: 255/255, green: 38/255, blue: 0/255, alpha: 0.25)
        }
        if timesResisted >= 1 && timesResisted < 2 {
            cell.contentView.backgroundColor = UIColor(red: 255/255, green: 147/255, blue: 0/255, alpha: 0.25)
        }
        if timesResisted >= 2 && timesResisted < 3 {
            cell.contentView.backgroundColor = UIColor(red: 255/255, green: 251/255, blue: 10/255, alpha: 0.25)
        }
        if timesResisted > 3 {
            cell.contentView.backgroundColor = UIColor(red: 0/255, green: 249/255, blue: 0/255, alpha: 0.25)
        }
        
        
        print(timesResisted)
        return cell
    }
    
//    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        //see how
//        let habit = habitList[indexPath.row]
//
//        let interval = habit.dateCreated.timeIntervalSince(habit.curDate)
//
//        let timesResisted = interval/habit.secBetween
//
//        print(timesResisted)
//
//    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.habitList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            print(habitList.count)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if  segue.identifier == "editHabitSegue",
            let destination = segue.destination as? EditViewController,
            let habitNumber = tableView.indexPathForSelectedRow?.row
        {
            destination.habitToEdit = habitList[habitNumber]
            destination.editting = habitNumber
        }
    }
    
}
