Pod::Spec.new do |s|
  s.name             = 'DynamicNavigationBar'
  s.version          = '1.0'
  s.summary          = 'A navigation bar that can be expanded by drag.'
 
  s.description      = <<-DESC
A navigation bar that can be expanded by drag.
                       DESC
 
  s.homepage         = 'https://github.com/muhammadbassio/DynamicNavigationBar'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Muhammad Bassio' => 'muhammadbassio@gmail.com' }
  s.source           = { :git => 'https://github.com/muhammadbassio/DynamicNavigationBar.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '11.0'
  s.source_files = 'Example/Example/DynamicNavigationBar/*.swift'
  s.swift_version = '4.2'
 
end