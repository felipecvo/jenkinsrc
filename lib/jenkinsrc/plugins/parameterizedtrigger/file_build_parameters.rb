module Jenkinsrc
  module Plugins
    module Parameterizedtrigger
      class FileBuildParameters
        attr_reader :properties_file

        def initialize(dom)
          @properties_file = dom.at_xpath('propertiesFile').text
        end

        def to_xml(builder)
          builder.send('hudson.plugins.parameterizedtrigger.FileBuildParameters') do |xml|
            xml.propertiesFile do
              xml.text(self.properties_file)
            end
          end
        end
      end
    end
  end
end
