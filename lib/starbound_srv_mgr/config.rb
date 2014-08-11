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
        # @param [String|Symbol] key
        # @param [Mixed]         default_value
        #
        # @return [Mixed]
        def get(key, default_value = nil)
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
                return default_value unless default_value.nil?
                raise StarboundSrvMgr::InvalidConfigKeyError, %q{Config key '%s' not found} % [key]
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