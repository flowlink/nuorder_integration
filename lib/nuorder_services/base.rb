module NuOrderServices
  class Base
    attr_reader :nuorder, :config

    def initialize(config)
      @config = config
    end

    private

    def nuorder
      @nuorder ||= NuOrderConnector::Connector.new(
        consumer_key: config['nuorder_consumer_key'],
        consumer_secret: config['nuorder_consumer_secret'],
        oauth_token: config['nuorder_token'],
        oauth_token_secret: config['nuorder_token_secret']
      )
    end
  end
end
