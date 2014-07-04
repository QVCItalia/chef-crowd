#
# Cookbook Name:: chef-crowd
# Recipe:: service_init
#
# Copyright (C) 2014 Sergio Leone
#
# All rights reserved - Do Not Redistribute
#
template '/etc/init.d/crowd' do
  source 'crowd.init.erb'
  mode '0755'
  notifies :restart, 'service[crowd]', :delayed
end

service 'crowd' do
  supports :status => true, :restart => true
  action [:enable]
  subscribes :restart, 'java_ark[jdk]'
end
