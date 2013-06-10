module Jenkinsrc
  module Plugins
    module Parameterizedtrigger
      class BuildTrigger
        attr_reader :triggers

        def initialize(dom)
          @triggers = []
          if dom.respond_to?(:at_xpath)
            dom.xpath('configs').each do |child|
              next if child.type != 1
              @triggers << BuildTriggerConfig.new(child.at_xpath('hudson.plugins.parameterizedtrigger.BuildTriggerConfig'))
            end
          else
            @triggers << BuildTriggerConfig.new(dom)
          end
        end

        def to_xml(builder)
          builder.send('hudson.plugins.parameterizedtrigger.BuildTrigger') do |xml|
            xml.configs do
              self.triggers.each do |trigger|
                trigger.to_xml(xml)
              end
            end
          end
        end
      end
    end
  end
end
