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
# Date:   2014-08-06

require 'bundler/gem_tasks'
require 'starbound_srv_mgr/version'

version = StarboundSrvMgr::VERSION

if ARGV.include?('release') && version =~ /dev|pre|-/i
    $stderr.puts 'rake aborted!'
    $stderr.puts %q{Version string may not contain 'dev', 'pre' or '-' when releasing!}
    $stderr.puts "Provided version: #{version}"
    abort
end
