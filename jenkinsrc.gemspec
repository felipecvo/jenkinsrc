lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jenkinsrc/version'

Gem::Specification.new do |s|
  s.name        = 'jenkinsrc'
  s.version     = Jenkinsrc::VERSION
  s.date        = '2013-03-01'
  s.summary     = 'Jenkins Remote Control'
  s.description = 'Control your jenkins configuration remote'
  s.authors     = ["Felipe Oliveira"]
  s.email       = 'felipecvo@gmail.com'
  s.homepage    = 'http://felipecvo.github.com/jenkinsrc'

  s.required_rubygems_version = ">= 1.3.6"

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- {spec}/*`.split("\n")
  s.require_path = 'lib'

  s.add_dependency "nokogiri", "~> 1.5.9"

  s.add_development_dependency "rspec", "~> 2.13.0"
  s.add_development_dependency "rake", "~> 10.0.3"
  #s.add_development_dependency "fakefs", "~> 0.4.2"
end
