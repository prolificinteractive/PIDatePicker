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
}