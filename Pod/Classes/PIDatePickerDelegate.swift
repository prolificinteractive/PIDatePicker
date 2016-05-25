//
//  PIDatePickerDelegate.swift
//  Pods
//
//  Created by Matt Luedke on 5/8/15.
//
//

import Foundation

@objc public protocol PIDatePickerDelegate {
    func pickerView(pickerView: PIDatePicker, didSelectRow row: Int, inComponent component: Int)
}
