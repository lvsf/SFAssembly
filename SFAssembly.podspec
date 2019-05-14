Pod::Spec.new do |s|
    s.name         = 'SFAssembly'
    s.version      = '0.0.1'
    s.summary      = '简易的表单视图'
    s.homepage     = 'https://github.com/lvsf/SFAssembly'
    s.license      = 'MIT'
    s.authors      = {'lvsf' => 'lvsf1992@163.com'}
    s.platform     = :ios, '7.0'
    s.source       = {:git => 'https://github.com/lvsf/SFAssembly.git', :tag => s.version}
    s.source_files = 'SFAssembly/Class/**/*'
    s.requires_arc = true
end