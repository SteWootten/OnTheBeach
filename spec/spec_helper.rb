require 'simplecov'
SimpleCov.start

require_relative '../lib/job_list'
require_relative '../lib/job'
require_relative '../lib/exceptions/self_dependancy_error'
require_relative '../lib/exceptions/circular_dependancy_error'