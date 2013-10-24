Travis-ci status: [![Build Status](https://secure.travis-ci.org/jackl0phty/opschef-cookbook-rackspaceknife.png?branch=master)](http://travis-ci.org/jackl0phty/opschef-cookbook-rackspaceknife)

DESCRIPTION:
==============

* __rackspacepknife.pl__ is a Perl command-line utility which can interact with the
[Rackspace](http://www.rackspace.com/) API. It relies heavily upon the [CPAN](http://www.cpan.org/) modules
[WebService::Rackspace::CloudFiles](http://search.cpan.org/~ckras/WebService-Rackspace-CloudFiles-1.02/lib/WebService/Rackspace/CloudFiles.pm)
and [Net::Rackspace::CloudServers](http://search.cpan.org/~mfontani/Net-RackSpace-CloudServers-0.14/).

* In particular, __rackspacepknife.pl__ uses WebService::Rackspace::CloudFiles to
interact with the API of Rackspace's cloud storage service CloudFiles (TM).

* Documentation for Rackspace's Cloudfiles(TM) API can be found at
[rackspace](http://www.rackspace.com/cloud/cloud_hosting_products/files/api/).

* Documentation for Rackspace's CloudServers(TM) API can be found at
[rackspace](http://www.rackspace.com/cloud/cloud_hosting_products/servers/api/).
__NOTE: This is currently on the TO-DO-LIST__.

REQUIREMENTS:
===============

- The following CPAN modules and packages must be installed in order to use
__rackspacepknife.pl__:

<pre><code>
use Getopt::Declare;
use Carp;
use version;
use IPC::Run qw ( run timeout );
use WebService::Rackspace::CloudFiles;
</code></pre>

- The cookbook is also dependent (e.g. will "knife cookbook site install") upon
the following cookbooks/recipes:

<pre><code>
include_recipe "perl"
include_recipe "yumrepo::epel"
</code></pre>

SUPPORTED OPERATING SYSTEMS:
============================

The rackspaceknife cookbook currently supports the following Linux Distributions.
This includes installing CPAN modules and package prerequisites.

+ CentOS
+ Redhat
+ Scientific
+ Debian
+ Ubuntu

NOTE ABOUT REQUIREMENTS:
==========================

The cookbook will install the packaged version of the module if available.
Other wise, the module is installed via	CPAN using the cpan_module resource
from the [Perl cookbook](http://community.opscode.com/cookbooks/perl) maintained by [Opscode](http://www.opscode.com/).

ATTRIBUTES:
=============

- There are currently no attributes for this cookbook.

USAGE:
========

+ Get the rackspaceknife.pl help menu.
<pre><code>
cd /usr/local/bin
./rackspaceknife.pl --help
</code></pre>

+ List all containers for Rackspace Cloud Files.
<pre><code>
./rackspaceknife.pl --list --user RACKSPACE_USERNAME_HERE --key RACKSPACE_API_KEY_HERE
</code></pre>

+ Create a new container.
<pre><code>
./rackspaceknife.pl --ncontainer NEW_CONTAINER_HERE --user RACKSPACE_USERNAME_HERE --key RACKSPACE_API_KEY_HERE
</pre></code>

+ Get total bytes used for Rackspace Cloud Files.
<pre><code>
./rackspaceknife.pl --tbytes --user RACKSPACE_USERNAME_HERE --key RACKSPACE_API_KEY_HERE
</code></pre>

+ Get object count of given container (e.g. # of files in a container).
<pre><code>
./rackspaceknife.pl --objcount CONTAINER_NAME_HERE --user RACKSPACE_USERNAME_HERE --key RACKSPACE_API_KEY_HERE
</code></pre>

TO-DO-LIST:
=============

- Implement "bytes used per container" for Rackspace CloudFiles(TM).
- Implement "create new object" for Rackspace CloudFiles(TM).
- Implement "set metadata of object" for Rackspace CloudFiles(TM).
- Implement "create object from local file" for Rackspace CloudFiles(TM).
- Implement "fetch an object" for Rackspace CloudFiles(TM).
- Implement "fetch metadata of an object" for Rackspace CloudFiles(TM).
- Implement "download object to local file" for Rackspace CloudFiles(TM).
- Implement "delete object" for RackSpace CloudFiles(TM).
- Implement all methods provided by [Net::RackSpace::CloudServers](http://search.cpan.org/~mfontani/Net-RackSpace-CloudServers-0.14/lib/Net/RackSpace/CloudServers.pm).
- Implement ability to specify username and api key via ENVIRONMENT variables.
- Powered by ![Alt test](https://github.com/jackl0phty/rackspaceknife/raw/master/logos/Opscode_logo_final.png) and ![Alt test](https://github.com/jackl0phty/rackspaceknife/raw/master/logos/cpan-logo.jpg)
