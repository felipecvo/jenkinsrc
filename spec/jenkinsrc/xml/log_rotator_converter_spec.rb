require 'spec_helper'

describe Jenkinsrc::XML::LogRotatorConverter do
  let(:log_rotator) { Jenkinsrc::Jobs::LogRotator.new :num_to_keep => 5 }

  it 'should convert to xml with a builder' do
    builder = Nokogiri::XML::Builder.new do |xml|
      log_rotator.to_xml(xml)
    end

    builder.to_xml.should eql "<?xml version=\"1.0\"?>
<logRotator>
  <daysToKeep>-1</daysToKeep>
  <numToKeep>5</numToKeep>
  <artifactDaysToKeep>-1</artifactDaysToKeep>
  <artifactNumToKeep>-1</artifactNumToKeep>
</logRotator>
"
  end
end
