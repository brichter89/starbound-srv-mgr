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

require 'starbound_srv_mgr/service'

describe StarboundSrvMgr::Service do
    SERVICE_CONFIG_FILE = __dir__ + '/files/service_spec.yaml'

    # @var [StarboundSrvMgr::Service]
    @service

    before :each do |example|
        unless example.metadata[:skip_before]
            config = StarboundSrvMgr::Config.new(SERVICE_CONFIG_FILE)
            @service = StarboundSrvMgr::Service.new(config)
        end
    end

    it 'should accept a config object', :skip_before do
        config = StarboundSrvMgr::Config.new({})
        StarboundSrvMgr::Service.new(config)
    end

    it 'should provide the LSB required actions for init scripts', :skip_before do
        # LSB required actions for init scripts are:
        # start, stop, restart, force-reload, status
        expect(StarboundSrvMgr::Service.method_defined? :start).to be true
        expect(StarboundSrvMgr::Service.method_defined? :stop).to be true
        expect(StarboundSrvMgr::Service.method_defined? :restart).to be true
        expect(StarboundSrvMgr::Service.method_defined? :force_reload).to be true
        expect(StarboundSrvMgr::Service.method_defined? :status).to be true
    end
end