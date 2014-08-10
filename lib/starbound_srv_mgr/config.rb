require 'yaml'

module StarboundSrvMgr
    class Config

        # @var Hash
        @config

        # Initialize the config object with a configuration file or hash.
        #
        # @param [String|Hash] config_source
        # @return [StarboundSrvMgr::Config]
        def initialize(config_source)
            @config = case config_source
                          when String
                              YAML.load_file config_source
                          when Hash
                              config_source
                      end
        end

        # Get a config value by key
        #
        # @param [String|Symbol] key
        def get(key)
            @config[key.to_s]
        end

    end
end