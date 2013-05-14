$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "widgets/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "widgets"
  s.version     = Widgets::VERSION
  s.authors     = ['Sujoy Gupta']
  s.email       = ['sujoyg@gmail.com']
  s.summary     = 'A simple framework to create reusable widgets for Rails applications.'

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency 'guid'
  s.add_dependency 'jquery-rails', '~> 2.2.0'
  s.add_dependency 'rails', '~> 3.2.11'

  s.add_development_dependency 'rspec-core', '~> 2.12.2'
  s.add_development_dependency 'rspec-rails', '~> 2.12.2'
  s.add_development_dependency 'specstar-controllers', '~> 0.0.9'
  s.add_development_dependency 'specstar-support-random', '~> 0.0.9'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'webrat'
end
