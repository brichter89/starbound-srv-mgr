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
        # Examples:
        #
        #     config_1 = StarboundSrvMgr::Config.new('/path/to/config.yaml')
        #
        #     config_2 = StarboundSrvMgr::Config.new({
        #         bazinga: 'BAZINGA',
        #         Asimovs_Laws: {
        #             1 => 'A %{subject} may not injure a %{object} or, through inaction, allow a %{object} to come to harm.',
        #             2 => 'A %s must obey the orders given to it by %s, except where such orders would conflict with the First Law.',
        #             3 => 'A %3$s must protect its own existence as long as such protection does not conflict with the %1$s or %2$s Law.',
        #         }
        #     })
        #
        # @param [String|Hash] config_source
        #
        # @raise [StarboundSrvMgr::InvalidConfigSourceError] if the config file could not be found or it's not a [Hash]
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
        # This will return a clone of the actual config Hash to prevent manipulation.
        #
        # To get nested values, use a namespaced key: 'key_1::key_in_key_1'. (A '::' could be prepended to indicate
        # the root object: '::key_1::key_in_key_1'.)
        #
        # If the key could not be found in the config Hash, it raises an error unless a default value is set.
        #
        # Strings could be formatted according to the **#fprints()** method.
        #
        # See also: [#ftrints()](http://www.ruby-doc.org/core-2.1.2/Kernel.html#method-i-sprintf)
        #
        # Examples:
        #
        #     config = StarboundSrvMgr::Config.new({
        #         bazinga: 'BAZINGA',
        #         Asimovs_Laws: {
        #             1 => 'A %{subject} may not injure a %{object} or, through inaction, allow a %{object} to come to harm.',
        #             2 => 'A %s must obey the orders given to it by %s, except where such orders would conflict with the First Law.',
        #             3 => 'A %3$s must protect its own existence as long as such protection does not conflict with the %1$s or %2$s Law.',
        #         }
        #     })
        #
        #     config.get :bazinga                               #=> "BAZINGA"
        #     config.get :i_do_not_exist, default: 'HELLO :-)'  #=> "HELLO :-)"
        #     config.get '::'                                   #=> [Hash] of the configuration with all string keys converted to Symbols
        #     config.get 'Asimovs_Laws'                         #=> [Hash] of 'Asimovs_Laws'
        #
        #     # Replacements
        #     config.get '::Asimovs_Laws::1', replace: {:subject => 'robot', :object => 'human being'}
        #                                                       #=> "A robot may not injure a human being or, through inaction, allow a human being to come to harm."
        #     config.get '::Asimovs_Laws::2', replace: ['robot', 'human beings']
        #                                                       #=> "A robot must obey the orders given to it by human beings, except where such orders would conflict with the First Law."
        #     config.get '::Asimovs_Laws::3', replace: %w(First Second robot)
        #                                                       #=> "A robot must protect its own existence as long as such protection does not conflict with the First or Second Law."
        #     config.get :answer,
        #                default: 'The Answer to the Ultimate Question of Life, the Universe, and Everything is %{answer}',
        #                replace: {:answer => 42}               #=> "The Answer to the Ultimate Question of Life, the Universe, and Everything is 42"
        #
        # @param [String|Symbol] key                the searched config key
        # @param [Mixed]         deprecated_default (deprecated) a default value if the key is not found
        # @param [Mixed]         default:           a default value if the key is not found
        # @param [Array|Hash]    replace:           the values that should be replaced in the string
        #
        # @return [Mixed] The requested config value
        #
        # @raise [ArgumentError] if more than two unnamed parameters are passed
        # @raise [StarboundSrvMgr::InvalidConfigKeyError] if the config key wasn't found and no default value was provided
        def get(key, *deprecated_default, default: nil, replace: nil)
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

            if replace && result.is_a?(String)
                result = result % replace
            end

            result
        end

        # Alias for {StarboundSrvMgr::Config#get #get('::')}
        #
        # @return [Hash] The whole config hash
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