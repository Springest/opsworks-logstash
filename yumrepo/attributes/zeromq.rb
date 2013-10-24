major_version = node['platform_version'].to_i
default['repo']['zeromq']['url'] = "http://download.opensuse.org/repositories/home:/fengshuo:/zeromq/CentOS_CentOS-#{major_version}/"
default['repo']['zeromq']['key_url'] = "http://download.opensuse.org/repositories/home:/fengshuo:/zeromq/CentOS_CentOS-#{major_version}/repodata/repomd.xml.key"
