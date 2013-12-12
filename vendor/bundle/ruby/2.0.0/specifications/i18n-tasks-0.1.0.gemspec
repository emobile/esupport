# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "i18n-tasks"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["glebm"]
  s.date = "2013-08-29"
  s.description = "Rails I18n tasks to find missing / unused translations and more"
  s.email = ["glex.spb@gmail.com"]
  s.homepage = "https://github.com/glebm/i18n-tasks"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.3"
  s.summary = "Rails I18n tasks to find missing / unused translations and more"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 0"])
      s.add_runtime_dependency(%q<rake>, [">= 0"])
      s.add_runtime_dependency(%q<term-ansicolor>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec-rails>, [">= 0"])
    else
      s.add_dependency(%q<rails>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<term-ansicolor>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec-rails>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<term-ansicolor>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec-rails>, [">= 0"])
  end
end
