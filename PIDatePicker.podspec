
Pod::Spec.new do |s|
  s.name             = "PIDatePicker"
  s.version          = "0.1.0"
  s.summary          = "A short description of PIDatePicker."
  s.description      = <<-DESC
                       An optional longer description of PIDatePicker

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/<GITHUB_USERNAME>/PIDatePicker"
  s.license          = 'MIT'
  s.author           = { "Christopher Jones" => "chris.jones@haud.co" }
  s.source           = { :git => "https://github.com/<GITHUB_USERNAME>/PIDatePicker.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
end
