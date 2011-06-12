require "lib/version"

Gem::Specification.new do |s|
  s.name              = "cenum"
  s.version           = Kernel::Enum::VERSION
  s.platform          = Gem::Platform::RUBY
  s.authors           = ["Shane Gibbons"]
  s.email             = ["shane.r.gibbons@gmail.com"]
  s.homepage          = "https://github.com/microsage/cenum"
  s.summary           = %q{This project is an attempt to provide c-style enums for ruby. It's obviously impossible (and not even desirable) to capture the exact syntax and semantics of c's enums in a ruby implementation, but the major capabilities and usage patterns are supported.}

  s.files             = %W( README.md MIT-LICENSE.txt)
  s.files             += Dir.glob("lib/*")

  s.test_files        = Dir.glob("spec/*")
end
