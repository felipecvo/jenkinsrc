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

        def to_xml(builder)
          builder.scm(:class => 'hudson.plugins.git.GitSCM') do |xml|
            xml.configVersion do
              xml.text(2)
            end
            xml.userRemoteConfigs do
              xml.send('hudson.plugins.git.UserRemoteConfig') do
                xml.name
                xml.refspec
                xml.url do
                  xml.text(self.remote_url)
                end
              end
            end
            xml.branches do
              xml.send('hudson.plugins.git.BranchSpec') do
                xml.name do
                  xml.text(self.branch)
                end
              end
            end
            %w[disableSubmodules recursiveSubmodules doGenerateSubmoduleConfigurations authorOrCommitter clean wipeOutWorkspace pruneBranches remotePoll ignoreNotifyCommit].each do |tag|
              xml.send tag do
                xml.text(false)
              end
            end
            xml.buildChooser(:class => 'hudson.plugins.git.util.DefaultBuildChooser')
            xml.gitTool do
              xml.text('Default')
            end
            xml.submoduleCfg(:class => 'list')
            %w[relativeTargetDir reference excludedRegions excludedUsers gitConfigName gitConfigEmail].each do |tag|
              xml.send tag
            end
            xml.skipTag do
              xml.text(false)
            end
            xml.includedRegions
            xml.scmName
          end
        end
      end
    end
  end
end
