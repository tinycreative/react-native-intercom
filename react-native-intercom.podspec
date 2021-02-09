require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = package['name']
  s.version      = package['version'].sub('-beta', '')
  s.license      = { :type => 'MIT' }
  s.homepage     = package['homepage']
  s.authors      = package['contributors'].flat_map { |author| { author['name'] => author['email'] } }
  s.summary      = package['description']
  s.source       = { :git => package['repository']['url'] }
  s.source_files = 'iOS/*.{h,m}'
  s.platform     = :ios, '10.0'
  s.frameworks   = [ "Intercom" ]
  s.static_framework = true
  s.dependency 'React'
  s.dependency 'Intercom', '~> 9.0.0'
end
