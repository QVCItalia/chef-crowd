#
# Cookbook Name:: chef-crowd
# Recipe:: default
#
# Copyright (C) 2014 Sergio Leone
#
# All rights reserved - Do Not Redistribute
#
platform = 'windows' if node['platform_family'] == 'windows'
platform ||= 'linux'
settings = Crowd.settings(node)

include_recipe 'crowd::database' if settings['database']['host'] == 'localhost'
include_recipe "crowd::#{platform}_#{node['crowd']['install_type']}"
include_recipe 'crowd::tomcat_configuration'
include_recipe 'crowd::apache2'
include_recipe 'crowd::configuration'
include_recipe "crowd::service_#{node['crowd']['service_type']}"
