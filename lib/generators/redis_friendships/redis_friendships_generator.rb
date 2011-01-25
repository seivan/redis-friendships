require 'rails/generators/base'
require 'rails/generators/migration'

class RedisFriendshipsGenerator < Rails::Generators::Base #:nodoc:
    include Rails::Generators::Migration
    source_root File.expand_path('../templates', __FILE__)
      
      argument :friendship_name, :type => :string, :default => 'friendship', :banner => 'friendship_name'
      argument :user_name, :type => :string, :default => 'user', :banner => 'user_name'
      argument :redis_constant_name, :type => :string, :default => "R", :banner => "redis_constant_name"


      def create_model_files
        if File.exist?(File.join(Dir.pwd, "app", "models", "#{user_singular_name}.rb"))
          template('user_injection_code.rb', "temp_file.rb") #I need to READ this with the erb in it
          code = IO.read(File.join(Dir.pwd,"temp_file.rb"))
          inject_into_class(File.join(Dir.pwd, "app", "models", "#{user_singular_name}.rb"), user_class_name, code)
          File.delete(File.join(Dir.pwd,"temp_file.rb"))
        else
          template 'user.rb', "app/models/#{user_singular_name}.rb"
      end
        template 'friendship.rb', "app/models/#{friendship_singular_name}.rb"
      end
      
      def create_migration
        migration_template 'user_migration.rb', "db/migrate/create_#{user_plural_name}.rb" if File.exist?(File.join(Dir.pwd, "app", "models", "#{user_singular_name}.rb"))
      end

      def add_gems_and_initializer
        unless File.read(destination_path("Gemfile")).include? "redis"
          gem "redis" 
          template"redis.rb", "config/initializers/redis.rb"
        end
      end
            
      private
      def friendship_singular_name
        friendship_name.underscore.singularize
      end
      
      def friendshipplural_name
        friendship_singular_name.pluralize
      end
      
      def friendship_class_name
        friendship_name.singularize.camelize
      end
      
      def friendship_plural_class_name
        friendship_plural_name.camelize
      end
            
      def user_singular_name
        user_name.underscore.singularize
      end
      
      def user_plural_name
        user_singular_name.pluralize
      end
      
      def user_class_name
        user_name.singularize.camelize
      end
      
      def user_plural_class_name
        user_plural_name.camelize
      end
      
      def destination_path(path)
        File.join(destination_root, path)
      end
      
      # FIXME: Should be proxied to ActiveRecord::Generators::Base
      # Implement the required interface for Rails::Generators::Migration.
      
      def self.next_migration_number(dirname) #:nodoc:
        if ActiveRecord::Base.timestamped_migrations
          Time.now.utc.strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end
      

      # 
      # def self.banner
      #   "#{$0} seivan:#{generator_name} #{self.arguments.map{ |a| a.usage }.join(' ')} [options]"
      # end

end
