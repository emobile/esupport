# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "i18n-missing_translations"
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sven Fuchs"]
  s.date = "2012-02-27"
  s.description = "Find missing translations in your code more easily."
  s.email = "svenfuchs@artweb-design.de"
  s.homepage = "http://github.com/svenfuchs/i18n-missing_translations"
  s.require_paths = ["lib"]
  s.rubyforge_project = "[none]"
  s.rubygems_version = "2.0.3"
  s.summary = "Find missing translations in your code more easily"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<i18n>, ["~> 0.6.0"])
      s.add_development_dependency(%q<test_declarative>, [">= 0"])
    else
      s.add_dependency(%q<i18n>, ["~> 0.6.0"])
      s.add_dependency(%q<test_declarative>, [">= 0"])
    end
  else
    s.add_dependency(%q<i18n>, ["~> 0.6.0"])
    s.add_dependency(%q<test_declarative>, [">= 0"])
  end
end
