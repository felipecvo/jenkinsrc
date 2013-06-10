require 'yaml'

module Jenkinsrc
  class Project
    attr_accessor :server, :jobs

    def self.load_file(path)
      yml = YAML.load_file(path)
      project = Project.new
      project.jobs = []
      yml['jobs'].each do |job|
        project.jobs << Job.new(job)
      end
      project
    end
  end
end
