#
# Cookbook Name:: yumrepo
# Attributes:: vmware 
#
# Copyright 2010, Eric G. Wolfe 
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

# Attributes for VMware 5.x recipe
default['repo']['vmware']['key'] = "VMWARE-PACKAGING-GPG-RSA-KEY"
default['repo']['vmware']['release'] = "5.0u1"
default['repo']['vmware']['install_optional'] = false
default['repo']['vmware']['services'] = %w{ vmci vmware-tools-services }

if node['dmi'] and node['dmi']['system'] and node['dmi']['system']['manufacturer'] and node['dmi']['system']['manufacturer'] =~ /vmware/i and node['platform_version'].to_f >= 5
  set['repo']['vmware']['enabled'] = true
else
  set['repo']['vmware']['enabled'] = false
end

default['repo']['vmware']['url'] = "http://packages.vmware.com/tools/esx/#{node['repo']['vmware']['release']}/rhel#{node['platform_version'].to_i}/$basearch"
default['repo']['vmware']['key_url'] = "http://packages.vmware.com/tools/keys/#{node['repo']['vmware']['key']}.pub"

default['repo']['vmware']['required_packages'] = [
  "vmware-tools-esx-nox",
  "vmware-tools-esx-kmods"
]
default['repo']['vmware']['optional_packages'] = Array.new
