#encoding: utf-8
require 'rake'

Gem::Specification.new do |s|
  s.name        = "facebook_page_parser"
  s.version     = "0.1.0"
  s.date        = '2012-02-24'
  s.authors     = ["Nicholas Pufal"]
  s.email       = ["niko.pufal@gmail.com"]
  s.homepage    = "https://github.com/nicholaspufal/facebook-page-parser"
  s.summary     = %q{Parser for Facebook Pages using the Graph API}
  s.description = %q{This is a very simple parser for Facebook Pages (a.k.a fan pages), using the Graph API. This gem was made in 2 hours for an experimental project, so many small fixes need to be made. You're welcome to make a pull request :)'}
  
  s.add_runtime_dependency 'httparty'
  
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'webmock', '~> 1.7.0'

  s.files         = FileList['lib/**/*.rb']
end