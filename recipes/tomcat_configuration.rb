#
# Cookbook Name:: chef-crowd
# Recipe:: tomcat_configuration
#
# Copyright (C) 2014 Sergio Leone
#
# All rights reserved - Do Not Redistribute
#
settings = Crowd.settings(node)
crowd_version = Chef::Version.new(node['crowd']['version'])

template "#{node['crowd']['install_path']}/crowd/apache-tomcat/bin/setenv.sh" do
  source 'setenv.sh.erb'
  owner node['crowd']['user']
  group node['crowd']['user']
  mode '0755'
  notifies :restart, 'service[crowd]', :delayed
end

template "#{node['crowd']['install_path']}/crowd/apache-tomcat/conf/server.xml" do
  source 'server.xml.erb'
  owner node['crowd']['user']
  group node['crowd']['user']
  mode '0640'
  variables :tomcat => settings['tomcat']
  notifies :restart, 'service[crowd]', :delayed
end
