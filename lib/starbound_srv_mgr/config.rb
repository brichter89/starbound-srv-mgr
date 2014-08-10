require 'yaml'
require 'starbound_srv_mgr/exceptions'

module StarboundSrvMgr
    class Config

        # @var [Hash]
        @config = {}

        # Initialize the config object with a configuration file or hash.
        #
        # @param [String|Hash] config_source
        # @return [StarboundSrvMgr::Config]
        def initialize(config_source)
            raw_config = case config_source
                             when String
                                 YAML.load_file config_source
                             when Hash
                                 config_source
                         end

            # Convert all string keys to symbols.
            @config = raw_config.inject({}) do |memo, (key,value)|
                memo[key.to_sym] = value
                memo
            end
        end

        # Get a config value by key.
        #
        # @param [String|Symbol] key
        def get(key)
            key = key.to_sym

            unless @config.has_key? key
                raise StarboundSrvMgr::InvalidConfigKeyError, %q{Config key '%s' not found} % [key]
            end

            @config[key]
        end

    end
end