module Jenkinsrc
  module XML
    module JobConverter
      def to_xml
        Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
          xml.project do
            xml.actions
            xml.description do
              xml.text(self.description)
            end
            self.log_rotator.to_xml(xml)
            xml.keepDependencies do
              xml.text(false)
            end
            xml.properties
            self.scm.to_xml(xml)
            xml.canRoam do
              xml.text(true)
            end
            xml.disabled do
              xml.text(self.disabled)
            end
            xml.blockBuildWhenDownstreamBuilding do
              xml.text(self.block_build_when_downstream_building?)
            end
            xml.blockBuildWhenUpstreamBuilding do
              xml.text(self.block_build_when_upstream_building?)
            end
            xml.triggers(:class => 'vector') do
              self.triggers.each do |trigger|
                trigger.to_xml(xml)
              end
            end
            xml.concurrentBuild do
              xml.text(self.concurrent_build?)
            end
            xml.builders do
              self.builders.each do |job_builder|
                job_builder.to_xml(xml)
              end
            end
            xml.publishers do
              self.publishers.each do |publisher|
                publisher.to_xml(xml)
              end
            end
            xml.buildWrappers do
              self.build_wrappers.each do |wrapper|
                wrapper.to_xml(xml)
              end
            end
          end
        end.to_xml
      end
    end
  end
end
