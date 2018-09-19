//
//  ViewController.swift
//  lab2
//
//  Created by Isaac Sheets on 9/18/18.
//  Copyright © 2018 Isaac Sheets. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var capSwitch: UISwitch!
    @IBOutlet weak var cherImg: UIImageView!
    @IBOutlet weak var imgSeg: UISegmentedControl!
    
    func caps(){
        if capSwitch.isOn {
            titleLabel.text=titleLabel.text?.uppercased()
        } else {
            titleLabel.text=titleLabel.text?.lowercased()
        }
    }
    
    func imgTitleSwap(){
        if imgSeg.selectedSegmentIndex == 0 {
            titleLabel.text="young cher"
            cherImg.image=UIImage(named: "young_cher")
        }
        else if imgSeg.selectedSegmentIndex == 1 {
            titleLabel.text="old cher"
            cherImg.image=UIImage(named: "old_cher")
        }
    }
    
    @IBAction func updateContent(_ sender: UISegmentedControl) {
        imgTitleSwap()
        caps()
    }
    
    @IBAction func updateCaps(_ sender: UISwitch) {
        caps()
    }
    
    @IBAction func fontSize(_ sender: UISlider) {
        let fontSize=sender.value
        let fontSizeCGFloat=CGFloat(fontSize)
        titleLabel.font=UIFont.systemFont(ofSize: fontSizeCGFloat)
    }
    
    
    @IBAction func fontColor(_ sender: UISlider) {
        let CGcolor = CGFloat(sender.value)
        titleLabel.textColor = UIColor(displayP3Red: 0.5, green: CGcolor, blue: CGcolor, alpha: 1)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

