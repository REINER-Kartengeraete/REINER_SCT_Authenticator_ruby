require './lib/rsct_otp/version'

Gem::Specification.new do |s|
  s.name        = 'rsct_otp'
  s.version     = RSCT_OTP::VERSION
  s.platform    = Gem::Platform::RUBY
  s.required_ruby_version = '~> 2.3'
  s.license     = 'MIT'
  s.authors     = ['Marek Kralewski', 'Benjamin Udiljak']
  s.email       = ['info@tuxwerk.de']
  s.summary     = 'A Ruby library for generating and verifying one time passwords'
  s.description = 'Works for TOTP and includes QR Code provisioning'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_runtime_dependency 'addressable', '~> 2.7'

  s.add_development_dependency "rake", "~> 13.0"
  s.add_development_dependency 'rspec', '~> 3.5'
  s.add_development_dependency 'simplecov', '~> 0.12'
end
