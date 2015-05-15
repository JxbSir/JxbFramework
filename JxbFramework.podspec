Pod::Spec.new do |s|

  s.name         = "JxbFramework"
  s.version      = "1.0"
  s.summary      = "It is an iOS Framework for developer."
  s.homepage     = "https://github.com/JxbSir"
  s.license      = "Peter"
  s.author       = { "Peter" => "i@jxb.name" }
  s.requires_arc = true
  s.source       = { :git => "https://github.com/JxbSir/JxbFramework.git"  }
  s.source_files = "JXBFramework/XBFramework/*.{h,m}"
  s.source_files = "JXBFramework/XBFramework/XBApi/*.{h,m}"
  s.source_files = "JXBFramework/XBFramework/XBCategory/*.{h,m}"
  s.source_files = "JXBFramework/XBFramework/XBCategory/UIAlertView/*.{h,m}"
  s.source_files = "JXBFramework/XBFramework/XBDbHelper/*.{h,m}"
  s.source_files = "JXBFramework/XBFramework/XBHttp/*.{h,m}"
  s.source_files = "JXBFramework/XBFramework/XBParser/*.{h,m}"
  s.source_files = "JXBFramework/XBFramework/XBUi/*.{h,m}"
  s.source_files = "JXBFramework/XBFramework/XBUi/XBBaseTabVC/*.{h,m}"
  s.source_files = "JXBFramework/XBFramework/XBUi/XBBaseVC/*.{h,m}"
  s.source_files = "JXBFramework/XBFramework/XBUi/XBBaseVC/BaseView/*.{h,m}"
  s.source_files = "JXBFramework/XBFramework/XBUtils/*.{h,m}"
  s.public_header_files = 'JXBFramework/XBFramework/XBFramework.h'
  s.frameworks   = 'UIKit'
end
