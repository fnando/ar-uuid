require "./lib/active_record/uuid/version"

Gem::Specification.new do |spec|
  spec.name          = "ar-uuid"
  spec.version       = ActiveRecord::UUID::VERSION
  spec.authors       = ["Nando Vieira"]
  spec.email         = ["fnando.vieira@gmail.com"]
  spec.summary       = %[Add UUID support for ActiveRecord. It enforces uuid primary keys, fixes ActiveRecord's first/last methods and more.]
  spec.description   = spec.summary
  spec.homepage      = "http://rubygems.org/gems/ar-uuid"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) {|f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest-utils"
  spec.add_development_dependency "mocha"
  spec.add_development_dependency "pg"
  spec.add_development_dependency "pry-meta"
  spec.add_development_dependency "simplecov"
end
