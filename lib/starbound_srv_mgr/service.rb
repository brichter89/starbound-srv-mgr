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
# Date:   2014-08-12

module StarboundSrvMgr
    class Service

        # Initialize a service object with a configuration object.
        #
        # @param [StarboundSrvMgr::Config] config
        def initialize(config)

        end

        # Start the service and return its PID
        #
        # @return [Integer]
        def start
            # TODO: implement
        end

        # Stop the service.
        #
        # Throws an exception if the service can't be stopped.
        #
        # Passing <em>force: true</em> will kill the server instead of
        # gracefully shutting it down.
        #
        # stop()                # try to stop the service
        # stop(force: true)     # kill the service
        #
        # @param [Boolean] force: <>
        def stop(force: false)
            # TODO: implement
        end

        # Restart the service
        #
        # A restart is effectively a stop followed by a start of a service.
        # If the service was not started before, it simply gets started.
        #
        # Passing <em>force: true</em> will kill the server instead of
        # gracefully shutting it down.
        #
        # @param [Boolean] force: <>
        def restart(force: false)
            stop(force: force)
            start
        end

        # Reloads the configuration of a service
        #
        # In this case (and in most cases) it results in a simple restart of
        # the service, to force it reloading its configuration.
        def force_reload
            restart
        end

        # Retrieve the running status of the service
        #
        # Returns one of the STATUS_* code constants
        #
        # @return [Integer]
        def status
            # TODO: implement
        end

    end
end