#encoding: utf-8
require 'rake'

Gem::Specification.new do |s|
  s.name        = "FacebookParser"
  s.version     = "0.1.2"
  s.date        = '2012-02-17'
  s.authors     = ["Nicholas Pufal"]
  s.email       = ["niko.pufal@gmail.com"]
  s.homepage    = "https://github.com/nicholaspufal/facebookparser"
  s.summary     = %q{Parser for Facebook Pages using the Graph API}
  s.description = %q{This gem was made in 2 hours for an experiemntal project, so yes, it's pretty simple yet, but I hope is still useful.'}
  s.add_dependency 'httparty'
  #s.post_install_message = ""
  s.files         = FileList['lib/**/*.rb']
end