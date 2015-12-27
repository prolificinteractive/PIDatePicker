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
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var label: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.datePicker.minimumDate = NSDate.distantPast()
        self.datePicker.maximumDate = NSDate.distantFuture()
    }
    
    @IBAction func dateChanged(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        self.label.text = dateFormatter.stringFromDate(datePicker.date)
    }

    @IBAction func randomizeColor(sender: AnyObject) {
        
        let red = CGFloat(arc4random_uniform(255))
        let green = CGFloat(arc4random_uniform(255))
        let blue = CGFloat(arc4random_uniform(255))
        
        self.datePicker.textColor = UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    @IBAction func randomizeFont(sender: AnyObject) {
        let familyNames = UIFont.familyNames()
        let randomNumber = Int(arc4random_uniform(UInt32(familyNames.count)))
        let familyName: String = familyNames[randomNumber]
        guard let fontName: String = UIFont.fontNamesForFamilyName(familyName).first else {
            return
        }
        guard let font = UIFont(name: fontName, size: 14) else {
            return
        }
        self.datePicker.font = font
    }
}
