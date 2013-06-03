module Jenkinsrc
  module Plugins
    module Git
      class GitSCM
        attr_reader :remote_url, :branch

        def initialize(dom)
          if dom.respond_to?(:at_xpath)
            @remote_url = dom.at_xpath('userRemoteConfigs/hudson.plugins.git.UserRemoteConfig/url').text
            @branch = dom.at_xpath('branches/hudson.plugins.git.BranchSpec/name').text
          else
            @remote_url = dom['url']
            @branch = dom['branch']
          end
        end
      end
    end
  end
end
