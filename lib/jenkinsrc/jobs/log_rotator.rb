module Jenkinsrc
  module Jobs
    class LogRotator
      include Jenkinsrc::XML::LogRotatorConverter

      attr_accessor :days_to_keep, :num_to_keep, :artifact_days_to_keep, :artifact_num_to_keep

      def initialize(hash = {})
        hash ||= {}
        @days_to_keep = (hash[:days_to_keep] || -1).to_i
        @num_to_keep = (hash[:num_to_keep] || -1).to_i
        @artifact_days_to_keep = (hash[:artifact_days_to_keep] || -1).to_i
        @artifact_num_to_keep = (hash[:artifact_num_to_keep] || -1).to_i
      end

      def ==(other)
        other.days_to_keep          == self.days_to_keep &&
        other.num_to_keep           == self.num_to_keep &&
        other.artifact_days_to_keep == self.artifact_days_to_keep &&
        other.artifact_num_to_keep  == self.artifact_num_to_keep
      end

      def encode_with(coder)
        coder['days_to_keep'] = @days_to_keep unless @days_to_keep == -1
        coder['num_to_keep'] = @num_to_keep unless @num_to_keep == -1
        coder['artifact_days_to_keep'] = @artifact_days_to_keep unless @artifact_days_to_keep == -1
        coder['artifact_num_to_keep'] = @artifact_num_to_keep unless @artifact_num_to_keep == -1
      end
    end
  end
end
