module Jenkinsrc
  module Plugins
    module Parameterizedtrigger
      class FileBuildParameters
        attr_reader :properties_file

        def initialize(dom)
          @properties_file = dom.at_xpath('propertiesFile').text
        end
      end
    end
  end
end
