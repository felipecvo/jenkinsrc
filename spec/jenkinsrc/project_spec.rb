require 'spec_helper'

describe Jenkinsrc::Project do
  it 'should load project from .jenkinsrc file' do
    file_path = File.expand_path('../../fixtures/jenkinsrc.yaml', __FILE__)
    Jenkinsrc::Project.load_file(file_path)
  end
  #its(:server) { should be_a Jenkinsrc::Server }
  #its(:jobs) { should be_an Array }

  #context "#name" do
  #  before { subject.name = "test" }
  #  its(:name) { should eq "test" }
  #end
end
