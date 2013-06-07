module Jenkinsrc
  class Job
    include Jenkinsrc::XML::JobConverter

    attr_accessor :name, :description, :log_rotator, :scm, :disabled, :block_build_when_downstream_building,
      :block_build_when_upstream_building, :triggers, :concurrent_build, :builders, :publishers, :build_wrappers

    def initialize
      @triggers = []
      @builders = []
      @publishers = []
      @build_wrappers = []
    end

    def block_build_when_downstream_building?
      @block_build_when_downstream_building == true
    end

    def block_build_when_upstream_building?
      @block_build_when_upstream_building == true
    end

    def disabled?
      @disabled
    end

    def concurrent_build?
      @concurrent_build == true
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
