require 'bundler'
Bundler.setup
require 'rubygems'
require "capybara"
require "capybara/dsl"
require "capybara/rspec"
require "pry"
require 'rspec'
require 'selenium-webdriver'


driver = Capybara.register_driver :firefox do |app|
	Capybara::Selenium::Driver.new(
		app, 
	  	browser: :firefox,
	  	desired_capabilities: Selenium::WebDriver::Remote::Capabilities.firefox
	)
end
Capybara.default_driver = :firefox
Capybara.current_driver = :firefox
Capybara.default_max_wait_time = 5


RSpec.configure do |config|
	config.run_all_when_everything_filtered = true
	config.filter_run focus: true
	config.tty = true

	config.after(:each) do
		Capybara.reset_sessions!
	end
end
