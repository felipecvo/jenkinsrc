module Jenkinsrc
  module XML
    module LogRotatorConverter
      def to_xml(builder)
        builder.logRotator do |xml|
          xml.daysToKeep do
            xml.text(self.days_to_keep)
          end
          xml.numToKeep do
            xml.text(self.num_to_keep)
          end
          xml.artifactDaysToKeep do
            xml.text(self.artifact_days_to_keep)
          end
          xml.artifactNumToKeep do
            xml.text(self.artifact_num_to_keep)
          end
        end
      end
    end
  end
end
