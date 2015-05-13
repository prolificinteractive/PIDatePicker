//
//  PIDatePickerDelegate.swift
//  Pods
//
//  Created by Matt Luedke on 5/8/15.
//
//

import Foundation

public protocol PIDatePickerDelegate {
    func datePicker(datePicker: PIDatePicker, didChangeToDate date:NSDate, byUpdatingComponent component:PIDatePickerComponents)
}
