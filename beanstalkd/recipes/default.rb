#
# Cookbook Name:: beanstalkd
# Recipe:: default
#
# Copyright 2012, Escape Studios
#

package "beanstalkd" do
	action :upgrade
end

template "/etc/default/beanstalkd" do
	source "beanstalkd.erb"
	owner "root"
	group "root"
	mode 0640
	variables(
		:daemon_opts => node['beanstalkd']['daemon_opts'],
		:start_during_boot => node['beanstalkd']['start_during_boot']
	)
	notifies :restart, "service[beanstalkd]"
end

service "beanstalkd" do
	start_command "/etc/init.d/beanstalkd start"
	stop_command "/etc/init.d/beanstalkd stop"
	status_command "/etc/init.d/beanstalkd status"
	supports [:start, :stop, :status]
    #starts the service if it's not running and enables it to start at system boot time
	action [:enable, :start]
end