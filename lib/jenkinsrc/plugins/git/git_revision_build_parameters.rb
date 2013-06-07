module Jenkinsrc
  module Plugins
    module Git
      class GitRevisionBuildParameters
        def initialize(dom)
        end

        def to_xml(builder)
          builder.send('hudson.plugins.git.GitRevisionBuildParameters')
        end
      end
    end
  end
end
