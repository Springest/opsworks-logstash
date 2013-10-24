#
# Cookbook Name:: yumrepo
# Recipe:: vmware-tools-upgrade
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

packages = [
  "vmware-tools-nox",
  "vmware-tools-common",
  "vmware-open-vm-tools-common",
  "vmware-open-vm-tools-nox",
  "vmware-open-vm-tools-kmod",
  "vmware-open-vm-tools-xorg-drv-display",
  "vmware-open-vm-tools-xorg-drv-mouse"
]

# Stop vmware-tools service
service "vmware-tools" do
  supports :status => true, :restart => true
  action [ :disable, :stop ]
end

# Remove optional packages
packages.each do |pkg|
  package pkg do
    action :remove
    ignore_failure true
  end
end

# Execute yum clean all
execute "yum -y clean all" do
  action :nothing
end

# Remove yum repository file
ruby_block "unlink vmware-tools 4.x repo file" do
  block do
    File.unlink("/etc/yum.repos.d/vmware-tools.repo")
  end
  only_if { File.exists?("/etc/yum.repos.d/vmware-tools.repo") }
  notifies :run, "execute[yum -y clean all]", :immediately
end

ruby_block "Removing vwmare-tools-upgrade recipe" do
  block do
    node.run_list.remove("recipe[yumrepo::vmware-tools-upgrade]")
  end
end

include_recipe "yumrepo::vmware-tools"
