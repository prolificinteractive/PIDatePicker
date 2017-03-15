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
    @IBOutlet weak var label: UILabel!
    
    let validPast: TimeInterval = -10000000000
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.datePicker.minimumDate = Date().addingTimeInterval(validPast)
        self.datePicker.delegate = self
    }

    @IBAction func randomizeColor(_ sender: AnyObject) {
        
        let red = CGFloat(arc4random_uniform(255))
        let green = CGFloat(arc4random_uniform(255))
        let blue = CGFloat(arc4random_uniform(255))
        
        self.datePicker.textColor = UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
        self.datePicker.reloadAllComponents()
    }
    
    @IBAction func randomizeFont(_ sender: AnyObject) {
        let familyNames = UIFont.familyNames
        let randomNumber = Int(arc4random_uniform(UInt32(familyNames.count)))
        let familyName: String = familyNames[randomNumber]
        let fontName: String = UIFont.fontNames(forFamilyName: familyName)[0]
        self.datePicker.font = UIFont(name: fontName, size: 14)!
        self.datePicker.reloadAllComponents()
    }
}

extension PIViewController: PIDatePickerDelegate {
    func pickerView(_ pickerView: PIDatePicker, didSelectRow row: Int, inComponent component: Int) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        self.label.text = dateFormatter.string(from: pickerView.date)
    }
}
