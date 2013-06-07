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

      def to_xml(builder)
        builder.send('hudson.triggers.SCMTrigger') do |xml|
          xml.spec do
            xml.text(self.spec)
          end
        end
      end
    end
  end
end
