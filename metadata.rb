name             'crowd'
maintainer       'Sergio Leone'
maintainer_email 'sergio.leone@qvc.com'
license          'Apache 2.0'
description      'Installs/Configures Atlassian Crowd'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.1'
recipe 'crowd', 'Installs/Configures Atlassian Crowd'
recipe 'crowd::apache2', 'Installs/Configures Apache 2 proxy for Crowd'
recipe 'crowd::configuration', "Configures Crowd's settings"
recipe 'crowd::database', 'Installs/configures MySQL/Postgres server, database, and user for Crowd'
recipe 'crowd::linux_standalone', 'Installs/configures Crowd via Linux standalone archive'
recipe 'crowd::service_init', 'Installs/configures Crowd init service'
recipe 'crowd::tomcat_configuration', "Configures Crowd's built-in Tomcat"

%w(amazon centos redhat scientific ubuntu).each do |os|
  supports os
end

%w(apache2 ark database java mysql percona postgresql).each do |cb|
  depends cb
end
