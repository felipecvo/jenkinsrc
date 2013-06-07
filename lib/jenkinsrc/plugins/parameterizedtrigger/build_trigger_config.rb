module Jenkinsrc
  module Plugins
    module Parameterizedtrigger
      class BuildTriggerConfig
        attr_reader :projects_to_build, :condition, :trigger_with_no_params, :configs

        def initialize(dom)
          @projects_to_build = dom.at_xpath('projects').text.split(',')
          @condition = dom.at_xpath('condition').text
          @trigger_with_no_params = dom.at_xpath('triggerWithNoParameters').text == 'true'
          @configs = []
          dom.at_xpath('configs').children.each do |child|
            next unless child.type == 1
            @configs << Jenkinsrc.constantize(child.name).new(child)
          end
        end

        def trigger_with_no_params?
          @trigger_with_no_params
        end

        def to_xml(builder)
          builder.send('hudson.plugins.parameterizedtrigger.BuildTriggerConfig') do |xml|
            xml.configs do
              self.configs.each do |config|
                config.to_xml(xml)
              end
            end
            xml.projects do
              xml.text(self.projects_to_build.join(','))
            end
            xml.condition do
              xml.text('SUCCESS')
            end
            xml.triggerWithNoParameters do
              xml.text(false)
            end
          end
        end
      end
    end
  end
end
