#
# Cookbook Name:: chef-crowd
# Recipe:: database
#
# Copyright (C) 2014 Sergio Leone
#
# All rights reserved - Do Not Redistribute
#
settings = Crowd.settings(node)

database_connection = {
  :host => settings['database']['host'],
  :port => settings['database']['port']
}

case settings['database']['type']
when 'mysql', 'percona'
  include_recipe "#{settings['database']['type']}::server"
  include_recipe 'database::mysql'

  root_password = settings['database']['type'] == 'mysql' ? node['mysql']['server_root_password'] : EncryptedPasswords.new(node, node["percona"]["encrypted_data_bag"]).root_password

  database_connection.merge!(:username => 'root', :password => root_password)

  mysql_database settings['database']['name'] do
    connection database_connection
    collation 'utf8_bin'
    encoding 'utf8'
    action :create
  end

  # See this MySQL bug: http://bugs.mysql.com/bug.php?id=31061
  mysql_database_user '' do
    connection database_connection
    host 'localhost'
    action :drop
  end

  mysql_database_user settings['database']['user'] do
    connection database_connection
    host '%'
    password settings['database']['password']
    database_name settings['database']['name']
    action [:create, :grant]
  end
when 'postgresql'
  include_recipe 'postgresql::server'
  include_recipe 'database::postgresql'
  database_connection.merge!(:username => 'postgres', :password => node['postgresql']['password']['postgres'])

  postgresql_database settings['database']['name'] do
    connection database_connection
    connection_limit '-1'
    encoding 'utf8'
    action :create
  end

  postgresql_database_user settings['database']['user'] do
    connection database_connection
    password settings['database']['password']
    database_name settings['database']['name']
    action [:create, :grant]
  end
end
