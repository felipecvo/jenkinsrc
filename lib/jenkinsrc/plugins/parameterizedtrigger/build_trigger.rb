module Jenkinsrc
  module Plugins
    module Parameterizedtrigger
      class BuildTrigger
        attr_reader :triggers

        def initialize(dom)
          @triggers = []
          dom.xpath('configs').each do |child|
            next if child.type != 1
            @triggers << BuildTriggerConfig.new(child.at_xpath('hudson.plugins.parameterizedtrigger.BuildTriggerConfig'))
          end
        end
      end
    end
  end
end
