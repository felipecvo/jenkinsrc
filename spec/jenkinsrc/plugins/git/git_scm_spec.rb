require 'spec_helper'

describe Jenkinsrc::Plugins::Git::GitSCM do
  subject { described_class.new('url' => 'git@github.com:felipecvo/jenkinsrc.git', 'branch' => 'master') }

  it 'should convert to xml' do
    builder = Nokogiri::XML::Builder.new do |xml|
      subject.to_xml(xml)
    end

    builder.to_xml.should eql "<?xml version=\"1.0\"?>
<scm class=\"hudson.plugins.git.GitSCM\">
  <configVersion>2</configVersion>
  <userRemoteConfigs>
    <hudson.plugins.git.UserRemoteConfig>
      <name/>
      <refspec/>
      <url>git@github.com:felipecvo/jenkinsrc.git</url>
    </hudson.plugins.git.UserRemoteConfig>
  </userRemoteConfigs>
  <branches>
    <hudson.plugins.git.BranchSpec>
      <name>master</name>
    </hudson.plugins.git.BranchSpec>
  </branches>
  <disableSubmodules>false</disableSubmodules>
  <recursiveSubmodules>false</recursiveSubmodules>
  <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
  <authorOrCommitter>false</authorOrCommitter>
  <clean>false</clean>
  <wipeOutWorkspace>false</wipeOutWorkspace>
  <pruneBranches>false</pruneBranches>
  <remotePoll>false</remotePoll>
  <ignoreNotifyCommit>false</ignoreNotifyCommit>
  <buildChooser class=\"hudson.plugins.git.util.DefaultBuildChooser\"/>
  <gitTool>Default</gitTool>
  <submoduleCfg class=\"list\"/>
  <relativeTargetDir/>
  <reference/>
  <excludedRegions/>
  <excludedUsers/>
  <gitConfigName/>
  <gitConfigEmail/>
  <skipTag>false</skipTag>
  <includedRegions/>
  <scmName/>
</scm>
"
  end
end
