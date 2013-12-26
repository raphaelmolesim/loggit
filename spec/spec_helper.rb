$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rspec'
require 'loggit'
require 'my_logger'
require 'activities'
require 'project'
require 'time_entry'
require 'redmine'
require 'importer'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

Loggit::LOGGIT_ENV = 'test'
MyLogger::LEVEL = :none

RSpec.configure do |config|
end