require 'jenkinsrc/marshal'
require 'jenkinsrc/xml/job_converter'
require 'jenkinsrc/xml/log_rotator_converter'
require 'jenkinsrc/jobs/log_rotator'
require 'jenkinsrc/jobs/scm_trigger'
require 'jenkinsrc/job'
require 'jenkinsrc/project'
require 'jenkinsrc/builder'
require 'jenkinsrc/publisher'
require 'jenkinsrc/trigger'
require 'jenkinsrc/server'
require 'jenkinsrc/version'

root = File.expand_path('..', __FILE__)
Dir.glob(File.join(root, 'jenkinsrc/plugins/**/*.rb')).each do |file|
  require file.gsub(root, '').gsub(/^\//, '').gsub(/\.rb$/, '')
end

Dir.glob(File.join(root, 'jenkinsrc/tasks/**/*.rb')).each do |file|
  require file.gsub(root, '').gsub(/^\//, '').gsub(/\.rb$/, '')
end

module Jenkinsrc
  def self.constantize(text)
    if /hudson\.plugins\.([^.]+)\.(.+)/ =~ text
      Jenkinsrc::Plugins.const_get($1.capitalize).const_get($2)
    elsif /hudson\.tasks\.(.+)/ =~ text
      Jenkinsrc::Tasks.const_get($1)
    end
  end
end
