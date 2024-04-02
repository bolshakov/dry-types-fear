# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "dry-types-fear"
  spec.version = "0.1.0"
  spec.authors = ["Tëma Bolshakov"]
  spec.email = ["either.free@gmail.com"]

  spec.summary = "Dry::Types integration with Fear."
  spec.description = "The gems enables you to use Fear::Option as optional type for Dry::Types"
  spec.homepage = "https://github.com/bolshakov/dry-types-fear"
  spec.required_ruby_version = ">= 3.0.0"
  spec.license = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "dry-types"
  spec.add_dependency "fear"
end
