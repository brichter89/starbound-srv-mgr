# -*- coding: utf-8 -*-
#
# {DESCRIPTION}
#
# Copyright (c) 2014 Björn Richter <x3ro1989@gmail.com>
#
# {LICENSE_INFORMATION}
#
#
# Author: Björn R. <x3ro1989@gmail.com>
# Date:   2014-08-11

require 'rspec'
require 'starbound_srv_mgr/core_ext/array/has_key'

describe Array do

    # @var [Array]
    @array

    before :each do |example|
        unless example.metadata[:skip_before]
            @array = Array.new(['a', 'b', nil])
        end
    end

    it 'should return true if the key exists' do
        expect(@array.has_key? 0).to be true
        expect(@array.has_key? 2).to be true
    end

    it 'should return false if the key doesn\'t exists' do
        expect(@array.has_key? 3).to be false
    end

    it 'should accept everything that is castable as int' do
        someObject = Object.new
        someObject.define_singleton_method(:to_i) do
            return 1
        end

        expect(@array.has_key? '1').to be true
        expect(@array.has_key? :'1').to be true
        expect(@array.has_key? someObject).to be true

    end
end