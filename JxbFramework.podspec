Pod::Spec.new do |s|

  s.name         = "JxbFramework"
  s.version      = "1.0"
  s.summary      = "It is an iOS Framework for developer."
  s.homepage     = "https://github.com/JxbSir"
  s.license      = "Peter"
  s.author       = { "Peter" => "i@jxb.name" }
  s.requires_arc = true
  s.source       = { :git => "https://github.com/JxbSir/JxbFramework.git"  }
  s.source_files = "JXBFramework/XBFramework/”
  s.public_header_files = 'JXBFramework/XBFramework/XBFramework.h'
  s.frameworks   = 'UIKit'
end
