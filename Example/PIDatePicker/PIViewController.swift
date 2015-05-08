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
    }
    
    @IBAction func randomizeFont(sender: AnyObject) {
        var font: UIFont
        let familyNames = UIFont.familyNames()
        let randomNumber = Int(arc4random_uniform(UInt32(familyNames.count)))
        let familyName: String = familyNames[randomNumber] as! String
        let fontName: String = UIFont.fontNamesForFamilyName(familyName)[0] as! String
        self.datePicker.font = UIFont(name: fontName, size: 14)!
        self.datePicker.reloadAllComponents()
    }
}
