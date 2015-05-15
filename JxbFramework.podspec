Pod::Spec.new do |s|

  s.name                  = "JxbFramework"
  s.version               = "1.0"
  s.summary               = "It is an iOS Framework for developer."
  s.homepage              = "https://github.com/JxbSir"
  s.license               = "Peter"
  s.author                = { "Peter" => "i@jxb.name" }
  s.requires_arc          = true
  s.ios.deployment_target = '6.0'
  s.source                = { :git => "https://github.com/JxbSir/JxbFramework.git"  }
  s.public_header_files   = 'JXBFramework/XBFramework/XBHeader/XBFramework.h'

  s.subspec 'XBHeader' do |ss|
    ss.source_files = 'JXBFramework/XBFramework/XBHeader/*.{h,m}'
  end

  s.subspec 'XBUtils' do |ss|
    ss.source_files = 'JXBFramework/XBFramework/XBUtils/*.{h,m}'
  end

  s.subspec 'XBDbHelper' do |ss|
    ss.source_files = 'JXBFramework/XBFramework/XBDbHelper/*.{h,m}'
  end

  s.subspec 'XBParser' do |ss|
    ss.source_files = 'JXBFramework/XBFramework/XBParser/*.{h,m}'
  end

  s.subspec 'XBApi' do |ss|
    ss.source_files = 'JXBFramework/XBFramework/XBApi/*.{h,m}'
  end

  s.subspec 'XBCategory' do |ss|
    ss.source_files = 'JXBFramework/XBFramework/XBCategory/*.{h,m}'
    ss.subspec 'UIAlertView' do |sss|
      sss.source_files = 'JXBFramework/XBFramework/XBCategory/UIAlertView/*.{h,m}'
    end
  end

  s.subspec 'XBHttp' do |ss|
    ss.source_files = 'JXBFramework/XBFramework/XBHttp/*.{h,m}'
  end

  s.subspec 'XBUi' do |ss|
    ss.subspec 'XBBaseTabVC' do |sss|
      sss.source_files = 'JXBFramework/XBFramework/XBUi/XBBaseTabVC/*.{h,m}'
    end
    ss.subspec 'XBBaseVC' do |sss|
      sss.source_files = 'JXBFramework/XBFramework/XBUi/XBBaseVC/*.{h,m}'
      sss.subspec 'XBBaseVC' do |ssss|
        ssss.source_files = 'JXBFramework/XBFramework/XBUi/XBBaseVC/BaseView/*.{h,m}'
      end
    end
  end

  s.frameworks            = 'UIKit'
  s.dependency            'AFNetworking'
  s.dependency            'jastor'
  s.dependency            'TouchJSON'
  s.dependency            'MBProgressHUD'
end
