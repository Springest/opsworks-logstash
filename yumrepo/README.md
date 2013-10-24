# Yumrepo [![Build Status](https://secure.travis-ci.org/atomic-penguin/cookbook-yumrepo.png?branch=master)](http://travis-ci.org/atomic-penguin/cookbook-yumrepo)

## Description

Manages Yum Repository files in /etc/yum.repos.d on CentOS / RHEL 5.x.

Yum repositories included in this recipe:
EPEL, ELFF, Dell OMSA, Dell Community, Dell Firmware, VMware Tools, and more...

## Requirements

This cookbook requires RHEL or CentOS 5.x, and newer.
It has not been tested on other platforms.  It probably will
not work with RHEL 4 or CentOS 4, especially if you have not
taken action to manually install yum on that platform.

## Notes
-----

RHEL 6 support is fairly well tested in the dell, vmware-tools, and
epel recipes.  Let me know if you find a platform 6 bug, related to
any one of the recipes.

The yumrepo::dell recipe requires Dell manufactured hardware.  This
recipe should automatically disable itself if non-Dell hardware is
detected by Ohai

A **major breaking change in this cookbook is the introduction of an
upgrade recipe** for vmware-tools.  Since VMWare does not support
upgrades on their packaged vmware-tools, I created a
vmware-tools-upgrade recipe to migrate from vmware-tools 4.1 to 5.0u1.  
You should ensure the yumrepo recipes are not in a base role, until
all your nodes have been migrated to 5.0u1.  Due to this incompatibility,
vmware-tools has been removed from the default recipe.

## Individual Recipe Usage:

### yumrepo::default

Includes recipes:

* yum::yum
* epel
* dell

### yumrepo::epel

- Provides RPM keys and repo file for
   Fedora EPEL (Extra Packages for Enterprise Linux)
  * See http://fedoraproject.org/wiki/EPEL for more info

### yumrepo::dell

- Provides repo files for the following Dell repositories.
  - hardware / Open Manage Server Administrator
  - community / formerly the software repository
  - firmware / Convenient but unsupported by Dell
  * See http://linux.dell.com for more info

- repo['dell]['download_firmware'] = true||false
  * disables/enables community/firmware repositories in dell recipe
  * OMSA (hardware) repository will detect Dell hardware platform and
    enable itself, dynamically. It is not affected by this attribute.

### yumrepo::rbel

- Provides repo files for rbel.frameos.org
  * Ruby and Opscode Chef packages for RHEL distros 

### yumrepo::vmware-tools-upgrade

- Removes vmware-tools for ESX 4.1 installed with this cookbook.
  Then includes the yumrepo::vmware-tools recipe to re-install
  VMWare Tools compatiblie with ESX 5.0u1.  *This must be in
  your run list before the yumrepo::vmware-tools recipe* to
  successfully upgrade the tools with the recipe.

### yumrepo::vmware-tools

- Uninstalls VMwareTools rpm installed from the
   VMware "Install/Upgrade VMware Tools" menu
- Uninstalls manually installed vmware-tools
   packages, the recipe needs to first run
   vmware-uninstall-tools.pl to use the RPM packages
   from the repo.
- Provides RPM keys and repo file for
   VMware Tools for ESX
  * See http://packages.vmware.com for more info

- repo['vmware']['release'] (ESX version number, default 5.0u1)
  * This is used to determine the correct URL in the
    VMware RHEL5/CentOS repository.

### yumrepo::annvix

- Annvix repository for packages usable with Red Hat Enterprise Linux
  and CentOS.
  * See http://annvix.org for more information.

### yumrepo::postgresql

- PostgreSQL RPMs
  * See http://pgrpms.org for more information.

- repo['postgresql']['version']
  * Select version of Postgres to install via attribute.

### yumrepo::zenoss

- ZenOss Network Monitoring System
  * See http://zenoss.org for more information

### yumrepo::zeromq

- [ZeroMQ](http://www.zeromq.org/distro:centos)
  * This repository hosts the latest stable builds for zeromq

### yumrepo::corporate

- Generic example recipe to be used with an internal Yum mirror, or
  repository.
  * By default this recipe uses the basename of your domain as the
    repository name.

### yumrepo::jenkins

- Jenkins CI yum repository

## License and Author

Author:: Eric G. Wolfe
Copyright:: 2010-2011

Author:: Tippr, Inc.
Copyright:: 2010

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
