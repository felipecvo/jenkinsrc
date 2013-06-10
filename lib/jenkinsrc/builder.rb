module Jenkinsrc
  module Builder
    class << self
      def build(hash)
        Jenkinsrc::Tasks::Shell.new(hash)
      end
    end
  end
end
