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
    pending(:to_yaml) { should eq "--- !poll_scm\nschedule: '* * * * *'\n" }
  end

  context "to xml" do
    it 'should return it in xml form' do
      builder = Nokogiri::XML::Builder.new do |xml|
        subject.to_xml(xml)
      end
      builder.to_xml.should eql "<?xml version=\"1.0\"?>
<hudson.triggers.SCMTrigger>
  <spec>* * * * *</spec>
</hudson.triggers.SCMTrigger>
"
    end
  end
end
