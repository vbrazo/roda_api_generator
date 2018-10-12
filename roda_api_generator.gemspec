lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'roda_api_generator/version'

Gem::Specification.new do |spec|
  spec.name          = 'roda_api_generator'
  spec.version       = RubyApiGenerators::VERSION
  spec.authors       = ['Vitor Oliveira']
  spec.email         = ['vbrazo@gmail.com']
  spec.summary       = 'A collection of useful Ruby API generator scripts.'
  spec.description   = 'A collection of useful Ruby generator scripts for scaffolding APIs.'
  spec.homepage      = 'http://github.com/napice/roda_api_generator'
  spec.license       = 'MIT'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'thor'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '0.59.2'
  spec.add_development_dependency 'simplecov', '0.16.1'
end
