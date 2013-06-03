require 'spec_helper'

describe Jenkinsrc::Marshal do
  let(:project) { Jenkinsrc::Project.new }
  let(:file_path) { File.join(Dir.pwd, '.jenkinsrc') }
  let(:jenkinsrc_example) { File.read(File.expand_path('../../fixtures/jenkinsrc.yaml', __FILE__))}

  its(:pwd) { should eq File.expand_path('../../../', __FILE__) }

  context "dump data" do
    before do
      FileUtils.rm_rf(file_path)
      project.name = 'Jenkinsrc'
      project.server = Jenkinsrc::Server.new('http://jenkins.com/')
      project.jobs = []
    end

    it "should dump project to .jenkinsrc file" do
      Jenkinsrc::Marshal.dump(project)
      File.exist?(file_path).should be_true
    end

    #it "should have dump to friendly yaml" do
    #  Jenkinsrc::Marshal.dump(project)
    #  puts File.read(file_path)
    #  File.read(file_path).should eq jenkinsrc_example
    #end
  end

  context "convert from jenkins's xml" do
    let(:jenkins_xml) { File.read(File.expand_path('../../fixtures/jenkinsrc.xml', __FILE__)) }
    let(:job) { Jenkinsrc::Marshal.from_xml(jenkins_xml) }

    subject { job }

    it { should be_an Jenkinsrc::Job }
    its(:description) { should eq "First job in Jenkinsrc's pipeline. Very simple, just pulls the git repository every 5 minutes and trigger the pipeline when new code was pushed." }
    its(:log_rotator) { should eq Jenkinsrc::Jobs::LogRotator.new(:days_to_keep => -1, :num_to_keep => 5, :artifact_days_to_keep => -1, :artifact_num_to_keep => -1) }
    its(:disabled?) { should be_true }
    its(:block_build_whn_downstream_building?) { should be_false }
    its(:block_build_whn_upstream_building?) { should be_false }
    its(:concurrent_build?) { should be_false }

    context "parse scm" do
      subject { job.scm }
      it { should be_a Jenkinsrc::Plugins::Git::GitSCM }
      its(:remote_url) { should eq 'git@github.com:felipecvo/jenkinsrc.git' }
      its(:branch) { should eq 'master' }
    end

    context "parse triggers" do
      subject { job.triggers }
      it { should be_an Array }

      context "scm" do
        subject { job.triggers.first }
        it { should be_a Jenkinsrc::Jobs::SCMTrigger }
        its(:spec) { should eq '*/5 * * * *' }
      end
    end

    context "parse builders" do
      subject { job.builders }
      it { should be_an Array }

      context "shell task" do
        subject { job.builders.first }
        it { should be_a Jenkinsrc::Jobs::ShellTask }
        its(:command) { should match /git clone/ }
      end
    end

    context "parse publishers" do
      subject { job.publishers }
      it { should be_an Array }

      context "build parameterized trigger" do
        subject { job.publishers.first }
        it { should be_a Jenkinsrc::Plugins::Parameterizedtrigger::BuildTrigger }
        its(:triggers) { should be_an Array }

        context "config" do
          subject { job.publishers.first.triggers.first }
          it { should be_a Jenkinsrc::Plugins::Parameterizedtrigger::BuildTriggerConfig }
          its(:projects_to_build) { should eq ['jenkinsrc-unit-tests'] }
          its(:condition) { should eq 'SUCCESS' }
          its(:trigger_with_no_params?) { should be_false }
          its(:params) { should be_an Array }

          context "git revision param" do
            subject { job.publishers.first.triggers.first.params.first }
            it { should be_a Jenkinsrc::Plugins::Git::GitRevisionBuildParameters }
          end

          context "file properties param" do
            subject { job.publishers.first.triggers.first.params.last }
            it { should be_a Jenkinsrc::Plugins::Parameterizedtrigger::FileBuildParameters }
            its(:properties_file) { should eq '$WORKSPACE/STRUCTURE_REVISION' }
          end
        end
      end
    end
  end
end
