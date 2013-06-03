require 'spec_helper'

describe Jenkinsrc::Jobs::LogRotator do
  context "default values" do
    subject { described_class.new }
    its(:days_to_keep) { should eq -1 }
    its(:num_to_keep) { should eq -1 }
    its(:artifact_days_to_keep) { should eq -1 }
    its(:artifact_num_to_keep) { should eq -1 }
  end

  context "specific value" do
    subject { described_class.new(:num_to_keep => 4) }
    its(:days_to_keep) { should eq -1 }
    its(:num_to_keep) { should eq 4 }
    its(:artifact_days_to_keep) { should eq -1 }
    its(:artifact_num_to_keep) { should eq -1 }
  end

  context "specific value as string" do
    subject { described_class.new(:days_to_keep => "10") }
    its(:days_to_keep) { should eq 10 }
    its(:num_to_keep) { should eq -1 }
    its(:artifact_days_to_keep) { should eq -1 }
    its(:artifact_num_to_keep) { should eq -1 }
  end

  context "to yaml" do
    context "all default values" do
      subject { described_class.new }
      its(:to_yaml) { should eq "--- !ruby/object:Jenkinsrc::Jobs::LogRotator {}\n" }
    end

    context "only specific values" do
      subject { described_class.new(:num_to_keep => 2) }
      its(:to_yaml) { should_not be_empty }
      its(:to_yaml) { should eq "--- !ruby/object:Jenkinsrc::Jobs::LogRotator\nnum_to_keep: 2\n" }
    end
  end
end
