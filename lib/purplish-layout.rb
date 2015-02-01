unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

Motion::Project::App.setup do |app|
  Dir.glob(File.join(File.dirname(__FILE__), 'purplish-layout/**/*.rb')).each do |file|
    app.files.unshift(file)
  end
end

require 'weak_attr_accessor'
