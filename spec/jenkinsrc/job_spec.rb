require 'spec_helper'

describe Jenkinsrc::Job do
  subject { described_class.new }

  context "to yaml" do
    before do
      subject.name = 'jenkinsrc-code-pull'
      subject.description = "First job in Jenkinsrcs pipeline."
      subject.scm = Jenkinsrc::Plugins::Git::GitSCM.new('url' => 'git@github.com:felipecvo/jenkinsrc.git', 'branch' => 'master')
      subject.log_rotator = Jenkinsrc::Jobs::LogRotator.new(:num_to_keep => 5)
      subject.triggers << Jenkinsrc::Jobs::SCMTrigger.new(:spec => '*/5 * * * *')
      subject.builders << Jenkinsrc::Jobs::ShellTask.new(:command => 'make build')
    end

    let(:expected_yaml) { File.read(File.expand_path('../../fixtures/job.yml', __FILE__))}

    its(:to_yaml) { should eq expected_yaml }
  end
end
