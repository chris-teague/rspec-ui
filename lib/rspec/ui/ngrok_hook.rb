require 'httparty'
require 'locoyo'

module RSpec
  module Ui

    class NgrokHook

      ConfigFile = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', 'config', 'ngrok-config-testing'))
      @@current_port = nil

      def self.update_port(port)
        return if @@current_port == port
        shutdown

        tunnel = Locoyo::Tunnel.new(
          port:      port,
          address:  '127.0.0.1',
          protocol: 'http'
        )
        tunnel.run

        sleep(3)
        subdomain = tunnel.get_subdomain
        update_browser_army(subdomain)

        puts "View on http://uxspec.com/#{UxSpec.configuration.token}"
        @@current_port = port
      end

      def self.shutdown
        # TODO
      end

      def self.update_browser_army(subdomain)
        HTTParty.patch("https://#{UxSpec.configuration.uxspec_uri}/#{UxSpec.configuration.token}.json", body: { project: { ngrok_id: subdomain, ngrok_port: @@current_port }}).body
      end

    end

  end
end
