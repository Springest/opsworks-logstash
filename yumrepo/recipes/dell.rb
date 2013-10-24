#
# Cookbook Name:: yumrepo
# Recipe:: dell
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

if not node['repo']['dell']['enabled']
  return
end

cookbook_file "#{node['repo']['key_path']}/#{node["repo"]["dell"]["key"]}"

yum_key node['repo']['dell']['key'] do
  action :add
end

yum_repository "dell-community-repository" do
  description "Dell Community Repository"
  mirrorlist node['repo']['dell']['community_url']
  key node['repo']['dell']['key']
  action :add
end

yum_repository "dell-omsa-indep" do
  description "Dell OMSA repository - Hardware independent"
  mirrorlist node['repo']['dell']['omsa_independent_url']
  key node['repo']['dell']['key']
  action :add
end

yum_repository "dell-omsa-specific" do
  description "Dell OMSA repository - Hardware specific"
  mirrorlist node['repo']['dell']['omsa_specific_url']
  key node['repo']['dell']['key']
  action :add
end

yum_repository "fwupdate" do
  description "Firmware updates"
  mirrorlist node['repo']['dell']['firmware_url']
  key node['repo']['dell']['key']
  action :add
end

package "srvadmin-all"

if node['repo']['dell']['download_firmware']
  package "firmware-tools" do
    ignore_failure true
  end

  # This execute block only downloads firmware images
  # You have to run 'update_firmware' --yes to apply
  # any pending firmware udpates.
  script "bootstrap_firmware" do
    interpreter "bash"
    code <<-EOH
      if [ -x /usr/sbin/bootstrap_firmware ]; then
        yum -y install $(bootstrap_firmware)
      fi
    EOH
  end
end

# vim: ai et sts=2 sw=2 ts=2
