Pod::Spec.new do |s|
  s.name         = "Bohrium"
  s.version      = "4.2.2"
  s.author       = { "Bas van Kuijck" => "bas@e-sites.nl" }
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.homepage     = "http://www.e-sites.nl"
  s.summary      = "A small helper class to benchmark specific code parts at runtime"
  s.source       = { :git => "https://github.com/e-sites/Bohrium.git", :tag => "v#{s.version}" }
  s.source_files = "Sources/*.{swift,h}"
  s.platform     = :ios, '9.0'
  s.requires_arc  = true
  s.swift_versions = [ '5.0' ]
end
