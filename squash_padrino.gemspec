# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'squash/padrino/version'

Gem::Specification.new do |spec|
  spec.name          = "squash_padrino"
  spec.version       = Squash::Padrino::VERSION
  spec.authors       = ["Dylan Griffith"]
  spec.email         = ["dyl.griffith@gmail.com"]
  spec.summary       = %q{Integrates [squash](https://github.com/SquareSquash/web) logging into your padrino apps.}
  spec.description   = %q{Integrates [squash](https://github.com/SquareSquash/web) logging into your padrino apps.}
  spec.homepage      = "https://github.com/DylanGriffith/squash-padrino"
  spec.licenses      = ["Apache 2.0"]

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.add_runtime_dependency "squash_ruby", "~> 2.0"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
