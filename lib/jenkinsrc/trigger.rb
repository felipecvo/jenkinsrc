module Jenkinsrc
  module Trigger
    class << self
      def build(hash)
        Jenkinsrc::Jobs::SCMTrigger.new(hash)
      end
    end
  end
end
