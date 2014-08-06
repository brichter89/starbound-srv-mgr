# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'StarboundSrvMgr/version'

Gem::Specification.new do |spec|
    spec.name          = 'starbound-srv-mgr'
    spec.version       = StarboundSrvMgr::VERSION
    spec.authors       = ['Björn Richter']
    spec.email         = ['x3ro1989@gmail.com']
    spec.summary       = %q{Starbound Server Manager}
    spec.description   = %q{An init script and a cli for managing a starbound server, using a ramdisk for the "world" } +
                         %q{files while doing regular backups of the "world"}
    spec.homepage      = 'https://github.com/brichter89/starbound-srv-mgr'
    spec.license       = 'GPL'

    spec.files         = `git ls-files -z`.split("\x0")
    spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
    spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
    spec.require_paths = ['lib']

    spec.add_development_dependency 'bundler', '~> 1.6'
    spec.add_development_dependency 'rake', '~> 10.0'
    spec.add_development_dependency 'rspec', '~> 2.6'
end
