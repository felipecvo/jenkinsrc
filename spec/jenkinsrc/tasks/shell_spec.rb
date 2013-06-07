require 'spec_helper'

describe Jenkinsrc::Tasks::Shell do
  subject { described_class.new(:command => 'make && make test && echo "ok" > /dev/null')}

  it 'should convert to xml' do
    builder = Nokogiri::XML::Builder.new do |xml|
      subject.to_xml(xml)
    end

    builder.to_xml.should eql "<?xml version=\"1.0\"?>
<hudson.tasks.Shell>
  <command>make &amp;&amp; make test &amp;&amp; echo \"ok\" &gt; /dev/null</command>
</hudson.tasks.Shell>
"
  end
end
