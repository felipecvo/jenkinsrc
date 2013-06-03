require 'yaml'

module Jenkinsrc
  class Project
    attr_accessor :name, :server, :jobs

    def to_yaml_type
      ''
    end
  end
end
