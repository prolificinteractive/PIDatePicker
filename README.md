# PIDatePicker

![PIDatePicker](https://raw.github.com/prolificinteractive/pidatepicker/master/Images/PIDatePicker.gif)

## Description
A custom UIDatePicker object that allows design customization of various user interface attributes such as font, color, etc. This pod
aims to replicate the default UIDatePicker functionality while adding additional customization in the user interface.

## Usage

PIDatePicker is available through [Cocoapods](https://cocoapods.org/?q=PIDatePicker). 

The source code is available on [GitHub](https://github.com/prolificinteractive/PIDatePicker). 

To use in your projects, simply add the following line to your `Podfile`:

```ruby
pod "PIDatePicker", '~> 0.1.0'
```

You can then use `PIDatePicker` by importing it into your files:

```swift
import PIDatePicker
```

Because this project was written in Swift, your project must have a minimum target of iOS 8.0 or greater. Cocoapods
does not support Swift pods for previous iOS versions. If you need to use this on a previous version of iOS, 
import the code files directly into your project or by using git submodules.

## Customization

There are several options available for customizing your date picker:

| Property              | Type      | Description                                                                                                       |
|:----------------------|:----------|:------------------------------------------------------------------------------------------------------------------|
| font			        | UIFont    | Sets the font that the date picker will use to display the dates. By default, it uses a system font of size 15.   |
| textColor             | UIColor   | Set the color of the text. By default, it uses `UIColor.blackColor()`.                                            |
| backgroundColor       | UIColor   | Set the background color of the date picker. By default, it is a clear color.                                     |
| minimumDate 		    | UIDate    | The minimum selectable date allowed by the date picker. Defaults to `NSDate.distantPast()`.                       |
| maximumDate		    | UIDate    | The maximum selectable date allowed by the date picker. Defaults to `NSDate.distantFuture()`.                     |
| locale		        | NSLocale  | The locale of the calendar used for formatting the date. By default, this uses the device's locale.               |

The following public methods are available for calling in your module:

| Method                					| Description                                           |
|:------------------------------------------|:------------------------------------------------------|
| reloadAllComponents() 					| Reloads all of the components of the date picker.		|
| setDate(date: NSDate, animated: Bool)     | Sets the current date of the date picker.             |

## Delegate

A class can implement `PIDatePickerDelegate` and the following method to respond to changes in user selection.

```swift
func pickerView(pickerView: PIDatePicker, didSelectRow row: Int, inComponent component: Int)
```

## Contributing

To report a bug or enhancement request, feel free to file an issue under the respective heading. 

If you wish to contribute to the project, fork this repo and submit a pull request. 

## License

PIDatePicker is available under the MIT license. See the LICENSE file for more info.


