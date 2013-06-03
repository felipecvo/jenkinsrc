module Jenkinsrc
  module Jobs
    class ShellTask
      attr_reader :command

      def initialize(hash)
        @command = hash[:command]
      end
    end
  end
end
