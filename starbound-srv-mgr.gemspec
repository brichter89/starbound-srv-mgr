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

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'starbound_srv_mgr/version'

Gem::Specification.new do |spec|
    spec.name          = 'starbound-srv-mgr'
    spec.version       = StarboundSrvMgr::VERSION
    spec.authors       = ['Björn Richter']
    spec.email         = ['x3ro1989@gmail.com']
    spec.summary       = %q{Starbound Server Manager}
    spec.description   = %q{An init script and a cli for managing a starbound server, using a ramdisk for the "world" } +
                         %q{files while doing regular backups of the "world"}
    spec.homepage      = 'https://github.com/brichter89/starbound-srv-mgr'
    spec.license       = 'GPL'

    spec.files         = `git ls-files -z`.split("\x0")
    spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
    spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
    spec.require_paths = ['lib']

    spec.add_dependency 'activesupport', '~> 4.1'

    spec.add_development_dependency 'bundler', '~> 1.6'
    spec.add_development_dependency 'rake', '~> 10.0'
    spec.add_development_dependency 'rspec', '~> 3.0'
end
