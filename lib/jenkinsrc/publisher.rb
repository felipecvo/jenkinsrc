module Jenkinsrc
  module Publisher
    class << self
      def build(hash)
        Jenkinsrc::Plugins::Parameterizedtrigger::BuildTrigger.new(hash)
      end
    end
  end
end
