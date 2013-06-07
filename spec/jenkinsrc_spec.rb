require 'spec_helper'

describe Jenkinsrc do
  context 'constantize plugins' do
    it 'should return Git::UserRemoteConfig' do
      const = Jenkinsrc.constantize('hudson.plugins.git.UserRemoteConfig')
      const.should eql Jenkinsrc::Plugins::Git::UserRemoteConfig
    end

    it 'should return Git::GitSCM' do
      const = Jenkinsrc.constantize('hudson.plugins.git.GitSCM')
      const.should eql Jenkinsrc::Plugins::Git::GitSCM
    end

    it 'should return Git::BranchSpec' do
      const = Jenkinsrc.constantize('hudson.plugins.git.BranchSpec')
      const.should eql Jenkinsrc::Plugins::Git::BranchSpec
    end

    it 'should return Parameterizedtrigger::BuildTrigger' do
      const = Jenkinsrc.constantize('hudson.plugins.parameterizedtrigger.BuildTrigger')
      const.should eql Jenkinsrc::Plugins::Parameterizedtrigger::BuildTrigger
    end

    it 'should return Parameterizedtrigger::BuildTriggerConfig' do
      const = Jenkinsrc.constantize('hudson.plugins.parameterizedtrigger.BuildTriggerConfig')
      const.should eql Jenkinsrc::Plugins::Parameterizedtrigger::BuildTriggerConfig
    end

    it 'should return Parameterizedtrigger::FileBuildParameters' do
      const = Jenkinsrc.constantize('hudson.plugins.parameterizedtrigger.FileBuildParameters')
      const.should eql Jenkinsrc::Plugins::Parameterizedtrigger::FileBuildParameters
    end
  end

  context 'constantize tasks' do
    it 'should return Jenkinsrc::Tasks::Shell' do
      const = Jenkinsrc.constantize('hudson.tasks.Shell')
      const.should eql Jenkinsrc::Tasks::Shell
    end

    it 'should return Jenkinsrc::Tasks::BuildTrigger' do
      const = Jenkinsrc.constantize('hudson.tasks.BuildTrigger')
      const.should eql Jenkinsrc::Tasks::BuildTrigger
    end
  end
end
