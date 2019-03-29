lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "k2e/version"

Gem::Specification.new do |spec|
  spec.name          = "k2e"
  spec.version       = K2e::VERSION
  spec.authors       = ["ttuan"]
  spec.email         = ["tuantv.nhnd@gmail.com"]

  spec.summary       = %q{A tool to synchronize Kindle highlights to Evernote.}
  spec.homepage      = "https://github.com/ttuan/k2e"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  #   spec.metadata["homepage_uri"] = spec.homepage
  #   spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  #   spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.executables   = `git ls-files -- bin/*`.split("\n").map { |f| ::File.basename(f) }
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.0.0"

  spec.add_dependency "kindleclippings", "~> 1.4", ">= 1.4.0"
  spec.add_dependency "evernote_oauth",  "~> 0.2.3"
  spec.add_dependency "dotenv",          "~> 2.6.0", ">= 2.6.0"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry", "~> 0.12.2"
end
