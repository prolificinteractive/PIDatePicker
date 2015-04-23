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
        
    override func loadView() {
        var rootView = UIView()
        rootView.backgroundColor = UIColor.whiteColor()
        
        var datePicker = PIDatePicker()
        datePicker.minimumDate = NSDate()
        rootView.addSubview(datePicker)
        
        datePicker.setTranslatesAutoresizingMaskIntoConstraints(false)
        var centerXConstraint = NSLayoutConstraint(item: datePicker, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: rootView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
        rootView.addConstraint(centerXConstraint)
        
        var centerYConstraint = NSLayoutConstraint(item: datePicker, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: rootView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0.0)
        rootView.addConstraint(centerYConstraint)
        
        datePicker.backgroundColor = UIColor.greenColor()
        
        self.view = rootView
    }
}