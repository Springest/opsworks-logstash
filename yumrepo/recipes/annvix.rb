#
# Cookbook Name:: yumrepo
# Recipe:: annvix
#
# Copyright 2010, Tippr Inc.
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

cookbook_file "#{node['repo']['key_path']}/#{node['repo']['annvix']['key']}"

yum_key node['repo']['annvix']['key'] do
  action :add
end

yum_repository "annvix" do
  description "CentOS/RHEL-EL#{node['platform_version'].split('.')[0]} - Annvix"
  key node['repo']['annvix']['key']
  url node['repo']['annvix']['url'] 
  action :add
end
