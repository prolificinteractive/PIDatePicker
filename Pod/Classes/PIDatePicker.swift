//
//  PIDatePicker.swift
//  PIDatePicker
//
//  Created by Daniel Vancura on 26/12/15.
//  Copyright © 2015 Daniel Vancura. All rights reserved.
//

import UIKit

// MARK: - Static variables
private var fontKey = "UIDatePicker.font"
private var textColorKey = "UIDatePicker.textColor"
private var onceToken: dispatch_once_t = 0

// MARK: - Helper functions

/**
Helper function that replaces a given method in a certain class with the implementation of another method in another class.
*/
private func replaceMethod(destMethod: Selector, ofClass destClass: AnyClass, withMethod sourceMethod: Selector, ofClass sourceClass: AnyClass) {
    let src = class_getInstanceMethod(sourceClass, sourceMethod)
    let dst = class_getInstanceMethod(destClass, destMethod)
    
    method_exchangeImplementations(src, dst)
}

/**
 Function to determine, if a view is a subview of a date picker.
 
 - parameter view: Any view in the view hierarchy.
 - returns: A date picker within which the current label is contained.
 */
func datePicker(view: UIView) -> UIDatePicker? {
    if view.superview == nil {
        return nil
    } else if let datePicker = view.superview as? UIDatePicker {
        return datePicker
    } else {
        return datePicker(view.superview!)
    }
}

// MARK: - Extension for UIDatePicker to provide additional properties

public extension UIDatePicker {
    /**
     The font name for text in the date picker.
     
     - note: This variable is tied to the 'font' property. Changes to one of them also changes the other.
     */
    @IBInspectable
    public var fontName: String {
        get {
            return self.font.fontName
        }
        set {
            if let font = UIFont(name: newValue, size: CGFloat(self.fontSize)) {
                self.font = font
                self.setNeedsDisplay()
            }
        }
    }
    
    /**
     The font size for text in the date picker.
     
     - note: This variable is tied to the 'font' property. Changes to one of them also changes the other.
     */
    @IBInspectable
    public var fontSize: Double {
        get {
            return Double(self.font.pointSize)
        }
        set {
            self.font = self.font.fontWithSize(CGFloat(newValue))
            self.setNeedsDisplay()
        }
    }
    
    /**
     The font that is used in the date picker. (Unfortunately, @Inspectable doesn't work with fonts - use fontName and fontSize instead)
     
     - note: This variable is tied to the 'fontSize' and 'fontName' properties. Changes to one of them also changes the other.
     */
    public var font: UIFont {
        get {
            if let font = objc_getAssociatedObject(self, &fontKey) as? UIFont {
                return font
            } else {
                return UIFont(name: "Helvetica", size: 20.0)!
            }
        }
        set {
            objc_setAssociatedObject(self, &fontKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
            self.subviews.filter({$0 is UIPickerView}).forEach({($0 as? UIPickerView)?.reloadAllComponents()})
            self.setNeedsDisplay()
        }
    }
    
    /**
     The color that is used for text in the date picker.
     */
    @IBInspectable
    public var textColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &textColorKey) as? UIColor
        }
        set {
            objc_setAssociatedObject(self, &textColorKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
            self.subviews.filter({$0 is UIPickerView}).forEach({($0 as? UIPickerView)?.reloadAllComponents()})
            self.setNeedsDisplay()
        }
    }
    
    // Override as "inspectable variable".
    @IBInspectable
    public override var backgroundColor: UIColor? {
        get {
            return super.backgroundColor
        }
        set {
            super.backgroundColor = newValue
            self.setNeedsDisplay()
        }
    }
}

// MARK: - Extension for UILabel to use text color and font as specified by the date picker (if there is one as a superview)

public extension UILabel {
    // Enables custom appearance for this view after loading this class.
    public override class func initialize() {
        
        super.initialize()
        
        // Replace the setters for text color and fonts with some that opt for a date picker's variables instead.
        dispatch_once(&onceToken, {
            replaceMethod(Selector("setTextColor:"), ofClass: UILabel.self, withMethod: Selector("pi_setTextColor:"), ofClass: UILabel.self)
            replaceMethod(Selector("setFont:"), ofClass: UILabel.self, withMethod: Selector("pi_setFont:"), ofClass: UILabel.self)
        })
    }
    
    // Layouts the label to use the proper font and text color.
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        // Apply the visual modifications when contained in a date picker.
        if let datePicker = datePicker(self) {
            // Check if this class actually responds to 'textColor' (otherwise, there are errors with Apple's private iOS SDK).
            if self.respondsToSelector(Selector("textColor")) {
                self.textColor = datePicker.textColor
            }
            if self.respondsToSelector("font") {
                self.font = datePicker.font
            }
        }
    }
    
    /**
     Replacement for UILabel.setTextColor.
     
     - parameter color: The new text color for this label. Will only be set, if this label is not contained within a UIDatePicker.
     */
    private func pi_setTextColor(color: UIColor) {
        // If part of a date picker, use the date picker's text color instead.
        if let datePicker = datePicker(self), let pickerColor = datePicker.textColor {
            self.pi_setTextColor(pickerColor)
            return
        }
        self.pi_setTextColor(color)
    }
    
    /**
     Replacement for UILabel.setFont.
     
     - parameter font: The new text font for this label. Will only be set, if this label is not contained within a UIDatePicker.
     */
    private func pi_setFont(font: UIFont) {
        // If part of a date picker, use the date picker's font instead.
        if let datePicker = datePicker(self) {
            self.pi_setFont(datePicker.font)
            return
        }
        self.pi_setFont(font)
    }
}
