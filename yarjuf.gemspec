Gem::Specification.new do |s|
  s.name        = "yarjuf"
  s.version     = "1.0"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nat Ritmeyer"]
  s.email       = ["nat@natontesting.com"]
  s.homepage    = "http://github.com/natritmeyer/yarjuf"
  s.summary     = "Yet Another RSpec JUnit Formatter (for Hudson/Jenkins)"
  s.description = "Yet Another RSpec JUnit Formatter (for Hudson/Jenkins)"
  s.files        = Dir.glob("lib/**/*") + %w(LICENSE README.md)
  s.require_path = 'lib'
  s.add_dependency('rspec', '>= 2.0.0')
end

