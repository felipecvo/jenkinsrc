module Jenkinsrc
  module Tasks
    class Shell
      attr_reader :command

      def initialize(hash)
        @command = hash[:command]
      end

      def to_xml(builder)
        builder.send('hudson.tasks.Shell') do |xml|
          xml.command do
            xml.text(self.command)
          end
        end
      end
    end
  end
end
