## yumrepo

### v0.16.6

* add zeromq repo
  - contributed by @BryanWB
* Bump chef gem in Gemfile
  - Locked chef gem at 10.X, 'cause minitest spec seems to be broke
    on chef 11.x.
  
TODO - Replace tests with chefspec

### v0.16.5

Fix mirrorlist attribute in Dell recipe.

### v0.16.4

Thanks to Paul Graydon (@twirrim) for adding Percona MySQL repositories.

Thanks to Bryan Berry (@bryanwb) for adding yet another PostgreSQL
repository. :)

#### Breaking changes (postgresql)

* Recipe renamed, postgresql9 -> postgresql.
* Added node['repo']['postgresql']['version'] to select version of
  Postgres via attribute, from pgrpms.org repository.

### v0.16.3

Set name/base_url to localdomain in the case Ohai `domain` is
unavailable.  Fixes chef-solo compilation error on Vagrant boxes.

### v0.16.2

    Change corporate recipe to key off domain name.

### v0.16.0

    Add VMWare Tools for ESX v5.0u1, along with a vmware-tools-upgrade
recipe.  The yumrepo::vmware-tools recipe is backwards incompatible.
Unfortunately there is no way to upgrade vmware-tools rpm files without
yanking them out, and replacing them.

    One must ensure the `vmware-tools-upgrade` recipe will run **before**
the `vmware-tools` recipe.  Otherwise the 4.1 recipe will directly
conflict with the 5.0u1 version of the recipe.

    I also added some attribute sanity tests for this new version, enjoy!
