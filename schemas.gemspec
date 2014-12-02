lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "schemas"

Gem::Specification.new do |s|
  s.name = "schemas"
  s.version = Schemas::VERSION
  s.summary = "A schema parsing and validation library for Ruby"
  s.authors = ["Sumeet Agarwal"]
  s.email = "sumeet.a@gmail.com"
  s.files = Dir["lib/**/*.rb"]
  s.homepage = "https://github.com/sumeet/schemas"
  s.license = "MIT"

  s.add_development_dependency "rspec"
  s.add_runtime_dependency "activesupport"
end
