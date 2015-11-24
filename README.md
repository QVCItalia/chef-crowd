## Deprecation warning

This recipe is no longer mantained and may not work on recent versions of Crowd.
We suggest you to look at https://github.com/afklm/crowd instead.

## Description

Installs/Configures [Atlassian Crowd](https://www.atlassian.com/software/crowd/) server.

## Requirements

### Platforms

* CentOS 6
* RHEL 6
* Ubuntu 12.04, 12.10, 13.04

### Chef

* The cookbook requires Chef 11 due to `ark` usage

### Databases

* HSQLDB (not recommended for production usage)
* MySQL
* Postgres
* Percona

### Cookbooks

Required [Opscode Cookbooks](https://github.com/opscode-cookbooks/)

* [apache2](https://github.com/opscode-cookbooks/apache2) (if using Apache 2 proxy)
* [ark](https://github.com/opscode-cookbooks/ark)
* [database](https://github.com/opscode-cookbooks/database)
* [java](https://github.com/opscode-cookbooks/java)
* [mysql](https://github.com/opscode-cookbooks/mysql) (if using MySQL database)
* [postgresql](https://github.com/opscode-cookbooks/postgresql) (if using Postgres database)

Third-Party Cookbooks

* [percona](https://github.com/phlipper/chef-percona) (if using Percona database)

## Attributes

These attributes are under the `node['crowd']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
checksum | SHA256 checksum for Crowd install | String | auto-detected (see attributes/default.rb)
home_path | home data directory for Crowd user | String | /var/atlassian/application-data/crowd
install_path | location to install Crowd | String | /opt/atlassian
install_type | Crowd install type - "standalone" only for now | String | standalone
url_base | URL base for Crowd install | String | http://www.atlassian.com/software/crowd/downloads/binary/atlassian-crowd
url | URL for Crowd install | String | auto-detected (see attributes/default.rb)
user | user to run Crowd | String | crowd
version | Crowd version to install | String | 2.7.2

### Crowd Database Attributes

All of these `node['crowd']['database']` attributes are overridden by `crowd/crowd` encrypted data bag (Hosted Chef) or data bag (Chef Solo), if it exists

Attribute | Description | Type | Default
----------|-------------|------|--------
host | FQDN or "localhost" (localhost automatically installs `['database']['type']` server) | String | localhost
name | Crowd database name | String | crowd
password | Crowd database user password | String | changeit
port | Crowd database port | Fixnum | 3306
testInterval | Crowd database pool idle test interval in minutes | Fixnum | 2
type | Crowd database type - "hsqldb" (not recommended), "mysql", "percona" or "postgresql" | String | mysql
user | Crowd database user | String | crowd

### Crowd JVM Attributes

These attributes are under the `node['crowd']['jvm']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
minimum_memory | JVM minimum memory | String | 512m
maximum_memory | JVM maximum memory | String | 768m
maximum_permgen | JVM maximum PermGen memory | String | 256m
java_opts | additional JAVA_OPTS to be passed to Crowd JVM during startup | String | ""
support_args | additional JAVA_OPTS recommended by Atlassian support for Crowd JVM during startup | String | ""

### Crowd Tomcat Attributes

These attributes are under the `node['crowd']['tomcat']` namespace.

Any `node['crowd']['tomcat']['key*']` attributes are overridden by `crowd/crowd` encrypted data bag (Hosted Chef) or data bag (Chef Solo), if it exists

Attribute | Description | Type | Default
----------|-------------|------|--------
keyAlias | Tomcat SSL keystore alias | String | tomcat
keystoreFile | Tomcat SSL keystore file - will automatically generate self-signed keystore file if left as default | String | `#{node['crowd']['home_path']}/.keystore`
keystorePass | Tomcat SSL keystore passphrase | String | changeit
port | Tomcat HTTP port | Fixnum | 8095
ssl_port | Tomcat HTTPS port | Fixnum | 8443
context | Tomcat context | String | ""

## Recipes

* `recipe[crowd]` Installs Atlassian Crowd with built-in Tomcat and Apache 2 proxy
* `recipe[crowd::apache2]` Installs/configures Apache 2 proxy for Crowd (ports 80/443)
* `recipe[crowd::configuration]` Configures Crowd's settings
* `recipe[crowd::database]` Installs/configures MySQL/Percona/Postgres server, database, and user for Crowd
* `recipe[crowd::linux_standalone]` Installs/configures Crowd via Linux standalone archive
* `recipe[crowd::service_init]` Installs/configures Crowd init service
* `recipe[crowd::tomcat_configuration]` Configures Crowd's built-in Tomcat

## Contributing

Please use standard Github issues/pull requests.

## License and Contributors

Please see license information in: [LICENSE](LICENSE)

* Sergio Leone <sergio.leone@qvc.com>
