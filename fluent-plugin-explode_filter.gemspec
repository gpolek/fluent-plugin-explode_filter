# coding: utf-8
Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-explode_filter"
  spec.version       = "0.3.0"
  spec.authors       = ["Grzegorz Polek", "Jonathan Serafini"]
  spec.email         = ["github@gpolek.com", "jonathan@serafini.ca"]

  spec.summary       = %{A fluentd filter plugin that will split period separated fields to nested hashes.}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/JonathanSerafini/fluent-plugin-explode_filter"
  spec.license       = "apache2"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = []
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"

  gem.add_dependency "fluentd", [">= 1.0", "< 2"]

  spec.add_runtime_dependency "fluent-plugin-mutate_filter", [">= 0.2.0", "<= 1.1.0"]
end
