#
# Cookbook Name:: chef-crowd
# Recipe:: configuration
#
# Copyright (C) 2014 Sergio Leone
#
# All rights reserved - Do Not Redistribute
#
template "#{node['crowd']['install_path']}/crowd/crowd-webapp/WEB-INF/classes/crowd-init.properties" do
  source 'crowd-init.properties.erb'
  owner node['crowd']['user']
  mode '0644'
  notifies :restart, 'service[crowd]', :delayed
end
