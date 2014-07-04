#
# Cookbook Name:: chef-crowd
# Recipe:: linux_standalone
#
# Copyright (C) 2014 Sergio Leone
#
# All rights reserved - Do Not Redistribute
#
settings = Crowd.settings(node)

directory File.dirname(node['crowd']['home_path']) do
  owner 'root'
  group 'root'
  mode 00755
  action :create
  recursive true
end

user node['crowd']['user'] do
  comment 'Crowd Service Account'
  home node['crowd']['home_path']
  shell '/bin/bash'
  supports :manage_home => true
  system true
  action :create
end

execute 'Generating Self-Signed Java Keystore' do
  command <<-COMMAND
    #{node['java']['java_home']}/bin/keytool -genkey \
      -alias #{settings['tomcat']['keyAlias']} \
      -keyalg RSA \
      -dname 'CN=#{node['fqdn']}, OU=Example, O=Example, L=Example, ST=Example, C=US' \
      -keypass #{settings['tomcat']['keystorePass']} \
      -storepass #{settings['tomcat']['keystorePass']} \
      -keystore #{settings['tomcat']['keystoreFile']}
    chown #{node['crowd']['user']}:#{node['crowd']['user']} #{settings['tomcat']['keystoreFile']}
  COMMAND
  creates settings['tomcat']['keystoreFile']
  only_if { settings['tomcat']['keystoreFile'] == "#{node['crowd']['home_path']}/.keystore" }
end

directory node['crowd']['install_path'] do
  owner 'root'
  group 'root'
  mode 00755
  action :create
  recursive true
end

ark 'crowd' do
  url node['crowd']['url']
  prefix_root node['crowd']['install_path']
  prefix_home node['crowd']['install_path']
  checksum node['crowd']['checksum']
  version node['crowd']['version']
  owner node['crowd']['user']
  group node['crowd']['user']
end

if settings['database']['type'] == 'mysql' || settings['database']['type'] == 'percona'
  ark 'mysql-connector-java' do
    url "http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-#{node['crowd']['mysql_connector']['version']}.tar.gz"
    creates "mysql-connector-java-#{node['crowd']['mysql_connector']['version']}/mysql-connector-java-#{node['crowd']['mysql_connector']['version']}-bin.jar"
    path "#{node['crowd']['install_path']}/crowd/apache-tomcat/lib"
    checksum node['crowd']['mysql_connector']['checksum']
    owner node['crowd']['user']
    group node['crowd']['user']
    action :cherry_pick
  end
end
