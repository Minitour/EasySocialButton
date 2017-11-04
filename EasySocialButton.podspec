Pod::Spec.new do |s|
  s.name         = "EasySocialButton"
  s.version      = "1.0.2"
  s.summary      = "An easy way to create beautiful social authentication buttons."
  s.homepage     = "https://github.com/Minitour/EasySocialButton"
  s.license      = "MIT"
  s.author       = { "Antonio Zaitoun" => "tony.z.1711@gmail.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/Minitour/EasySocialButton.git", :tag => "#{s.version}" }
  s.source_files  = "Sources/**/*.{swift}"
end
