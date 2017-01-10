# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yeelight/version'

Gem::Specification.new do |spec|
  spec.name          = "yeelight"
  spec.version       = Yeelight::VERSION
  spec.authors       = ["Flipez"]
  spec.email         = ["code@brauser.io"]

  spec.summary       = 'Control Yeelight Bulbs'
  spec.description   = 'Control any Yeelight Bulb which is in develoment mode'
  spec.homepage      = "https://github.com/Flipez/yeelight"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
end
