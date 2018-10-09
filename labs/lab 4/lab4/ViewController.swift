//
//  ViewController.swift
//  lab4
//
//  Created by Isaac Sheets on 10/8/18.
//  Copyright © 2018 Isaac Sheets. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayAssign: UILabel!
    @IBOutlet weak var displayStress: UILabel!
    
    var stress = stressStats()
    
    let filename = "data.plist"
    
    
    @IBAction func unwindSegue (_ segue:UIStoryboardSegue) {
        if stress.numAssignments?.isEmpty == false {
            displayAssign.text = stress.numAssignments! + " assignments due this week"
        }
        if stress.stressLevel != nil {
            displayStress.text = "stress level is at " + String(stress.stressLevel!) + "/10"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "enterSegue" {
            let enterViewController = segue.destination as! dataEntryViewController
            if stress.numAssignments?.isEmpty == false {
                enterViewController.currentStress.numAssignments = stress.numAssignments
            }
            if stress.stressLevel != nil {
                enterViewController.currentStress.stressLevel = stress.stressLevel
            }
        }
    }
    
    func dataFileURL(_ filename:String) -> URL? {
        //returns an array of URLs for the document directory in the user's home directory
        let urls = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)
        var url : URL?
        //append the file name to the first item in the array which is the document directory
        url = urls.first?.appendingPathComponent(filename)
        //return the URL of the data file or nil if it does not exist
        return url
    }
    
    override func viewDidLoad() {
        //get url of data file
        let fileURL = dataFileURL(filename)
        
        //if the data file exists, use it
        if FileManager.default.fileExists(atPath: (fileURL?.path)!){
            let url = fileURL!
            do {
                //creates a data buffer with the contents of the plist
                let data = try Data(contentsOf: url)
                //create an instance of PropertyListDecoder
                let decoder = PropertyListDecoder()
                //decode the data using the structure of the Favorite class
                stress = try decoder.decode(stressStats.self, from: data)
                //assign data to textfields
                displayAssign.text = stress.numAssignments! + " assignments due this week"
                displayStress.text = "stress level is at " + String(stress.stressLevel!) + "/10"
                print("data retrieved from plist and successfully dealt with!")
            } catch {
                print("no file")
            }
        }
        else {
            print("file does not exist")
        }
        
        //application instance
        let app = UIApplication.shared
        //subscribe to the UIApplicationWillResignActiveNotification notification
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillResignActive(_:)), name: Notification.Name.UIApplicationWillResignActive, object: app)
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func applicationWillResignActive(_ notification: Notification){
        //url of data file
        let fileURL = dataFileURL(filename)
        //create an instance of PropertyListEncoder
        let encoder = PropertyListEncoder()
        //set format type to xml
        encoder.outputFormat = .xml
        do {
            //encode the data using the structure of the Favorite class
            let plistData = try encoder.encode(stress)
            //write encoded data to the file
            try plistData.write(to: fileURL!)
        } catch {
            print("write error")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

