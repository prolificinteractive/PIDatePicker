
Pod::Spec.new do |s|
  s.name             = "PIDatePicker"
  s.version          = "0.1.0"
  s.summary          = "A control that mimics UIDatePicker functionality with added customization options."
  s.description      = <<-DESC
                        This is a UIControl that mimics the functionality of UIDatePicker while also adding additional customization options that are not available using the base UIDatePicker
                        DESC
  s.homepage         = "https://github.com/prolificinteractive/PIDatePicker"
  s.license          = 'MIT'
  s.author           = { "Christopher Jones" => "chris.jones@haud.co" }
  s.source           = { :git => "https://github.com/prolificinteractive/PIDatePicker.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/*.swift'
end
