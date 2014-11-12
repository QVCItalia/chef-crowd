default['crowd']['home_path']    = '/var/atlassian/application-data/crowd'
default['crowd']['install_path'] = '/opt/atlassian'
default['crowd']['install_type'] = 'standalone'
default['crowd']['service_type'] = 'init'
default['crowd']['url_base']     = 'http://www.atlassian.com/software/crowd/downloads/binary/atlassian-crowd'
default['crowd']['user']         = 'crowd'
default['crowd']['version']      = '2.8.0'

default['crowd']['url']      = "#{node['crowd']['url_base']}-#{node['crowd']['version']}.tar.gz"
default['crowd']['checksum'] =
case node['crowd']['version']
when '2.7.2' then '49361f2c7cbd8035c2fc64dfff098eb5e51d754b5645425770da14fc577f1048'
when '2.8.0' then 'c857eb16f65ed99ab8b289fe671e3cea89140d42f85639304caa91a3ba9ade05'
end

default['crowd']['apache2']['webapp_enable']      = true
default['crowd']['apache2']['access_log']         = ''
default['crowd']['apache2']['error_log']          = ''
default['crowd']['apache2']['port']               = 80
default['crowd']['apache2']['virtual_host_alias'] = node['fqdn']
default['crowd']['apache2']['virtual_host_name']  = node['hostname']

default['crowd']['apache2']['ssl']['access_log']       = ''
default['crowd']['apache2']['ssl']['chain_file']       = ''
default['crowd']['apache2']['ssl']['error_log']        = ''
default['crowd']['apache2']['ssl']['port']             = 443

case node['platform_family']
when 'rhel'
  default['crowd']['apache2']['ssl']['certificate_file'] = '/etc/pki/tls/certs/localhost.crt'
  default['crowd']['apache2']['ssl']['key_file']         = '/etc/pki/tls/private/localhost.key'
else
  default['crowd']['apache2']['ssl']['certificate_file'] = '/etc/ssl/certs/ssl-cert-snakeoil.pem'
  default['crowd']['apache2']['ssl']['key_file']         = '/etc/ssl/private/ssl-cert-snakeoil.key'
end

default['crowd']['database']['host']     = 'localhost'
default['crowd']['database']['name']     = 'crowd'
default['crowd']['database']['password'] = 'changeit'
default['crowd']['database']['port']     = 3306
default['crowd']['database']['testInterval'] = 2
default['crowd']['database']['type']     = 'mysql'
default['crowd']['database']['user']     = 'crowd'

default['crowd']['mysql_connector']['version']  = '5.1.31'
default['crowd']['mysql_connector']['checksum'] = '5a253a2aa8f06758c1901c3862402c69db601e9de456864ab1922955b225bba6'

default['crowd']['jvm']['minimum_memory']  = '512m'
default['crowd']['jvm']['maximum_memory']  = '768m'
default['crowd']['jvm']['maximum_permgen'] = '256m'
default['crowd']['jvm']['java_opts']       = ''
default['crowd']['jvm']['support_args']    = ''

default['crowd']['tomcat']['keyAlias']     = 'tomcat'
default['crowd']['tomcat']['keystoreFile'] = "#{node['crowd']['home_path']}/.keystore"
default['crowd']['tomcat']['keystorePass'] = 'changeit'
default['crowd']['tomcat']['port']         = '8095'
default['crowd']['tomcat']['ssl_port']     = '8443'
default['crowd']['context']                = 'crowd'
