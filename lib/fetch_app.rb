require "fetch_app/version"
module FetchApp
  # Your code goes here...
  def class << self
    def fetch_app type,bundle
    end


    def config
      @config = YAML.load('fetch_app/config.yaml')
    end
  end
end
