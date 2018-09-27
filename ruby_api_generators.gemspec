lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby_api_generators/version'

Gem::Specification.new do |spec|
  spec.name          = 'ruby_api_generators'
  spec.version       = RubyApiGenerators::VERSION
  spec.authors       = ['Vitor Oliveira']
  spec.email         = ['vbrazo@gmail.com']
  spec.summary       = 'A collection of useful Ruby API generator scripts.'
  spec.description   = 'A collection of useful Ruby generator scripts for scaffolding APIs.'
  spec.homepage      = 'http://github.com/napice/ruby_api_generators'
  spec.license       = 'MIT'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'thor'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov', '0.16.1'
end
