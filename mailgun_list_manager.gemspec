$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mailgun_list_manager/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mailgun_list_manager"
  s.version     = MailgunListManager::VERSION
  s.authors     = ["Noémien Kocher"]
  s.email       = ["nkcr.je@gmail.com"]
  s.homepage    = "https://github.com/JS-Tech/mailgun_list_manager"
  s.summary     = "Interface to manager mailing list from Mailgun."
  s.description = "This rails plugin provides a simple page giving the ability to add, edit and remove Mailgun mailing lists."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.6"
  s.add_dependency "mailgun"
  s.add_dependency "sass-rails", "~> 5.0"
  s.add_dependency "jquery-rails"
  s.add_dependency "adeia"

  s.add_development_dependency "sqlite3"
end
