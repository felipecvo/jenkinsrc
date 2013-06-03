require 'spec_helper'

describe Jenkinsrc::Server do
  subject { described_class.new('http://v-jenkins-01:8080/') }

  its(:url) { should eq 'http://v-jenkins-01:8080/' }
end
