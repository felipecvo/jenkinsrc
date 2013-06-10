require 'spec_helper'

describe Jenkinsrc::Trigger do
  it 'should return instance from hash' do
    hash = { 'trigger' => 'SCMTrigger', 'spec' => '* * * * *' }
    trigger = Jenkinsrc::Trigger.build(hash)
    trigger.should be_a Jenkinsrc::Jobs::SCMTrigger
    trigger.spec.should eq '* * * * *'
  end
end
