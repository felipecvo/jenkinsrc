require 'nokogiri'

module Jenkinsrc
  module Marshal
    class << self
      attr_accessor :pwd

      def dump(project)
        yaml = project.to_yaml
        File.open(file, 'w') { |f| f.write(yaml) }
      end

      def from_xml(xml)
        dom = Nokogiri::XML(xml)
        job = Job.new
        job.description = dom.at_xpath('/project/description').text

        if dom.at_xpath('/project/logRotator')
          job.log_rotator = Jobs::LogRotator.new(
            :num_to_keep => dom.at_xpath('/project/logRotator/numToKeep').text,
            :days_to_keep => dom.at_xpath('/project/logRotator/daysToKeep').text,
            :artifact_num_to_keep => dom.at_xpath('/project/logRotator/artifactNumToKeep').text,
            :artifact_days_to_keep => dom.at_xpath('/project/logRotator/artifactDaysToKeep').text)
        end

        #job.git_scm = Jobs::GitSCM.new(dom)
        scm_dom = dom.at_xpath('/project/scm')
        scm_class = scm_dom['class']
        job.scm = Jenkinsrc.constantize(scm_class).new(scm_dom)

        job.disabled = dom.at_xpath('/project/disabled').text == 'true'
        job.block_build_when_downstream_building = dom.at_xpath('/project/blockBuildWhenDownstreamBuilding').text == 'true'
        job.block_build_when_upstream_building = dom.at_xpath('/project/blockBuildWhenUpstreamBuilding').text == 'true'
        job.concurrent_build = dom.at_xpath('/project/concurrentBuild').text == 'true'
        dom.at_xpath('/project/triggers').children.each do |child|
          next if child.type != 1
          klass = Jenkinsrc::Jobs.const_get(child.name.gsub('hudson.triggers.', ''))
          hash = child.children.select { |c| c.type == 1 }.inject({}) { |a,b| a[b.name.to_sym] = b.text; a }
          job.triggers << klass.new(hash)
        end
        dom.at_xpath('/project/builders').children.each do |child|
          next if child.type != 1
          klass = Jenkinsrc.constantize(child.name)
          hash = child.children.select { |c| c.type == 1 }.inject({}) { |a,b| a[b.name.to_sym] = b.text; a }
          job.builders << klass.new(hash)
        end
        dom.at_xpath('/project/publishers').children.each do |child|
          next if child.type != 1
          puts child.name
          job.publishers << Jenkinsrc.constantize(child.name).new(child)
        end
        job
      end

      private
      def file
        File.join(self.pwd, '.jenkinsrc')
      end
    end

    self.pwd = Dir.pwd
  end
end
