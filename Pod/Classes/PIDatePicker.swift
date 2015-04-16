//
//  PIDatePicker.swift
//  Pods
//
//  Created by Christopher Jones on 3/30/15.
//
//

public class PIDatePicker: UIView, UIPickerViewDataSource, UIPickerViewDelegate {

    // MARK: -
    // MARK: Public Properties
    
    /// The font for the date picker.
    public var font = UIFont.systemFontOfSize(15.0)

    /// The text color for the date picker components.
    public var textColor = UIColor.blackColor()

    /// The minimum date to show for the date picker. Set to NSDate.distantPast() by default
    public var minimumDate = NSDate.distantPast() as! NSDate

    /// The maximum date to show for the date picker. Set to NSDate.distantFuture() by default
    public var maximumDate = NSDate.distantFuture() as! NSDate

     /// The current locale to use for formatting the date picker. By default, set to the device's current locale
    public var locale : NSLocale = NSLocale.currentLocale() {
        didSet {
            self.calendar.locale = self.locale
        }
    }

    /// The current date value of the date picker.
    private(set) var date = NSDate()

    // MARK: -
    // MARK: Private Variables
    
     /// The internal picker view used for laying out the date components.
    private let pickerView = UIPickerView()

     /// The calendar used for formatting dates.
    private var calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!

     /// Calculates the current calendar components for the current date.
    private var currentCalendarComponents : NSDateComponents {
        get {
            return self.calendar.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay, fromDate: self.date)
        }
    }
    
     /// Gets the text color to be used for the label in a disabled state
    private var disabledTextColor : UIColor {
        get {
            var r : CGFloat = 0
            var g : CGFloat = 0
            var b : CGFloat = 0
            
            self.textColor.getRed(&r, green: &g, blue: &b, alpha: nil)
            
            return UIColor(red: r, green: g, blue: b, alpha: 0.35)
        }
    }

     /// The order in which each component should be ordered in.
    private var datePickerComponentOrdering = [PIDatePickerComponents]()

    // MARK: -
    // MARK: LifeCycle

    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    func commonInit() {
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        
        self.addSubview(self.pickerView)
        
        let topConstraint = NSLayoutConstraint(item: self.pickerView, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: self.pickerView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0)
        let leftConstraint = NSLayoutConstraint(item: self.pickerView, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: self.pickerView, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1, constant: 0)
        
        self.addConstraints([topConstraint, bottomConstraint, leftConstraint, rightConstraint])
    }
    
    // MARK: -
    // MARK: Override
    public override func intrinsicContentSize() -> CGSize {
        return self.pickerView.intrinsicContentSize()
    }

    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.reloadAllComponents()
    }

    // MARK: - 
    // MARK: Public

    /**
        Reloads all of the components in the date picker.
    */
    public func reloadAllComponents() {
        self.refreshComponentOrdering()
        self.pickerView.reloadAllComponents()
    }
    
    /**
    Sets the current date value for the date picker.
    
    :param: date     The date to set the picker to.
    :param: animated True if the date picker should changed with an animation; otherwise false,
    */
    public func setDate(date : NSDate, animated : Bool) {
        self.date = date
        self.updatePickerViewComponentValuesAnimated(animated)
    }

    // MARK: -
    // MARK: Private
    
    /**
    Sets the current date with no animation.
    
    :param: date The date to be set.
    */
    private func setDate(date : NSDate) {
        self.setDate(date, animated: false)
    }

    /**
        Creates a new date formatter with the locale and calendar
    
        :returns: A new instance of NSDateFormatter
    */
    private func dateFormatter() -> NSDateFormatter {
        let dateFormatter = NSDateFormatter()
        dateFormatter.calendar = self.calendar
        dateFormatter.locale = self.locale
        
        return dateFormatter
    }

    /**
        Refreshes the ordering of components based on the current locale. Calling this function will not refresh the picker view.
    */
    private func refreshComponentOrdering() {
        var componentOrdering = NSDateFormatter.dateFormatFromTemplate("yMMMMd", options: 0, locale: self.locale)!

        let firstComponentOrderingString = componentOrdering[advance(componentOrdering.startIndex, 0)]
        let lastComponentOrderingString = componentOrdering[advance(componentOrdering.startIndex, count(componentOrdering) - 1)]

        let characterSet = NSCharacterSet(charactersInString: String(firstComponentOrderingString) + String(lastComponentOrderingString))
        componentOrdering = componentOrdering.stringByTrimmingCharactersInSet(characterSet).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())

        let remainingValue = componentOrdering[advance(componentOrdering.startIndex, 0)]

        let firstComponent = PIDatePickerComponents(rawValue: firstComponentOrderingString)!
        let secondComponent = PIDatePickerComponents(rawValue: remainingValue)!
        let lastComponent = PIDatePickerComponents(rawValue: lastComponentOrderingString)!

        self.datePickerComponentOrdering = [firstComponent, secondComponent, lastComponent]
    }

    /**
        Gets the value of the current component at the specified row.
    
    :param: row            The row index whose value is required
    :param: componentIndex The component index for the row.
    
    :returns: A string containing the value of the current row at the component index.
    */
    private func valueForRow(row : Int, inComponentIndex componentIndex: Int) -> String {
        let dateComponent = self.componentAtIndex(componentIndex)

        let value = self.rawValueForRow(row, inComponent: dateComponent)

        if dateComponent == PIDatePickerComponents.Month {
            let dateFormatter = self.dateFormatter()
            return dateFormatter.monthSymbols[value - 1] as! String
        } else {
            return String(value)
        }
    }
    
    /**
    Gets the maximum range for the specified date picker component.
    
    :param: component The component to get the range for.
    
    :returns: The maximum date range for that component.
    */
    private func maximumRangeForComponent(component : PIDatePickerComponents) -> NSRange {
        var calendarUnit : NSCalendarUnit
        if component == .Year {
            calendarUnit = .CalendarUnitYear
        } else if component == .Day {
            calendarUnit = .CalendarUnitDay
        } else {
            calendarUnit = .CalendarUnitMonth
        }
        
        return self.calendar.maximumRangeOfUnit(calendarUnit)
    }
    
    /**
    Calculates the raw value of the row at the current index.
    
    :param: row       The row to get.
    :param: component The component which the row belongs to.
    
    :returns: The raw value of the row, in integer. Use NSDateComponents to convert to a usable date object.
    */
    private func rawValueForRow(row : Int, inComponent component : PIDatePickerComponents) -> Int {
        let calendarUnitRange = self.maximumRangeForComponent(component)
        return calendarUnitRange.location + (row % calendarUnitRange.length)
    }
    
    /**
    Checks if the specified row should be enabled or not.
    
    :param: row       The row to check.
    :param: component The component to check the row in.
    
    :returns: YES if the row should be enabled; otherwise NO.
    */
    private func isRowEnabled(row: Int, forComponent component : PIDatePickerComponents) -> Bool {
        let rawValue = self.rawValueForRow(row, inComponent: component)
        
        let components = NSDateComponents()
        components.year = self.currentCalendarComponents.year
        components.month = self.currentCalendarComponents.month
        components.day = self.currentCalendarComponents.day
        
        if component == .Year {
            components.year = rawValue
        } else if component == .Day {
            components.day = rawValue
        } else {
            components.month = rawValue
        }
        
        let dateForRow = self.calendar.dateFromComponents(components)!
        
        return self.minimumDate.compare(dateForRow) != NSComparisonResult.OrderedDescending &&
            self.maximumDate.compare(dateForRow) != NSComparisonResult.OrderedAscending
    }
    
    private func updatePickerViewComponentValuesAnimated(animated : Bool) {
        for (index, dateComponent) in enumerate(self.datePickerComponentOrdering) {
            self.setIndexOfComponent(dateComponent, atIndex: index, animated: animated)
        }
    }
    
    private func setIndexOfComponent(component : PIDatePickerComponents, atIndex index: Int, animated: Bool) {
        
    }

    /**
        Gets the component type at the current component index.
    
    :param: index The component index
    
    :returns: The date picker component type at the index.
    */
    private func componentAtIndex(index: Int) -> PIDatePickerComponents {
        return self.datePickerComponentOrdering[index]
    }

    // MARK: - 
    // MARK: Protocols
    // MARK: UIPickerViewDelegate
    
    
    public func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.setDate(NSDate())
    }

    public func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        var label = view as? UILabel == nil ? UILabel() : view as! UILabel
        
        label.font = self.font
        label.textColor = self.textColor
        label.text = self.valueForRow(row, inComponentIndex: component)
        label.textAlignment = self.componentAtIndex(component) == .Month ? NSTextAlignment.Left : NSTextAlignment.Right
        label.textColor = self.isRowEnabled(row, forComponent: self.componentAtIndex(component)) ? self.textColor : self.disabledTextColor

        return label
    }

    public func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let widthBuffer = 25.0
        
        let calendarComponent = self.componentAtIndex(component)
        let stringSizingAttributes = [NSFontAttributeName : self.font]
        var size = 0.01
        
        if calendarComponent == .Month {
            let dateFormatter = self.dateFormatter()
            
            // Get the length of the longest month string and set the size to it.
            for symbol in dateFormatter.monthSymbols as! [String] {
                let monthSize = NSString(string: symbol).sizeWithAttributes(stringSizingAttributes)
                size = max(size, Double(monthSize.width))
            }
        } else if calendarComponent == .Day{
            // Pad the day string to two digits
            let dayComponentSizingString = NSString(string: "00")
            size = Double(dayComponentSizingString.sizeWithAttributes(stringSizingAttributes).width)
        } else if calendarComponent == .Year  {
            // Pad the year string to four digits.
            let yearComponentSizingString = NSString(string: "00")
            size = Double(yearComponentSizingString.sizeWithAttributes(stringSizingAttributes).width)
        }
        
        // Add the width buffer in order to allow the picker components not to run up against the edges
        return CGFloat(size + widthBuffer)
    }


    // MARK: UIPickerViewDataSource
    public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Int(INT16_MAX)
    }

    public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
}
