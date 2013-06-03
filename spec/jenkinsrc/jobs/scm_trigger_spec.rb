require 'spec_helper'

describe Jenkinsrc::Jobs::SCMTrigger do
  context "default values" do
    subject { described_class.new }
    its(:spec) { should eq '* * * * *' }
  end

  context "specific value" do
    subject { described_class.new(:spec => '0 * * * *') }
    its(:spec) { should eq '0 * * * *' }
  end

  context "to yaml" do
    its(:to_yaml) { should eq "--- !poll_scm\nschedule: '* * * * *'\n" }
  end
end
