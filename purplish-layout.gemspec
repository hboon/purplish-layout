# -*- encoding: utf-8 -*-
require File.expand_path('../lib/purplish-layout/version.rb', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'purplish-layout'
  gem.version       = PurplishLayout::VERSION
  gem.licenses      = ['BSD']

  gem.authors  = ['Hwee-Boon Yar']

  gem.description = 'A RubyMotion wrapper for Auto Layout on iOS and OS X'
  gem.summary = 'A RubyMotion wrapper for Auto Layout on iOS and OS X'
  gem.homepage = 'http://hboon.com/purplish-layout/'
  gem.email = 'hboon@motionobj.com'

  gem.add_dependency "weak_attr_accessor", "~> 0.0.2"
  gem.files       = `git ls-files`.split($\)
  gem.require_paths = ['lib']
  #gem.test_files  = gem.files.grep(%r{^spec/})
end
