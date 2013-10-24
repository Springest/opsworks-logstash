#
# Cookbook Name:: yumrepo
# Attributes:: corporate 
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


# Take the first part of the OHAI doman attribute as repo name (example from example.com)
# if it is not nil
default['repo']['corp']['name'] = node['domain'] ?  node['domain'].split('.')[0] : "localdomain"

default['repo']['corp']['base_url'] = "http://yum.#{node['domain']}/yum"

# Set the corp url to yum.example.com/yum/rhel/5/{i386,x86_64}
default['repo']['corp']['url'] = "#{node['repo']['corp']['base_url']}/#{node['platform_family']}/#{node['platform_version'].to_i}/$basearch"

default['repo']['corp']['key'] = nil

# Set the key url to yum.example.com/yum/<key file>
default['repo']['corp']['key_url'] = "#{node['repo']['corp']['base_url']}/#{node['repo']['corp']['key']}"
