# -*- coding: utf-8 -*-
#
# starbound-srv-mgr - A Starbound server manager with LSB init.d support.
#
# Copyright (c) 2014 Björn Richter <x3ro1989@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#
# Author: Björn R. <x3ro1989@gmail.com>
# Date:   2014-08-09

require 'yaml'
require 'active_support/core_ext/hash'
require 'starbound_srv_mgr/exceptions'
require 'starbound_srv_mgr/core_ext/array'

module StarboundSrvMgr
    class Config

        # @var [Hash]
        @config = {}

        # Initialize the config object with a configuration file or hash.
        #
        # @param [String|Hash] config_source
        #
        # @return [StarboundSrvMgr::Config]
        def initialize(config_source)
            case config_source
                when String
                    unless File.exists? config_source
                        raise StarboundSrvMgr::InvalidConfigSourceError, %q{Config file '%s' could not be found} % [config_source]
                    end

                    raw_config = YAML.load_file config_source
                when Hash
                    raw_config = config_source
                else
                    raise StarboundSrvMgr::InvalidConfigSourceError, %q{Unexpected config source: %s} % [config_source.to_s]
            end

            @config = raw_config.deep_symbolize_keys
        end

        # Get a config value by key.
        #
        # The key could be a symbol as well as a string. To get the whole configuration as a Hash, pass '::' as key.
        # To get nested values, use a namespaced key: 'key_1::key_in_key_1'. (A '::' could be prepended to indicate
        # the root object: '::key_1::key_in_key_1'.)
        #
        # If the key could not be found in the config object, an exception is thrown unless a default value is set.
        #
        # Examples:
        #
        #     config = StarboundSrvMgr::Config.new({
        #         bazinga: 'BAZINGA',
        #     })
        #
        #     config.get :bazinga                               #=> "BAZINGA"
        #     config.get :i_do_not_exist, default: 'HELLO :-)'  #=> "HELLO :-)"
        #     config.get '::'                                   #=> [Hash] of the configuration with all string keys converted to Symbols
        #
        # @param [String|Symbol] key                the searched config key
        # @param [Mixed]         deprecated_default (deprecated) a default value if the key is not found
        # @param [Mixed]         default:           a default value if the key is not found
        #
        # @return [Mixed] The requested config value
        #
        # @raise [ArgumentError] if more than two unnamed parameters are passed
        # @raise [StarboundSrvMgr::InvalidConfigKeyError] if the config key wasn't found and no default value was provided
        def get(key, *deprecated_default, default: nil)
            if deprecated_default.length > 1
                raise ArgumentError, 'wrong number of arguments (%s for 2)' % [deprecated_default.length+1]
            end

            default = default || deprecated_default[0]
            key = key.to_s

            return @config.clone if key == '::'

            key.gsub! /^::/, ''
            path = key.split '::'

            result = @config.clone

            begin
                path.each do |k|
                    result = find_in(result, k)
                end
            rescue StarboundSrvMgr::InvalidConfigKeyError => e
                if default.nil?
                    raise StarboundSrvMgr::InvalidConfigKeyError, %q{Config key '%s' not found} % [key]
                end

                result = default
            end

            result
        end

        # Alias for #get('::')
        #
        # @return [Mixed]
        def get_all
            get('::')
        end

        protected ######################################################################################################

        def find_in(thing, key)
            case thing
                when Hash
                    [key.to_sym, key.to_i, key.to_f].each do |k|
                        return thing[k] if thing.has_key? k
                    end
                when Array
                    k = key.to_i
                    return thing[k] if thing.has_key? k
                else
                    throw :nothing_found, true
            end

            raise StarboundSrvMgr::InvalidConfigKeyError, %q{Key '%{key}' not found in %{thing}} % [:key => key, :thing => thing]
        end

    end
end