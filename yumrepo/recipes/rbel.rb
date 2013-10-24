#
# Cookbook Name:: yumrepo
# Recipe:: rbel 
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

cookbook_file "#{node['repo']['key_path']}/#{node['repo']['rbel']['key']}"

yum_key node['repo']['rbel']['key'] do
  action :add
end

yum_repository "rbel#{node['platform_version'].to_i}" do
  description "RBEL #{node['platform_version'].to_i} repo"
  key node['repo']['rbel']['key'] 
  url node['repo']['rbel']['url'] 
  action :add
end
