require "pry"

require "rails"
require "capybara"
require "rspec/ui/version"
require "rspec/ui/ngrok_hook"
require 'rspec/ui/dsl'
require 'rspec'

class RackTestWithServer < Capybara::RackTest::Driver
  def needs_server?;true;end
end

Capybara.register_driver :rack_test_with_server do |app|
  RackTestWithServer.new(app)
end

Capybara.configure do |config|
  config.default_driver = :rack_test_with_server
end

if Rails.env.test?
  RSpec.configure do |config|
    config.around(:example) do |ex|
      Capybara.current_session.driver.header('X-Frame-Options', 'ALLOW-FROM https://uxspec.com')
      RSpec::Ui::NgrokHook.update_port(Capybara.current_session.server.port)
      ex.run
      sleep(500)
    end

    # config.after(:suit) do |ex|
    #   RSpec::Ui::NgrokHook.shutdown
    # end
  end
end
