require 'yaml'

module StarboundSrvMgr
    class Config

        # @var Hash
        @config

        # Initialize the config object with a configuration file or hash.
        #
        # @param [String|Hash] config_file
        # @return [StarboundSrvMgr::Config]
        def initialize(config_file)
            @config = case config_file
                          when String
                              YAML.load_file config_file
                          when Hash
                              config_file
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