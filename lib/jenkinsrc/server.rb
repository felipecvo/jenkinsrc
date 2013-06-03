module Jenkinsrc
  class Server
    attr_reader :url

    def initialize(url)
      @url = url
    end

    def to_yaml_type
      ''
    end
  end
end
