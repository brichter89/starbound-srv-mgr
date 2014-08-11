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
# Date:   2014-08-11

class Array

    # array.has_key?(key)    -> true or false
    #
    # Returns <code>true</code> if the given key is present in <i>array</i>.
    #
    #    a = ["a", "b", nil]
    #    a.has_key?(0)   #=> true
    #    a.has_key?(2)   #=> true
    #    a.has_key?(3)   #=> false
    #
    # @param [Mixed] key
    #
    # @return [Bool]
    def has_key?(key)
        key = key.to_s if key.is_a? Symbol
        key = key.to_i unless key.is_a? Integer

        key < self.length
    end

end
