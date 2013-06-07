require 'spec_helper'

describe Jenkinsrc::Plugins::Parameterizedtrigger::BuildTrigger do
  let(:dom) { Nokogiri::XML('<configs> <hudson.plugins.parameterizedtrigger.BuildTriggerConfig> <configs> <hudson.plugins.git.GitRevisionBuildParameters/> <hudson.plugins.parameterizedtrigger.FileBuildParameters> <propertiesFile>$WORKSPACE/STRUCTURE_REVISION</propertiesFile> </hudson.plugins.parameterizedtrigger.FileBuildParameters> </configs> <projects>jenkinsrc-unit-tests</projects> <condition>SUCCESS</condition> <triggerWithNoParameters>false</triggerWithNoParameters> </hudson.plugins.parameterizedtrigger.BuildTriggerConfig> </configs>') }
  subject { described_class.new(dom) }

  it 'should convert to xml' do
    builder = Nokogiri::XML::Builder.new do |xml|
      subject.to_xml(xml)
    end

    builder.to_xml.should eql "<?xml version=\"1.0\"?>
<hudson.plugins.parameterizedtrigger.BuildTrigger>
  <configs>
    <hudson.plugins.parameterizedtrigger.BuildTriggerConfig>
      <configs>
        <hudson.plugins.git.GitRevisionBuildParameters/>
        <hudson.plugins.parameterizedtrigger.FileBuildParameters>
          <propertiesFile>$WORKSPACE/STRUCTURE_REVISION</propertiesFile>
        </hudson.plugins.parameterizedtrigger.FileBuildParameters>
      </configs>
      <projects>jenkinsrc-unit-tests</projects>
      <condition>SUCCESS</condition>
      <triggerWithNoParameters>false</triggerWithNoParameters>
    </hudson.plugins.parameterizedtrigger.BuildTriggerConfig>
  </configs>
</hudson.plugins.parameterizedtrigger.BuildTrigger>
"
  end
end
