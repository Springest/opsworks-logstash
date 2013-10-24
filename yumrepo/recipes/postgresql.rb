#
# Cookbook Name:: yumrepo
# Recipe:: postgresql9
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

# Flatten the version float (9.0 => 90) for repo filename.
version_flat = (node['repo']['postgresql']['version'] * 10).to_i

cookbook_file "#{node['repo']['key_path']}/#{node['repo']['postgresql']['key']}"

yum_key node['repo']['postgresql']['key'] do
  action :add
end

yum_repository "postgresql#{version_flat}" do
  description "PostgreSQL #{node['repo']['postgresql']['version']}"
  key node['repo']['postgresql']['key'] 
  url node['repo']['postgresql']['url'] 
  action :add
end
