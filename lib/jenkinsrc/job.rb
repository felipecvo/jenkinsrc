module Jenkinsrc
  class Job
    attr_accessor :name, :description, :log_rotator, :scm, :disabled, :block_build_whn_downstream_building,
      :block_build_whn_upstream_building, :triggers, :concurrent_build, :builders, :publishers

    def initialize
      @triggers = []
      @builders = []
      @publishers = []
    end

    def block_build_whn_downstream_building?
      @block_build_whn_downstream_building
    end

    def block_build_whn_upstream_building?
      @block_build_whn_upstream_building
    end

    def disabled?
      @disabled
    end

    def concurrent_build?
      @concurrent_build
    end

    def to_yaml
      hash = {}
      hash[:name] = @name
      hash[:description] = @description
      hash[:log_rotator] = {}
      @log_rotator.encode_with(hash[:log_rotator])
      hash[:scm] = {
        :plugin => @scm.class.name.split('::').last,
        :remote_url => @scm.remote_url,
        :branch => @scm.branch
      }
      hash[:build_triggers] = {
        :poll_scm => @triggers.first.spec
      }
      hash[:build] = {
        :shell => @builders.first.command
      }
      hash[:post_build] = {
        :parameterizedtrigger => {
          :build_trigger => {
            :params => {
              :gitrevisionbuild => true,
              :filebuildparam => '$WORKSPACE/STRUCTURE_REVISION'
            },
            :projects_to_build => ['jenkinsrc-unit-tests']
          }
        }
      }
      hash.to_yaml
    end
  end
end
