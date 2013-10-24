#
# Cookbook Name:: rackspaceknife
# Recipe:: default
#
# Copyright 2011, Gerald L. Hevener, Jr, M.S., Marshall University
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
include_recipe "perl"

case node['platform_family']
  when "redhat"
    %w{perl-IPC-Run perl-version}.each do |perlpkg|
      package perlpkg
    end
      cpan_module "Getopt::Declare" 
      cpan_module "WebService::Rackspace::CloudFiles"
  when "debian"
    %w{libgetopt-declare-perl libipc-run-perl libdatetime-perl}.each do |perlpkg|
      package perlpkg
      cpan_module "WebService::Rackspace::CloudFiles"
    end
end

cookbook_file "/usr/local/bin/rackspaceknife.pl" do
  mode "0755"
  owner "root"
  group "root"
end
