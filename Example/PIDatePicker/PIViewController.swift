//
//  PIViewController.swift
//  PIDatePicker-Swift
//
//  Created by Jonathan on 4/17/15.
//  Copyright (c) 2015 Prolific Interactive. All rights reserved.
//

import UIKit
import PIDatePicker

class PIViewController : UIViewController {
    
    @IBOutlet weak var datePicker: PIDatePicker!
    
    let validPast: NSTimeInterval = -10000000000
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.datePicker.minimumDate = NSDate().dateByAddingTimeInterval(validPast)
    }

    @IBAction func randomizeColor(sender: AnyObject) {
        
        var red = CGFloat(arc4random_uniform(255))
        var green = CGFloat(arc4random_uniform(255))
        var blue = CGFloat(arc4random_uniform(255))
        
        self.datePicker.textColor = UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
        self.datePicker.reloadAllComponents()
    }
}
