module Jenkinsrc
  module Plugins
    module Parameterizedtrigger
      class BuildTriggerConfig
        attr_reader :projects_to_build, :condition, :trigger_with_no_params, :params

        def initialize(dom)
          @projects_to_build = dom.at_xpath('projects').text.split(',')
          @condition = dom.at_xpath('condition').text
          @trigger_with_no_params = dom.at_xpath('triggerWithNoParameters').text == 'true'
          @params = []
          dom.at_xpath('configs').children.each do |child|
            next unless child.type == 1
            namespace = Jenkinsrc::Plugins.const_get(child.name.gsub(/hudson.plugins.([^.]+).(.+)/, '\1').capitalize)
            klass = namespace.const_get(child.name.gsub(/hudson.plugins.([^.]+).(.+)/, '\2'))
            @params << klass.new(child)
          end
        end

        def trigger_with_no_params?
          @trigger_with_no_params
        end
      end
    end
  end
end
