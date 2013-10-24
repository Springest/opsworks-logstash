#
# Cookbook Name:: yumrepo
# Recipe:: corporate 
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

unless node['repo']['corp']['key'].nil?
  yum_key node['repo']['corp']['key'] do
    url node['repo']['corp']['key_url'] 
    action :add
  end

  yum_repository node['repo']['corp']['name'] do
    description "#{node['repo']['corp']['name']} Yum Repo"
    key node['repo']['corp']['key']
    url node['repo']['corp']['url']
    action :add
  end
else
  yum_repository node['repo']['corp']['name'] do
    description "#{node['repo']['corp']['name']} Yum Repo"
    url node['repo']['corp']['url']
    action :add
  end
end
