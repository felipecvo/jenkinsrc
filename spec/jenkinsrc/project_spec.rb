require 'spec_helper'

describe Jenkinsrc::Project do
  its(:server) { should be_a Jenkinsrc::Server }
  its(:jobs) { should be_an Array }

  context "#name" do
    before { subject.name = "test" }
    its(:name) { should eq "test" }
  end
end
