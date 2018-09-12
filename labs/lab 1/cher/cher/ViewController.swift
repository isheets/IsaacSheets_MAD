//
//  ViewController.swift
//  cher
//
//  Created by Isaac Sheets on 9/10/18.
//  Copyright © 2018 Isaac Sheets. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var hound: UIImageView!
    @IBOutlet weak var cher: UIImageView!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    
    @IBAction func correct(_ sender: UIButton) {
        if sender.tag == 1 {
            hound.image = UIImage(named: "good_cher")
            cher.image = UIImage(named: "good_cher")
            heading.text = "nIce! correct!"
            question.text = "u really know ur stuff"
            button1.isHidden = true;
            button2.isHidden = true;
        }
        else if sender.tag == 2 {
            hound.image = UIImage(named: "bad_cher")
            cher.image = UIImage(named: "bad_cher")
            heading.text = "no that's wrong"
            question.text = "what r u THINKING???"
            button1.isHidden = true;
            button2.isHidden = true;
        }
        
    }
    
    @IBAction func reset(_ sender: UIButton) {
        button1.isHidden = false;
        button2.isHidden = false;
        hound.image = UIImage(named: "hound")
        cher.image = UIImage(named: "cher")
        heading.text = "Chering...is...Caring"
        question.text = "but can you tell which one is the pop diva CHER??"
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

