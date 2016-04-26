# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'turnip/step_profiler/version'

Gem::Specification.new do |spec|
  spec.name          = 'turnip-step_profiler'
  spec.version       = Turnip::StepProfiler::VERSION
  spec.authors       = ['takkanm']
  spec.email         = ['takkanm@gmail.com']

  spec.summary       = %q{profiler for turnip steps}
  spec.description   = %q{profiler for turnip steps}
  spec.homepage      = 'https://github.com/takkanm/turnip-step_profiler'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'turnip', '~> 2.1'
  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
end
