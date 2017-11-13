Pod::Spec.new do |s|
s.name             = "EZSwiftExtensions"
s.version          = "0.1"
s.summary          = "支持自定义子元素的 Tag 视图组件，某些情况下比用 CollectionView 更加方便。"
s.description      = "支持自定义子元素的 Tag 视图组件，某些情况下比用 CollectionView 更加方便。"
s.homepage         = "https://github.com/shiweifu/DPTagView"
s.license          = 'MIT'
s.author           = { "shiweifu" => "shiweifu@gmail.com" }
s.source           = { :git => "https://github.com/shiweifu/DPTagView.git", :tag => s.version.to_s }
s.ios.deployment_target   = '8.0'
s.requires_arc = true
s.source_files = 'DPTagView/DPTagView.swift' 

end