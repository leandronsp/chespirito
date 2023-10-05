# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name        = 'chespirito'
  spec.version     = '0.0.5'
  spec.summary     = 'Chespirito Ruby web framework'
  spec.description = 'A dead simple, yet Rack-compatible, web framework written in Ruby'
  spec.authors     = ['Leandro Proença']
  spec.email       = 'leandronsp@gmail.com'
  spec.files       = Dir['lib/**/*'] + %w[Gemfile Gemfile.lock README.md chespirito.gemspec]
  spec.homepage    = 'https://github.com/leandronsp/chespirito'
  spec.license     = 'MIT'

  spec.add_runtime_dependency 'rack'
  spec.add_runtime_dependency 'adelnor'

  spec.required_ruby_version = '~> 3.0'
end
