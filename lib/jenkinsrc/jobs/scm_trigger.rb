module Jenkinsrc
  module Jobs
    class SCMTrigger
      attr_reader :spec

      def initialize(hash = {})
        @spec = hash[:spec] || '* * * * *'
      end

      def encode_with(coder)
        coder['schedule'] = @spec
        coder.tag = '!poll_scm'
      end
    end
  end
end
