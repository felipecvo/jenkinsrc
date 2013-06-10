require 'spec_helper'

describe Jenkinsrc::Job do
  subject { described_class.new }

  #context "to yaml" do
  #  before do
  #    subject.name = 'jenkinsrc-code-pull'
  #    subject.description = "First job in Jenkinsrcs pipeline."
  #    subject.scm = Jenkinsrc::Plugins::Git::GitSCM.new('url' => 'git@github.com:felipecvo/jenkinsrc.git', 'branch' => 'master')
  #    subject.log_rotator = Jenkinsrc::Jobs::LogRotator.new(:num_to_keep => 5)
  #    subject.triggers << Jenkinsrc::Jobs::SCMTrigger.new(:spec => '*/5 * * * *')
  #    subject.builders << Jenkinsrc::Tasks::Shell.new(:command => 'make build')
  #  end

  #  let(:expected_yaml) { File.read(File.expand_path('../../fixtures/job.yml', __FILE__))}

  #  its(:to_yaml) { should eq expected_yaml }
  #end

  context "initialize with hash" do
    let(:hash) do
      {
        'name' => 'my job', 'description' => 'simple desc',
        'scm' => { 'plugin' => 'git', 'url' => 'git@github.com:felipecvo/jenkinsrc.git', 'branch' => 'master' },
        'block_build_when_downstream_building' => true,
        'triggers' => [{ 'trigger' => 'SCMTrigger', 'spec' => '*/5 * * * *' }],
        'builders' => [{ 'task' => 'Shell', 'command' => 'make test' }],
        'publishers' => [{'plugin' => 'parameterizedtrigger', 'file_build_parameters' => 'WORKSPACE', 'projects' => 'jenkinsrc-unit-tests', 'condition' => 'SUCCESS'}]
      }
    end

    subject { described_class.new(hash) }

    its(:name) { should eq 'my job' }
    its(:description) { should eq 'simple desc' }
    its(:log_rotator) { should be_a Jenkinsrc::Jobs::LogRotator }
    its(:scm) { should be_a Jenkinsrc::Plugins::Git::GitSCM }
    its(:disabled) { should be_false }
    its(:block_build_when_downstream_building) { should be_true }
    its(:block_build_when_upstream_building) { should be_false }
    its('triggers.first') { should be_a Jenkinsrc::Jobs::SCMTrigger }
    its(:concurrent_build) { should be_false }
    its('builders.first') { should be_a Jenkinsrc::Tasks::Shell }
    its('publishers.first') { should be_a Jenkinsrc::Plugins::Parameterizedtrigger::BuildTrigger }
    its('build_wrappers') { should be_empty }
  end
end
