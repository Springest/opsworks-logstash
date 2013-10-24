#
# Cookbook Name:: yumrepo
# Attributes:: zenoss 
#
# Copyright 2011, Eric G. Wolfe 
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['repo']['zenoss']['url'] = "http://dev.zenoss.com/yum/stable/"
default['repo']['zenoss']['key'] = "RPM-GPG-KEY-zenoss"
default['repo']['zenoss']['key_url'] = "http://dev.zenoss.com/yum/#{node['repo']['zenoss']['key']}"
