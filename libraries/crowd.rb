# Chef class
class Chef
  # Chef::Recipe class
  class Recipe
    # Chef::Recipe::Crowd class
    class Crowd
      def self.settings(node)
        begin
          if Chef::Config[:solo]
            begin
              settings = Chef::DataBagItem.load('crowd', 'crowd')['local']
            rescue
              Chef::Log.info('No crowd data bag found')
            end
          else
            begin
              settings = Chef::EncryptedDataBagItem.load('crowd', 'crowd')[node.chef_environment]
            rescue
              Chef::Log.info('No crowd encrypted data bag found')
            end
          end
        ensure
          settings ||= node['crowd']
          settings['database']['port'] ||= default_database_port settings['database']['type']
          settings['database']['testInterval'] ||= 2
        end

        settings
      end

      def default_database_port(type)
        case type
        when 'mysql', 'percona'
          3306
        when 'postgresql'
          5432
        when 'sqlserver'
          1433
        else
          Chef::Log.warn("Unsupported database type (#{type}) in crowd cookbook.")
          Chef::Log.warn('Please add to crowd cookbook or hard set crowd database port.')
          nil
        end
      end
    end
  end
end
