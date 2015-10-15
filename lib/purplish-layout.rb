unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

Motion::Project::App.setup do |app|
  Dir.glob(File.join(File.dirname(__FILE__), 'purplish-layout/**/*.rb')).each do |file|
    exclude = false
    if Motion::Project::App.osx?
      if file.include? '/ios/'
        exclude = true
      end
    else
      if file.include? '/osx/'
        exclude = true
      end
    end
    app.files.unshift(file) unless exclude
  end
end

require 'weak_attr_accessor'
