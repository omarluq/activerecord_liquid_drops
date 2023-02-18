# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name                           = 'activerecord_liquid_drops'
  s.version                        = '0.0.0'
  s.required_ruby_version          = '>= 2.6'
  s.summary                        = 'Liquid langaue drops for ActiveRecord models'
  s.description                    = 'Adds support for creating liquid language drop classes for ActiveRecord models and assign drops as attributes'
  s.authors                        = ['Omar Luqman']
  s.files                          = ['lib/active_record_liquid_drops.rb']
  s.homepage                       = 'https://github.com/omarluq/activerecord_liquid_drops'
  s.license                        = 'MIT'
  s.metadata['homepage_uri']       = s.homepage
  s.metadata['source_code_uri']    = s.homepage

  s.add_dependency 'activerecord'
  s.add_dependency 'liquid'

  s.add_development_dependency 'overcommit'
  s.add_development_dependency 'rubocop'
end
