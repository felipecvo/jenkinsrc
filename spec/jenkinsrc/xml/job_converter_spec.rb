require 'spec_helper'

describe Jenkinsrc::XML::JobConverter do
  let(:job) { Jenkinsrc::Job.new }

  before do
    job.name = 'jenkinsrc-unit_test'
    job.description = 'Job description ok.'
    job.log_rotator = Jenkinsrc::Jobs::LogRotator.new(:num_to_keep => 5)
    job.scm = Jenkinsrc::Plugins::Git::GitSCM.new('url' => 'git@github.com:felipecvo/jenkinsrc.git', 'branch' => 'master')
    job.disabled = true
    job.triggers << Jenkinsrc::Jobs::SCMTrigger.new(:spec => '*/5 * * * *')
    job.builders << Jenkinsrc::Tasks::Shell.new(:command => "export STRUCTURE_PATH=$WORKSPACE/../structure

if [[ -d $STRUCTURE_PATH ]]; then
  rm -rf $STRUCTURE_PATH
fi

git clone git://github.com/felipecvo/jenkinsrc-structure.git $STRUCTURE_PATH
pushd $STRUCTURE_PATH
  git checkout -t origin/v2012
  echo \"STRUCTURE_SHA1=$(git log -1 --pretty=format:%H)\" > $WORKSPACE/STRUCTURE_REVISION
popd

export PATH=$PATH:/var/lib/jenkins/.rvm/bin
[[ ! `rvm gemset list | grep jenkinsrc` ]] && rvm gemset create jenkinsrc
source $(rvm env --path -- ree@jenkinsrc)
gem env
[[ `gem list | grep bundler` ]] || gem install bundler
bundle install")
    job.publishers << Jenkinsrc::Plugins::Parameterizedtrigger::BuildTrigger.new(Nokogiri::XML('<configs> <hudson.plugins.parameterizedtrigger.BuildTriggerConfig> <configs> <hudson.plugins.git.GitRevisionBuildParameters/> <hudson.plugins.parameterizedtrigger.FileBuildParameters> <propertiesFile>$WORKSPACE/STRUCTURE_REVISION</propertiesFile> </hudson.plugins.parameterizedtrigger.FileBuildParameters> </configs> <projects>jenkinsrc-unit-tests</projects> <condition>SUCCESS</condition> <triggerWithNoParameters>false</triggerWithNoParameters> </hudson.plugins.parameterizedtrigger.BuildTriggerConfig> </configs>'))
  end

  it 'should convert to xml' do
    xml = <<-EOF
<?xml version="1.0" encoding="UTF-8"?>
<project>
  <actions/>
  <description>Job description ok.</description>
  <logRotator>
    <daysToKeep>-1</daysToKeep>
    <numToKeep>5</numToKeep>
    <artifactDaysToKeep>-1</artifactDaysToKeep>
    <artifactNumToKeep>-1</artifactNumToKeep>
  </logRotator>
  <keepDependencies>false</keepDependencies>
  <properties/>
  <scm class="hudson.plugins.git.GitSCM">
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
    <buildChooser class="hudson.plugins.git.util.DefaultBuildChooser"/>
    <gitTool>Default</gitTool>
    <submoduleCfg class="list"/>
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
  <canRoam>true</canRoam>
  <disabled>true</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <triggers class="vector">
    <hudson.triggers.SCMTrigger>
      <spec>*/5 * * * *</spec>
    </hudson.triggers.SCMTrigger>
  </triggers>
  <concurrentBuild>false</concurrentBuild>
  <builders>
    <hudson.tasks.Shell>
      <command>export STRUCTURE_PATH=$WORKSPACE/../structure

if [[ -d $STRUCTURE_PATH ]]; then
  rm -rf $STRUCTURE_PATH
fi

git clone git://github.com/felipecvo/jenkinsrc-structure.git $STRUCTURE_PATH
pushd $STRUCTURE_PATH
  git checkout -t origin/v2012
  echo \"STRUCTURE_SHA1=$(git log -1 --pretty=format:%H)\" &gt; $WORKSPACE/STRUCTURE_REVISION
popd

export PATH=$PATH:/var/lib/jenkins/.rvm/bin
[[ ! `rvm gemset list | grep jenkinsrc` ]] &amp;&amp; rvm gemset create jenkinsrc
source $(rvm env --path -- ree@jenkinsrc)
gem env
[[ `gem list | grep bundler` ]] || gem install bundler
bundle install</command>
    </hudson.tasks.Shell>
  </builders>
  <publishers>
    <hudson.plugins.parameterizedtrigger.BuildTrigger>
      <configs>
        <hudson.plugins.parameterizedtrigger.BuildTriggerConfig>
          <configs>
            <hudson.plugins.git.GitRevisionBuildParameters/>
            <hudson.plugins.parameterizedtrigger.FileBuildParameters>
              <propertiesFile>$WORKSPACE/STRUCTURE_REVISION</propertiesFile>
            </hudson.plugins.parameterizedtrigger.FileBuildParameters>
          </configs>
          <projects>jenkinsrc-unit-tests</projects>
          <condition>SUCCESS</condition>
          <triggerWithNoParameters>false</triggerWithNoParameters>
        </hudson.plugins.parameterizedtrigger.BuildTriggerConfig>
      </configs>
    </hudson.plugins.parameterizedtrigger.BuildTrigger>
  </publishers>
  <buildWrappers/>
</project>
EOF
    job.to_xml.should eq xml
  end
end
