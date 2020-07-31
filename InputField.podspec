Pod::Spec.new do |s|
  s.name         = "InputField"
  s.version      = "0.0.5"
  s.summary      = "Contains all possible input fields"
  s.description  = "Have different input fields like Text,password,phone number,list and drop down and can use those inside a cell too"
  s.homepage     = "https://github.com/rsekar1094"
  s.license      = "Copyleft"
  s.author       = { "Raja Sekhar" => "rsekar1094@gmail.com" }
  s.source       = { :git => "https://github.com/rsekar1094/InputField.git", :tag => s.version }
  s.source_files = 'InputField/**/*.swift'
  s.exclude_files = ["InputField/Info.plist"]
  s.exclude_files = ["InputField/InputField.xcasset"]
  s.resources = "InputField/InputField.xcassets"
  s.platform = :ios, "10.0"
  s.swift_version = '5.0'
  s.requires_arc = true
  # s.dependency 'Gridicons'
end
